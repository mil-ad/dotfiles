export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"

# so that scripts are available in dmenu_run:
export PATH=$PATH:~/.scripts:~/.local/bin:~/Application

export HOMEBREW_NO_ANALYTICS=1

# Wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export ELECTRON_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1

export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
export QT_ENABLE_HIGHDPI_SCALING=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1

[ -e $HOME/.zprofile_local ] && source $HOME/.zprofile_local

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
