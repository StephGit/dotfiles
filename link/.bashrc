# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

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

# functionallity for the 'sm' command, that let's one switch
# the user but keeping it's own environment
export INIT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"	# dir this script is in
export HOME_DIR=$(eval echo ~$(id -un))	# home dir of current user

# make sure to use right history file
HISTFILE=$HOME_DIR/.bash_history

# Load other user's rc and profile file
SMRC=$(readlink -f $HOME_DIR/.bashrc)
DMRC=$(readlink -f "${BASH_SOURCE[0]}")
if [ $DMRC != $SMRC ]; then
  SMPF=$HOME_DIR/.profile
  SMBP=$HOME_DIR/.bash_profile
  [ -f $SMPF ] -a . $SMPF
  [ -f $SMRC ] -a . $SMRC
  [ -f $SMBP ] -a . $SMBP
fi
alias sm="HOME=$INIT_DIR su -m"

# use my tmux.conf if it exists
if [ -r $INIT_DIR/.tmux.conf ]; then
  alias tmux="HOME=$INIT_DIR tmux -f $INIT_DIR/.tmux.conf"
fi

unset INIT_DIR
export HOME=$HOME_DIR
cd $HOME_DIR

export PATH=/opt/apps/sdk-tools-linux-4333796/tools:/opt/apps/sdk-tools-linux-4333796/tools/bin:$PATH

#bash coloring
PS1='\[\e[32m\u\] \[\e[36m\w\] \[\e[33m\]\:[\e[1m\] b$ \[\e[0m\]'

#bash prompt
PS1='\u \w $(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1 /p") b$ '
 
src

