# setup locale
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

# setup zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

plugins=(z last-working-dir git)

# add sourses
export DOTFILES=$HOME/.dotfiles
source $DOTFILES/.exports
source $ZSH/oh-my-zsh.sh
source $DOTFILES/.aliases

# allow <c-s> in vim
vim() STTY=-ixon command vim "$@"
