source ~/.common_sh_stuff

# functionallity for the 'sm' command, that let's one switch
# the user but keeping it's own environment
export INIT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # dir this script is in
export HOME_DIR=$(eval echo ~$(id -un)) # home dir of current user

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" -a src
}

# make sure to use right history file
HISTFILE=$HOME_DIR/.bash_history

# use my tmux.conf if it exists
if [ -r $INIT_DIR/.tmux.conf ]; then
  alias tmux="HOME=$INIT_DIR tmux -f $INIT_DIR/.tmux.conf"
fi

export HOME=$HOME_DIR

#keychain id_rsa
#. ~/.keychain/`uname -n`-sh

cd $HOME
unset INIT_DIR
