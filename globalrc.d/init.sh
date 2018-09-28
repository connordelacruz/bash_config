# ==============================================================================
# Sources global configurations
# ==============================================================================

# inputrc
[ -f "$SRC_GLOBAL_PATH/inputrc" ] && export INPUTRC="$SRC_GLOBAL_PATH/inputrc"

# bashrc
[ -f "$SRC_GLOBAL_PATH/bashrc.sh" ] && . "$SRC_GLOBAL_PATH/bashrc.sh"

# functions
[ -f "$SRC_GLOBAL_PATH/functions.sh" ] && . "$SRC_GLOBAL_PATH/functions.sh"

