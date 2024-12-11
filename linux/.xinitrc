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
		#xrandr --output eDP-1 --mode 3840x2400 --pos 2560x1792 --output DP-2-1-5 --primary --mode 2560x2880 --pos 0x0 --rotate normal
		;;
	milad-ryzen)
		# xrandr --output DP-0 --mode 3840x2160 --pos 0x80 --primary --scale 1x1 --output HDMI-0 --mode 1920x1080 --pos 3840x0 --rotate left --scale 1.5x1.5
		# xrandr --output DP-0 --mode 2560x1440 --pos 0x0 --primary --output HDMI-0 --mode 2560x1440 --pos 0x1440 --below DP-0 --rotate normal
		xrandr --output DP-0 --mode 2560x2880 --pos 0x0 --primary --output HDMI-0 --off
		;;
esac

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_STYLE_OVERRIDE=adwaita-dark
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_ENABLE_HIGHDPI_SCALING=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GTK_THEME=Adwaita:dark

# e.g. clipmenud relies on this
systemctl --user import-environment DISPLAY

exec i3
