[[ -e ~/.common_sh_stuff ]] && emulate sh -c 'source ~/.common_sh_stuff'
# Path to your oh-my-zsh installation.
export ZSH="/home/sgirod/.oh-my-zsh"

# Set name of the theme to load 
ZSH_THEME="cleaned"


# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt  oc zsh-completions zsh-syntax-highlighting)	

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
source <(oc311 completion zsh)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Source custom functions
# fpath=( $DOTFILES/config/zsh/functions "${fpath[@]}" )
# autoload -Uz $fpath[1]/*(.:t)


