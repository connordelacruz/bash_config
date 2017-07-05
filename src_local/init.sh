# ==============================================================================
# Sources local configurations
# ==============================================================================


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

