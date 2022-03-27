Installation
============
```
bash -c "$(curl -fsSL https://raw.github.com/StephGit/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## Tools

- [neovim](https://github.com/neovim/neovim)
- [termite](https://github.com/thestinger/termite)
- ZSH

  * `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` 
  * `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting` 
  * `ln -s ~/.dotfiles/config/zsh/cleaned.zsh-theme $ZSH/themes/cleaned.zsh-theme` 
  *  chsh -s /bin/zsh 
- [nvm](https://github.com/creationix/nvm)
- Python (needed for zsh) 

  * `sudo apt install python3`
  

## Enable deoplete

1. Install [neovim](https://github.com/neovim/neovim)
2. open vim
3. run ':UpdateRemotePlugins'

## Install powerline fonts for airline
- [powerline-fonts](https://github.com/powerline/fonts)
