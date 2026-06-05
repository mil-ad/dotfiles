# Inspired by https://silverrainz.me/blog/2025-09-systemd-fzf-aliases.html

# Path to this file, captured at source time, so fzf reload actions running in
# a child shell can re-source it to reach _sls_gen.
_S_FILE=${(%):-%x}

# Emit the unit names for one scope, one per line, each prefixed with a hidden
# scope column ("system"/"user"). fzf hides the scope from view (--with-nth)
# but returns it on accept (--accept-nth) so callers know which scope to act on.
# Only the unit name is shown, so there is nothing to truncate and the whole
# name stays searchable; state/description live in the preview pane.
_sls_gen() {
    local scope=${1:---system}
    local state=${2:-active,failed}
    {
        systemctl "$scope" list-units --legend=false --state="$state"
        # list-unit-files is slow (~0.7s system-wide) and only surfaces
        # on-disk units that aren't loaded; skip it unless the requested
        # state actually needs a file-state listing.
        case $state in
            *disabled*|*static*|*enabled*|*masked*|*generated*|*indirect*|*linked*|*alias*)
                systemctl "$scope" list-unit-files --legend=false --state="$state" ;;
        esac
    } \
    | awk -v sc="${scope#--}" '{ gsub(/●/, ""); if ($1 != "" && !seen[$1]++) print sc, $1 }'
}

# Interactive picker. Starts in --system scope; ctrl-u / ctrl-s switch the list
# to user / system scope. Prints "<scope> <unit>" for each selected row.
sls() {
    local state=${1:-active,failed}
    local file=${(q)_S_FILE}
    # ctrl-u toggles scope: pick the reload action based on the current prompt.
    local to_user="change-prompt(user> )+reload(source $file; _sls_gen --user $state)"
    local to_system="change-prompt(system> )+reload(source $file; _sls_gen --system $state)"
    _sls_gen --system "$state" \
    | fzf --with-shell 'zsh -c' \
          --with-nth=2 \
          --accept-nth=1,2 \
          --multi \
          --no-hscroll \
          --prompt 'system> ' \
          --bind "ctrl-u:transform:[[ \$FZF_PROMPT == system* ]] && echo '$to_user' || echo '$to_system'" \
          --preview="SYSTEMD_COLORS=1 systemctl --{1} status {2}" \
          --preview-window=down:wrap \
          --preview-label=' ctrl-l: journal logs · ctrl-u: toggle user/system scope ' \
          --preview-label-pos=bottom \
          --bind="ctrl-l:execute(SYSTEMD_COLORS=1 journalctl --{1} -u {2} -n 200 --no-pager | less -R)"
}

# Run `systemctl <action>` against the units picked via sls, dispatching to the
# right scope (sudo for system, --user otherwise) based on the picker's output.
_sls_act() {
    local action=$1 state=$2
    local out; out=$(sls "$state") || return
    [[ -n $out ]] || return
    local -a rows=( "${(@f)out}" )
    local scope=${rows[1]%%[[:space:]]*}
    local -a units=()
    local row
    for row in "${rows[@]}"; do
        [[ -n $row ]] && units+=( "${row##*[[:space:]]}" )
    done
    if [[ $scope == system ]]; then
        sudo systemctl "$action" "${units[@]}"
    else
        systemctl --user "$action" "${units[@]}"
    fi
}

sstart()   { _sls_act start   static,disabled,failed }
sstop()    { _sls_act stop    running,failed }
srestart() { _sls_act restart active,failed }
senable()  { _sls_act enable  disabled,static }
sdisable() { _sls_act disable enabled }
