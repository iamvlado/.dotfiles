# Setup locale
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Setup ZSH
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(osx git npm last-working-dir)

# Add sourses
export DOTFILES=$HOME/.dotfiles
source $DOTFILES/.exports
source $ZSH/oh-my-zsh.sh
source $DOTFILES/.aliases

# Allow <c-s> in Vim
vim() STTY=-ixon command vim "$@"
