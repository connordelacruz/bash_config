# ==============================================================================
# Sources global configurations
# ==============================================================================


if [ -f "$SRC_GLOBAL_PATH/inputrc" ]; then
    export INPUTRC="$SRC_GLOBAL_PATH/inputrc"
fi

if [ -f "$SRC_GLOBAL_PATH/bashrc.sh" ]; then
    . "$SRC_GLOBAL_PATH/bashrc.sh"
fi

