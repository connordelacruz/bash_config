# ==============================================================================
# Sources global configurations
# ==============================================================================


# Environment variable definitions
if [ -f "$SRC_GLOBAL_PATH/variables.sh" ]; then
    . "$SRC_GLOBAL_PATH/variables.sh"
fi

# Bash configuration (PS1, color settings, etc)
if [ -f "$SRC_GLOBAL_PATH/config.sh" ]; then
    . "$SRC_GLOBAL_PATH/config.sh"
fi

# Alias definitions
if [ -f "$SRC_GLOBAL_PATH/aliases.sh" ]; then
    . "$SRC_GLOBAL_PATH/aliases.sh"
fi

# Function definitions
if [ -f "$SRC_GLOBAL_PATH/functions.sh" ]; then
    . "$SRC_GLOBAL_PATH/functions.sh"
fi

