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

# TODO: set to nvim instead if command -v nvim returns something?
# Set vim as the default git editor
export GIT_EDITOR=vim

# grep color output
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
