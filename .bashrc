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
colorful() {
    local black=$(tput setaf 0)
    local red=$(tput setaf 1)
    local green=$(tput setaf 2)
    local yellow=$(tput setaf 3)
    local blue=$(tput setaf 4)
    local magenta=$(tput setaf 5)
    local cyan=$(tput setaf 6)
    local white=$(tput setaf 7)
    local bright=$(tput bold)
    local reset_color=$(tput sgr0)
    local blink=$(tput blink)
    local reverse=$(tput smso)
    local underline=$(tput smul)

    # Set new colourful prompt text.
    export PS1="[\[${blue}\]\W\[${reset_color}\] \u]\[${blue}\]\$\[${reset_color}\] "

    # Set colours for man pages (less).
    export LESS_TERMCAP_mb="${blink}"
    export LESS_TERMCAP_md="${blue}"
    export LESS_TERMCAP_me="${reset_color}"
    export LESS_TERMCAP_se="${reset_color}"
    export LESS_TERMCAP_so="${bright}${blue}"
    export LESS_TERMCAP_ue="${reset_color}"
    export LESS_TERMCAP_us="${bright}${blue}"

    # LESS_TERMCAP_mb=$'\E[5m'
    # LESS_TERMCAP_md=$'\E[38;5;4m'
    # LESS_TERMCAP_me=$'\E[m\E(B'
    # LESS_TERMCAP_se=$'\E[m\E(B'
    # LESS_TERMCAP_so=$'\E[38;5;9m'
    # LESS_TERMCAP_ue=$'\E[m\E(B'
    # LESS_TERMCAP_us=$'\E[38;5;12m'
}

colorful
unset colorful

# Extra PATH directories.
# ------------------------------------------------------------------------------
export PATH=$PATH:/home/reisen/.cabal/bin
export PATH=$PATH:/home/reisen/.local/bin
export PATH=$PATH:/home/reisen/bin



# Completion
# ------------------------------------------------------------------------------
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
