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
# Custom variables
# ------------------------------------------------------------------------------

# Set vim as the default git editor
export GIT_EDITOR=vim
