export GOPATH="$HOME/.local/share/go"

# so that scripts are available in dmenu_run:
export PATH=$PATH:~/.scripts:~/.local/bin:~/Application
  
[ -e $HOME/.zprofile_local ] && source $HOME/.zprofile_local

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
