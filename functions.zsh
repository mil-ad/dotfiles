function jqp () {
    jq -C "$@" | less -R
}

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}

function man() {
    env \
        LESS_TERMCAP_md=$(tput bold; tput setaf 4) \
        LESS_TERMCAP_me=$(tput sgr0) \
        LESS_TERMCAP_mb=$(tput blink) \
        LESS_TERMCAP_us=$(tput setaf 2) \
        LESS_TERMCAP_ue=$(tput sgr0) \
        LESS_TERMCAP_so=$(tput smso) \
        LESS_TERMCAP_se=$(tput rmso) \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        GROFF_NO_SGR=1 \
        man "$@"
}

