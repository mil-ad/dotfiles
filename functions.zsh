jqp () {
    jq -C "$@" | less -R
}

d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}

man () {
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

va () {
    source .venv/bin/activate 2>/dev/null || source ../.venv/bin/activate 2>/dev/null || echo 'no .env found in this or parent directory' && false
}

va! () {
    va || vc && va
}

vc () {
    uv venv --seed --python-preference managed "$@"
}

vd () { deactivate; }

vrm () { rm -rf .venv; }

tmp () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

