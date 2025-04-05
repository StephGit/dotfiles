xrdb -merge ~/.Xresources
dbus-update-activation-environment --systemd DISPLAY

export SSH_AUTH_SOCK
exec i3
