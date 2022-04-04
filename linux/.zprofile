if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  
  # so that scripts are available in dmenu_run:
  export PATH=$PATH:~/.scripts
  
  exec startx
fi
