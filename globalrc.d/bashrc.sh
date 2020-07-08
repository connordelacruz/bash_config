# ==============================================================================
# Bash Configurations
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
#
# TODO overhaul formatting and docblock
# ==============================================================================

# Environment ==================================================================

# PATH -------------------------------------------------------------------------
export PATH="/usr/local/bin:$SRC_LOCAL_PATH/bin:$PATH"

# General ----------------------------------------------------------------------
# Update window size after each command
shopt -s checkwinsize
# Enable extended globbing
shopt -s extglob
# cd into variables
shopt -s cdable_vars
# auto cd if command is a name of a directory
shopt -s autocd
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Completion -------------------------------------------------------------------
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
# Enable bash completion (MacOS)
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# History ----------------------------------------------------------------------
# Append to the history file, don't overwrite it
shopt -s histappend
# Save multi-line commands as a single history entry
shopt -s cmdhist
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth
# Record each line of history after issuing it
PROMPT_COMMAND="history -a"
# Set size of command history
# If on version 4.3+, set to -1 for unlimited history
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
if ((BASH_VERSINFO[0] >= 4 && BASH_VERSINFO[1] >= 3)); then
    HISTSIZE=-1
    HISTFILESIZE=-1
else
    HISTSIZE=100000
    HISTFILESIZE=200000
fi

# Editor -----------------------------------------------------------------------
# See what members of the vi family are available
if [[ "$(command -v nvim)" ]]; then
    export VISUAL=nvim
elif [[ "$(command -v vim)" ]]; then
    export VISUAL=vim
else
    export VISUAL=vi
fi
# set EDITOR to match
export EDITOR="$VISUAL"
# Use vim as man pager
export MANPAGER="$EDITOR -c MANPAGER -"

# Color ------------------------------------------------------------------------
# Check shell for true color support and set COLORTERM appropriately
# (Used in vim configs to determine what theme to use)
# Set $COLORTERM to truecolor for iTerm2
if [[ "$TERM_PROGRAM" == "iTerm.app" || "$TERM_PROGRAM" == "Hyper" ]]; then
    export COLORTERM=truecolor
fi
# Set 256 color and $COLORTERM to truecolor for mate-terminal
if [[ "$COLORTERM" == "mate-terminal" ]]; then
    export TERM=xterm-256color
    export COLORTERM=truecolor
fi
# Set 256 color if this is an XFCE Terminal
if [ "$COLORTERM" == "xfce4-terminal" ]; then
    export TERM=xterm-256color
fi
# Color environment vars
if [[ $(tput colors) > 0 ]]; then
    # Custom environment variable, set to 1 if color is supported
    export COLOR_PROMPT=1
    # ls
    export CLICOLOR=1
    export LSCOLORS=exBxhxDxfxhxhxhxhxcxcx
    export LS_COLORS="di=34:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32"
    # grep
    export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
fi

# Misc -------------------------------------------------------------------------
# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases ======================================================================

# ls ---------------------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF' # TODO: merge w/ le()

# git --------------------------------------------------------------------------
# Quickly push a new branch to remote for the first time
alias gpush-head='git push -u origin HEAD'
# Commit all tracked (verbose)
alias gcommit-av='git commit -av'

# Editor -----------------------------------------------------------------------
alias e="$EDITOR"
# Vim-specific Configs/aliases
if [[ "$EDITOR" == *"vi"* ]]; then
    # Shorthand for opening multiple files in splits/tabs
    alias sp="$EDITOR -o"
    alias vsp="$EDITOR -O"
    alias tabe="$EDITOR -p"
    # tab by default with e command
    alias e="tabe"
fi

# python -----------------------------------------------------------------------
# Shortcut for creating a new virtual python environment in venv/
alias venv-init="python -m venv venv"
# Shortcut for sourcing venv activate script
alias venv-activate=". venv/bin/activate"

# MacOS ------------------------------------------------------------------------
if [[ "$(uname -s)" == "Darwin"* ]]; then
    # Echo the contents of the clipboard
    alias clipboard-contents="echo \$(pbpaste)"
    # Copy current directory path without newline
    alias copy-pwd="pwd | tr -d '\n' | pbcopy"
    # Shortcut to cd into copied directory using copy-pwd
    alias cd-paste="cd \"\$(pbpaste)\""
    # Copy previous command to clipboard
    alias copy-last-cmd="fc -ln -1 | awk '{\$1=\$1}1' | pbcopy"
    # Clone a git repo using the clipboard contents as the URL
    alias gclone-paste="git clone \$(pbpaste)"
    # Iterm2 tab color script
    alias it2="it2-b16-theme"
fi

# Color ------------------------------------------------------------------------
if [[ -n "$COLOR_PROMPT" ]]; then
    # ls
    # MacOS doesn't have --color option
    if [[ "$(uname -s)" != "Darwin"* ]]; then
        alias ls='ls --color=auto'
    fi
    # grep
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # If colordiff command exists, alias diff
    if [[ "$(command -v colordiff)" ]]; then
        alias diff=colordiff
    fi
    # If tree command exists, alias tree -C
    if [[ "$(command -v tree)" ]]; then
        alias tree="tree -CF"
    fi
fi

# Color ========================================================================

# Prompt -----------------------------------------------------------------------
# TODO find a way to extract this to init.sh
# Source prompt/init.sh, which has PS1/Powerline configs
[ -f "$SRC_GLOBAL_PATH/prompt/init.sh" ] && . "$SRC_GLOBAL_PATH/prompt/init.sh"

