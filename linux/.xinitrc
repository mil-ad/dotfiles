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

#xrandr --output DP-0 --mode 3840x2160 --pos 0x0 --primary --scale 1.3x1.3

#export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_STYLE_OVERRIDE=adwaita-dark

setxkbmap gb,ir -option 'grp:rctrl_rshift_toggle'

exec i3
