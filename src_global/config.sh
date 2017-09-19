# ==============================================================================
# Bash configuration
# ==============================================================================


# ------------------------------------------------------------------------------
# Terminal configurations
# ------------------------------------------------------------------------------
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# ------------------------------------------------------------------------------
# Color prompt
# ------------------------------------------------------------------------------

# Enable base16 shell
if [ -f "$MODULE_PATH/base16-shell/profile_helper.sh" ]; then
    [ -n "$PS1" ] && [ -s $MODULE_PATH/base16-shell/profile_helper.sh ] && eval "$($MODULE_PATH/base16-shell/profile_helper.sh)"
    # TODO: run command and change colorscheme
fi

# Set $COLORTERM to truecolor for iTerm2
if [[ "$TERM_PROGRAM" == "iTerm.app" || "$TERM_PROGRAM" == "Hyper" ]]; then
    export COLORTERM=truecolor
fi

# TODO: more reliable check? e.g. user terminfo
# Set 256 color if this is an XFCE Terminal
# Source: https://stackoverflow.com/a/29382288
if [ "$COLORTERM" == "xfce4-terminal" ]; then
    export TERM=xterm-256color
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color)
        color_prompt=yes
        ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# TODO: more readable color prompt section
if [ "$color_prompt" = yes ]; then
    export PS1="\[\033[01;36m\]\u@\h\[\033[00m\] \[\033[00;34m\]\w\[\033[02;37m\]\n\$ \[\033[00m\]"
    export CLICOLOR=1
    export LSCOLORS=exBxhxDxfxhxhxhxhxcxcx
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# ------------------------------------------------------------------------------
# More stolen from the default Ubuntu .bashrc
# TODO: better categorization
# ------------------------------------------------------------------------------

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
