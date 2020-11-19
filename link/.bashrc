# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# functionallity for the 'sm' command, that let's one switch
# the user but keeping it's own environment
export INIT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # dir this script is in
export HOME_DIR=$(eval echo ~$(id -un)) # home dir of current user

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

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

#ssh-add
if [ ! -S $INIT_DIR/.ssh/ssh_auth_sock ]; then
	  eval `ssh-agent`
	    ln -sf "$SSH_AUTH_SOCK" $INIT_DIR/.ssh/ssh_auth_sock
fi
src

#keychain id_rsa
#. ~/.keychain/`uname -n`-sh

cd $HOME
unset INIT_DIR

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
