    
                           _oo0oo_
                          o8888888o
                          88" . "88
                          (| -_- |)
                          0\  =  /0
                        ___/`---'\___
                      .' \\|     |// '.
                     / \\|||  :  |||// \
                    / _||||| -:- |||||- \
                   |   | \\\  -  /// |   |
                   | \_|  ''\---/''  |_/ |
                   \  .-\__  '-'  ___/-. /
                 ___'. .'  /--.--\  `. .'___
              ."" '<  `.___\_<|>_/___.' >' "".
             | | :  `- \`.;`\ _ /`;.`/ - ` : | |
             \  \ `_.   \_ __\ /__ _/   .-` /  /
         =====`-.____`.___ \_____/___.-`___.-'=====
                           `=---='
    
# .dotfiles

## install

```zsh
# dotfiles
git clone --recursive https://github.com/iamvlado/.dotfiles && ~/.dotfiles/init

# oh my zsh
sh -c "$(curl -fsSL
https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# tmux with macOS clipboard integration
brew install tmux
brew install reattach-to-user-namespace
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # managing plugins via the command line
  # installing plugins. As usual, plugins need to be specified in .tmux.conf.
  # run the following command to install plugins:
  ~/.tmux/plugins/tpm/bin/install_plugins

  # updating plugins
  ~/.tmux/plugins/tpm/bin/update_plugins all

  # or update a single plugin
  ~/.tmux/plugins/tpm/bin/update_plugins tmux-sensible

  # removing plugins
  ~/.tmux/plugins/tpm/bin/clean_plugins

# vim-plug — a minimalist vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# the silver Searcher
brew install the_silver_searcher

```

## cli
+ [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) — a code-searching tool similar to ack, but faster

## npm
+ [npm-check](https://www.npmjs.com/package/npm-check) — check for outdated, incorrect, and unused dependencies

## fonts
+ [FiraCode](https://github.com/tonsky/FiraCode) — Fira Code: monospaced font with programming ligatures
+ [Hack](https://github.com/chrissimpkins/Hack) — a typeface designed for source code

## apps
+ [GitHub Desktop](https://desktop.github.com/) — GitHub Desktop is a seamless way to contribute to projects on GitHub and GitHub Enterprise
+ [Cumulus](https://github.com/gillesdemey/Cumulus) — a SoundCloud player that lives in your menubar
+ [spectacleapp](https://www.spectacleapp.com) — move and resize windows with ease
+ [SelfControl](https://selfcontrolapp.com) — a free Mac application to help you avoid distracting websites
+ [iA Writer](https://ia.net/writer/) — iA Writer is designed to provide the best writing experience
+ [Telegram](https://telegram.org/) — a new era of messaging

## Chrome plugins
+ [Pesticide](http://pesticide.io/) — for quickly debugging css layout issues by toggling different colored outlines on every element
+ [WhatFont](http://www.chengyinliu.com/whatfont.html) — the easiest way to identify fonts on web pages
+ [Wappalyzer](https://wappalyzer.com/) — identifies software on the web

## Gmail
+ [Gmail setup](https://iamstarkov.com/gmail-setup/) — gmail is not very friendly by default
+ [Keyboard shortcuts for Gmail](https://support.google.com/mail/answer/6594?hl=en) — save time navigating in Gmail by using keyboard shortcuts.

## macOS tips & tricks — some useful productivity hacks
+ **In Finder, press `Shift+Cmd+.` to toggle hidden files.** Works in the Open and Save dialog too
+ **Switch from Spotlight to Google.** If you need to ditch Spotlight in favor of Google for a particular search, you can easily do so. Hit `Command-B` to open a new tab in your default browser using your default search engine
+ **Resize a window while holding down the `Option key` to resize from the center.** Press `Shift` to keep the aspect ratio. Press both keys to do both
+ **Press the `Option key` in a file context menu to get the ability to copy the path of the file.** For plain text destinations like the terminal, you can also press `Cmd+C` with the file selected and then `Cmd+V` in the terminal to paste the file path

## other
+ [Solarized](http://ethanschoonover.com/solarized) — precision colors for machines and people
+ [Fabulous macOS Tips & Tricks](https://blog.sindresorhus.com/macos-tips-tricks-13046cf377f8#.akgfqk1uo) — some useful productivity hacks
