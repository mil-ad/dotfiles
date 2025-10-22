# Inspired by https://silverrainz.me/blog/2025-09-systemd-fzf-aliases.html

sls() {
    local scope=${1:---system}
    local state=${2:-active,failed}
    cat \
        <(echo 'UNIT/FILE LOAD/STATE ACTIVE/PRESET SUB DESCRIPTION') \
        <(systemctl "$scope" list-units --legend=false --state="$state") \
        <(systemctl "$scope" list-unit-files --legend=false --state="$state") \
    | sed 's/●/ /' \
    | grep . \
    | column --table --table-columns-limit=5 \
    | fzf --header-lines=1 \
          --accept-nth=1 \
          --no-hscroll \
          --preview="SYSTEMD_COLORS=1 systemctl "$scope" status {1}" \
          --preview-window=down
}

# xargs's -r means --no-run-if-empty

sstart()   { sls --system static,disabled,failed | xargs -r sudo systemctl start }
sstop()    { sls --system running,failed | xargs -r sudo systemctl stop }
srestart() { sls --system | xargs -r sudo systemctl restart }

ustart()   { sls --user static,disabled,failed | xargs -r systemctl --user start }
ustop()    { sls --user running,failed | xargs -r systemctl --user stop }
urestart() { sls --user | xargs -r systemctl --user restart }
