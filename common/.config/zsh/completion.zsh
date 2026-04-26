# ------------------------------------------------------------------
# Tab completion
# ------------------------------------------------------------------
# `compinit` is zsh's completion engine bootstrap: it scans $fpath for
# completion functions (the _foo files), audits their permissions, and
# builds a "dump" file (an index of command -> completion function).
# It's the single biggest cost in shell startup, so we cache aggressively.

# Behavior options
unsetopt menu_complete    # don't autoselect the first completion entry
setopt auto_menu          # show menu on successive tab press
setopt complete_in_word   # completion works mid-word, not just at the end
setopt always_to_end      # move cursor to end of word after completion

# Show an interactive menu when tab-completing, navigable with arrow keys.
zstyle ':completion:*' menu select
# Load the menu-selection module compinit needs for the above.
zmodload -i zsh/complist

autoload -Uz compinit

# Keep the dump out of $HOME — XDG-clean. Versioned per zsh release so
# upgrades don't try to load an incompatible dump.
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${_zcompdump:h}"

# Two paths:
#   - fast: dump is < 24h old -> trust it, skip the security audit (-C).
#   - slow: dump is missing or stale -> full audit + rebuild (runs once a day).
# The glob qualifier (#qNmh-24) matches the file only if it was modified
# less than 24 hours ago (N=nullglob, m=mtime, h=hours, -=less than).
if [[ -n $_zcompdump(#qNmh-24) ]]; then
  compinit -C -d "$_zcompdump"
else
  compinit -d "$_zcompdump"
fi

# Pre-compile the dump to bytecode (.zwc) so the next shell loads it
# via mmap instead of parsing text. Only recompile when the dump changes.
if [[ -s $_zcompdump && (! -s ${_zcompdump}.zwc || $_zcompdump -nt ${_zcompdump}.zwc) ]]; then
  zcompile "$_zcompdump"
fi
unset _zcompdump

# Make tab-completion match dotfiles too (e.g. `cd .config/<TAB>`).
_comp_options+=(globdots)

# Shift-Tab cycles backward through the completion menu.
bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete

# In the menu: Ctrl-O accepts the current selection then opens the next menu
# (handy for stepping through nested paths).
bindkey -M menuselect '^o' accept-and-infer-next-history

# Case-insensitive matching, partial-word, and substring completion.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable.
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion"

# completion for GNU make (see https://github.com/zsh-users/zsh-completions/issues/813#issuecomment-902592371)
zstyle ':completion:*:*:make:*' tag-order 'targets'

_ssh_configfile="$HOME/.ssh/config"
if [[ -f "$_ssh_configfile" ]]; then
  _ssh_hosts=($(
    grep -E '^Host.*' "$_ssh_configfile" |\
    awk '{for (i=2; i<=NF; i++) print $i}' |\
    sort |\
    uniq |\
    grep -v '^*' |\
    sed -e 's/\.*\*$//'
  ))
  zstyle ':completion:*:hosts' hosts $_ssh_hosts
  unset _ssh_hosts
fi
unset _ssh_configfile

zstyle '*' single-ignored show

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# Use the same file-type colors in the completion menu as `ls` does.
# (LS_COLORS is exported from exports.zsh — make sure that's sourced first.)
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
