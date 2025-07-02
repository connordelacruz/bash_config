# ==============================================================================
# Sources local configurations
# ==============================================================================

# Custom inputrc file (overrides globalrc.d/inputrc) ===========================
if [ -f "$SRC_LOCAL_PATH/inputrc" ]; then
    export INPUTRC="$SRC_LOCAL_PATH/inputrc"
fi

# General configurations =======================================================
[ -f "$SRC_LOCAL_PATH/bashrc.sh" ] && \
    source "$SRC_LOCAL_PATH/bashrc.sh"

# Environment variable definitions =============================================
[ -f "$SRC_LOCAL_PATH/variables.sh" ] && \
    source "$SRC_LOCAL_PATH/variables.sh"

# Bash configuration (PS1, color settings, etc) ================================
[ -f "$SRC_LOCAL_PATH/config.sh" ] && \
    source "$SRC_LOCAL_PATH/config.sh"

# Alias definitions ============================================================
[ -f "$SRC_LOCAL_PATH/aliases.sh" ] && \
    source "$SRC_LOCAL_PATH/aliases.sh"

# Function definitions =========================================================
[ -f "$SRC_LOCAL_PATH/functions.sh" ] && \
    source "$SRC_LOCAL_PATH/functions.sh"

# Configurations to load after everything else =================================
# NOTE: If ~/.bash_config/localrc.d/after.sh exists, then ~/.bash_config/init.sh
#       will source it at the very end of the file.
