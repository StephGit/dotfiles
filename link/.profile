# set keyboardlayout
# list all the layouts: localectl list-x11-keymap-layouts
setxkbmap ch

# set the dpi for high resolution display
# xrandr --dpi 180

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

