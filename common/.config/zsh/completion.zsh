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
zstyle ':completion:*:*:*:*:*' menu select

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# completion for GNU make (see https://github.com/zsh-users/zsh-completions/issues/813#issuecomment-902592371)
# zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

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

# ... unless we really want to.
zstyle '*' single-ignored show

if [[ ${COMPLETION_WAITING_DOTS:-false} != false ]]; then
  expand-or-complete-with-dots() {
    # use $COMPLETION_WAITING_DOTS either as toggle or as the sequence to show
    [[ $COMPLETION_WAITING_DOTS = true ]] && COMPLETION_WAITING_DOTS="%F{red}…%f"
    # turn off line wrapping and print prompt-expanded "dot" sequence
    printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  # Set the function as the default tab completion widget
  bindkey -M emacs "^I" expand-or-complete-with-dots
  bindkey -M viins "^I" expand-or-complete-with-dots
  bindkey -M vicmd "^I" expand-or-complete-with-dots
fi

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# Use the same file-type colors in the completion menu as `ls` does.
# (LS_COLORS is exported from exports.zsh — make sure that's sourced first.)
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
