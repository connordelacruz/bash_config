# ==============================================================================
# Bash configuration
# ==============================================================================


# ------------------------------------------------------------------------------
# General
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

# update window size after each command
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# save multi-line commands as a single history entry
shopt -s cmdhist

# Set size of command history
# TODO: if bash 4.3+, set to -1 for unlimited history (see below)
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
HISTSIZE=100000
HISTFILESIZE=200000

# ------------------------------------------------------------------------------
# Color Prompt
# ------------------------------------------------------------------------------

# ---------------------------------------
# => Base16 Shell
# ---------------------------------------

if [ -f "$MODULE_PATH/base16-shell/profile_helper.sh" ]; then
    [ -n "$PS1" ] && [ -s $MODULE_PATH/base16-shell/profile_helper.sh ] && eval "$($MODULE_PATH/base16-shell/profile_helper.sh)"
fi

# ---------------------------------------
# => TERM and COLORTERM
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color)
        color_prompt=yes
        ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# TODO: remove and just use color_prompt
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

# ------------------------------------------------------------------------------
# PS1
# ------------------------------------------------------------------------------

# ---------------------------------------
# => PS1 Colors
# ---------------------------------------

if [ "$color_prompt" = yes ]; then
    export PS1="\[\033[01;36m\]\u@\h\[\033[00m\] \[\033[00;34m\]\w\[\033[02;37m\]\n\$ \[\033[00m\]"
    export CLICOLOR=1
    export LSCOLORS=exBxhxDxfxhxhxhxhxcxcx
    export LS_COLORS="di=34:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32"
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# ---------------------------------------
# => XTerm Window Title
# ---------------------------------------

case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

