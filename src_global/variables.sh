# ==============================================================================
# Environment Variables
# ==============================================================================


# ------------------------------------------------------------------------------
# Bash environment variables
# ------------------------------------------------------------------------------

# Custom .inputrc file
export INPUTRC="$SRC_GLOBAL_PATH/inputrc"

# PATH
# MacOS prevents overwriting /usr/bin, so this is required to use homebrew to update certain packages
# TODO move to Mac-specific configuration?
USRBIN="/usr/local/bin"
# Set PATH
export PATH="$USRBIN:$PATH"

unset USRBIN

# ------------------------------------------------------------------------------
# Configurations
# ------------------------------------------------------------------------------

# Set nvim as the default git editor if available
if [[ "$(command -v nvim)" ]]; then
    export GIT_EDITOR=nvim
# Otherwise set vim as the default git editor
else
    export GIT_EDITOR=vim
fi

# grep color output
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
