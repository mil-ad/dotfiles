export GOPATH="$HOME/.local/share/go"

# so that scripts are available in dmenu_run:
export PATH=$PATH:~/.scripts:~/.local/bin:~/Application

# Wayland settings
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export MOZ_ENABLE_WAYLAND=1

[ -e $HOME/.zprofile_local ] && source $HOME/.zprofile_local

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
