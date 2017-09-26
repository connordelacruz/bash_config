# ==============================================================================
# Sources local configurations
# ==============================================================================

# Custom inputrc file (overrides globalrc.d/inputrc)
if [ -f "$SRC_LOCAL_PATH/inputrc" ]; then
    export INPUTRC="$SRC_LOCAL_PATH/inputrc"
fi

# General configurations
if [ -f "$SRC_LOCAL_PATH/bashrc.sh" ]; then
    . "$SRC_LOCAL_PATH/bashrc.sh"
fi

# Environment variable definitions
if [ -f "$SRC_LOCAL_PATH/variables.sh" ]; then
    . "$SRC_LOCAL_PATH/variables.sh"
fi

# Bash configuration (PS1, color settings, etc)
if [ -f "$SRC_LOCAL_PATH/config.sh" ]; then
    . "$SRC_LOCAL_PATH/config.sh"
fi

# Alias definitions
if [ -f "$SRC_LOCAL_PATH/aliases.sh" ]; then
    . "$SRC_LOCAL_PATH/aliases.sh"
fi

# Function definitions
if [ -f "$SRC_LOCAL_PATH/functions.sh" ]; then
    . "$SRC_LOCAL_PATH/functions.sh"
fi

