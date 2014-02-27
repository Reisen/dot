# Lines configured by zsh-newuser-install
# History Settings
# ------------------------------------------------------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000



# Key Bindings
# ------------------------------------------------------------------------------
bindkey -v                  # Vim-ish Keybindings.
zstyle :compinstall filename '/home/reisen/.zshrc'



# Stuff?
# ------------------------------------------------------------------------------
autoload -Uz compinit
compinit

autoload -U colors
colors


# Aliases
# ------------------------------------------------------------------------------
alias ls='ls --color=auto --group-directories-first'
alias clip='xclip -selection clipboard'
alias sandbox='source env/bin/activate'



# Visual Stuff
# ------------------------------------------------------------------------------
export PS1="[%{$fg[blue]%}%1~%{$reset_color%} %m]%{$fg[blue]%}%#%{$reset_color%} "
export RPS1="%{$fg[blue]%}E%{$reset_color%}%?-%{$fg[blue]%}J%{$reset_color%}%j-%{$fg[blue]%}H%{$reset_color%}%h"



# Extra PATH directories.
# ------------------------------------------------------------------------------
export PATH=$PATH:/home/reisen/.cabal/bin
export PATH=$PATH:/home/reisen/.local/bin
export PATH=$PATH:/home/reisen/bin
