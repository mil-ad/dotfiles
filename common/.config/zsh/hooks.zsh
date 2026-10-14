# Reset terminal modes a dead ssh session (laptop sleep etc.) leaves behind:
# mouse tracking, focus reporting, hidden cursor, alternate screen.
#
# Only position-neutral sequences belong here, it runs before every prompt.
# \e7 saves the cursor first because xterm-style emulators (Ghostty, herdr)
# restore it on ?1049l even when already on the primary screen.
# Bracketed paste is left alone; zle re-enables it after precmd anyway.
_disarm_terminal() {
  [[ -t 1 ]] || return
  printf '%s' $'\e7\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1004l\e[?1049l\e[?25h'
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _disarm_terminal
