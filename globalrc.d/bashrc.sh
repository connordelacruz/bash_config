# ==============================================================================
# Bash Configurations
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
#
# Sections:
# => General
# => Aliases
# => Color Prompt
# => PS1
# => Shorthand Functions
# ==============================================================================


# ------------------------------------------------------------------------------
# => General
# ------------------------------------------------------------------------------

# ---------------------------------------
# -> Environment
# ---------------------------------------

# PATH
local_bin="/usr/local/bin"

export PATH="$local_bin:$PATH"

unset local_bin

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

# Update window size after each command
shopt -s checkwinsize
# Enable extended globbing
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ---------------------------------------
# -> History
# ---------------------------------------

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# save multi-line commands as a single history entry
shopt -s cmdhist

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

# ---------------------------------------
# -> Defaults
# ---------------------------------------

## Editors

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

# ------------------------------------------------------------------------------
# => Aliases
# ------------------------------------------------------------------------------

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Bad habits developed during a Windows sysadmin internship
alias md='mkdir'
alias cls='clear'

# ------------------------------------------------------------------------------
# => Optional Packages
# ------------------------------------------------------------------------------

# ---------------------------------------
# -> fzf
# ---------------------------------------

# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ------------------------------------------------------------------------------
# => Color Prompt
# ------------------------------------------------------------------------------

# ---------------------------------------
# -> Base16 Shell
# ---------------------------------------

if [ -f "$MODULE_PATH/base16-shell/profile_helper.sh" ]; then
    [ -n "$PS1" ] && [ -s $MODULE_PATH/base16-shell/profile_helper.sh ] && eval "$($MODULE_PATH/base16-shell/profile_helper.sh)"
fi

# ---------------------------------------
# -> Platform-Specific Configs
# NOTE: The COLORTERM=truecolor stuff is for use with our vim_runtime config
# so it can appropriately set color space settings and select a colorscheme
# that's compatible with the terminal emulator.
# ---------------------------------------

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

# NOTE: gnome-terminal doesn't set $COLORTERM, so there doesn't appear to
# be a good way of detecting it. In Profile Preferences > Command:
# - Check 'Run command as a login shell'
# - Check 'Run a custom command instead of my shell'
# - Set 'Custom command' to:
#       env COLORTERM=truecolor /bin/bash
# - Set 'When command exits' to 'Exit the terminal'

# ---------------------------------------
# -> Check Color Support
# ---------------------------------------
case "$TERM" in
    xterm-color|xterm-256color)
        color_prompt=yes
        ;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

# ---------------------------------------
# -> Color Aliases and Environment Variables
# ---------------------------------------
if [ "$color_prompt" = yes ]; then
    # ls
    # MacOS doesn't have --color option
    if [[ "$(uname -s)" != "Darwin"* ]]; then
        alias ls='ls --color=auto'
    fi
    export CLICOLOR=1
    export LSCOLORS=exBxhxDxfxhxhxhxhxcxcx
    export LS_COLORS="di=34:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32"
    # grep
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
    # If colordiff command exists, alias diff
    if [[ "$(command -v colordiff)" ]]; then
        alias diff=colordiff
    fi
    # If tree command exists, alias tree -C
    if [[ "$(command -v tree)" ]]; then
        alias tree="tree -CF"
    fi
fi

# ------------------------------------------------------------------------------
# => PS1
# ------------------------------------------------------------------------------

if [ -f "$SRC_GLOBAL_PATH/prompt/init.sh" ]; then
    . "$SRC_GLOBAL_PATH/prompt/init.sh"
fi

unset color_prompt force_color_prompt

# ------------------------------------------------------------------------------
# => Shorthand Functions
# ------------------------------------------------------------------------------

# cd into a directory and list its contents
cdl() {
    cd "$@";
    l;
}
# alias it to c
#(redundant, but cdl is a more informative function name and c is easier to type)
alias c='cdl'

# Create a directory and cd into it
mkcd() {
  mkdir "$1"
  cd "$1"
}

# Use ls if $1 is a directory or less if it's a file (or something else)
le() {
    if [ -d "$1" ]; then
        l "$1";
    else
        less "$1";
    fi
}


# Print todo/fixme comments in the specified directory
todo() {
    # If no args are provided, call from current directory
    proj_dir="${1:-.}";
    # Set max characters to print per line
    N=80;
    grep -RPIino --exclude-dir={.git,.idea,node_modules} "(TODO|FIXME).{0,$N}" $proj_dir;
}


# Show todo/fixme comments in less
# TODO: remove redundant components
todo-less() {
    # If no args are provided, call from current directory
    proj_dir="${1:-.}";
    # Set max characters to print per line
    N=80;
    grep -RPIino --exclude-dir={.git,.idea,node_modules} --color=always "(TODO|FIXME).{0,$N}" $proj_dir | less -R;
}

