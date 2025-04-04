[[ -e ~/.common_sh_stuff ]] && emulate sh -c 'source ~/.common_sh_stuff'
# Path to your oh-my-zsh installation.
export ZSH="/home/sgirod/.oh-my-zsh"

# Set name of the theme to load 
ZSH_THEME="cleaned" 
#ZSH_THEME="af-magic" # fallback theme

alias python=/usr/bin/python3
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt zsh-syntax-highlighting)	

source $ZSH/oh-my-zsh.sh
source ~/repos/dpl/misc/deploy-all/.aliases/.depman_aliases
source ~/repos/dpl/all-acrevis/.aliases/.adapter_aliases

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

alias docker-compose="docker compose"
alias vi="vim"
alias vim="nvim -p"
alias freerdp="flatpak run com.freerdp.FreeRDP"
source <(oc completion zsh)


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/sgirod/.sdkman"
[[ -s "/home/sgirod/.sdkman/bin/sdkman-init.sh" ]] && source "/home/sgirod/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# pnpm
export PNPM_HOME="/home/sgirod/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
