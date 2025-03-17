xrdb -merge $HOME/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Setup keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

case $(hostnamectl --static) in
	milad-matebook14s)
		xbindkeys -f $HOME/.config/xbindkeys/matebook14s
		;;
	thinkpad-p1)
		xbindkeys -f $HOME/.config/xbindkeys/thinkpad-p1
		;;
	milad-ryzen)
		xrandr --output DP-0 --mode 2560x2880 --pos 0x0 --primary --output HDMI-0 --off
		;;
esac

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_STYLE_OVERRIDE=adwaita-dark
export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
export QT_ENABLE_HIGHDPI_SCALING=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GTK_THEME=Adwaita:dark

# e.g. clipmenud relies on this
systemctl --user import-environment DISPLAY

exec i3
