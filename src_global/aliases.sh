# ==============================================================================
# Aliases and functions. Included in .bashrc
# ==============================================================================


# ------------------------------------------------------------------------------
# Color support
# ------------------------------------------------------------------------------

# enable color support of ls and also add handy aliases
if [[ "$TERM" == "xterm-"*"color" ]]; then
    # MacOS doesn't have --color option
    if [[ "$(uname -s)" != "Darwin"* ]]; then
        alias ls='ls --color=auto'
    fi
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ------------------------------------------------------------------------------
# ls aliases
# ------------------------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# ------------------------------------------------------------------------------
# Custom Aliases
# ------------------------------------------------------------------------------

# Alias c to cdl function
alias c='cdl'

# When you've spent too much time using CMD on a Windows machine
alias md='mkdir'
alias cls='clear'

