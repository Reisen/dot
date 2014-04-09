# Lines configured by zsh-newuser-install
# History Settings
# ------------------------------------------------------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000



# Key Bindings
# ------------------------------------------------------------------------------
bindkey -e                  # Emacs Keybindings



# Enable Features
# ------------------------------------------------------------------------------
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename '/home/reisen/.zshrc'
autoload -Uz compinit
compinit

autoload -U colors
colors

setopt prompt_subst
autoload -U promptinit
promptinit



# Aliases
# ------------------------------------------------------------------------------
alias ls='ls --color=auto --group-directories-first'
alias clip='xclip -selection clipboard'
alias sandbox='source env/bin/activate'



# Visual Stuff
# ------------------------------------------------------------------------------
function check_git {
    # Check if the branch command fails. If so we're not in a git repo.
    git branch &>/dev/null || return

    # Print out the current branch name.
    echo -n "%{$fg[blue]%}B%{${reset_color}%}$(git rev-parse --abbrev-ref HEAD)-"
}

export PS1='[%{$fg[blue]%}%1~%{$reset_color%} %m]%{$fg[blue]%}%#%{$reset_color%} '
export RPS1='$(check_git)%{$fg[blue]%}E%{$reset_color%}%?-%{$fg[blue]%}J%{$reset_color%}%j-%{$fg[blue]%}H%{$reset_color%}%h'



# Extra PATH directories.
# ------------------------------------------------------------------------------
export PATH=$PATH:/home/reisen/.cabal/bin
export PATH=$PATH:/home/reisen/.local/bin
export PATH=$PATH:/home/reisen/.local/scripts
