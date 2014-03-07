# Stuff to check/setup on start.
# ------------------------------------------------------------------------------
# If not running interactively, don't do anything
[[ $- != *i* ]] && return



# Aliases
# ------------------------------------------------------------------------------
alias ls='ls --color=auto --group-directories-first'
alias clip='xclip -selection clipboard'
alias sandbox='source env/bin/activate'



# Visual Stuff
# ------------------------------------------------------------------------------
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
bright=$(tput bold)
reset_color=$(tput sgr0)
blink=$(tput blink)
reverse=$(tput smso)
underline=$(tput smul)

export PS1="[\[${blue}\]\W\[${reset_color}\] \u]\[${blue}\]\$\[${reset_color}\] "



# Extra PATH directories.
# ------------------------------------------------------------------------------
export PATH=$PATH:/home/reisen/.cabal/bin
export PATH=$PATH:/home/reisen/.local/bin
export PATH=$PATH:/home/reisen/bin



# Completion
# ------------------------------------------------------------------------------
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
