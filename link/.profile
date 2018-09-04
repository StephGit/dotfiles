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

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

export PATH=/opt/apps/sdk-tools-linux-4333796/tools:/opt/apps/sdk-tools-linux-4333796/tools/bin:$PATH
