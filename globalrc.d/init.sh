# ==============================================================================
# Sources global configurations
# ==============================================================================

# bashrc =======================================================================
[ -f "$SRC_GLOBAL_PATH/bashrc.sh" ] && \
    source "$SRC_GLOBAL_PATH/bashrc.sh"

# PS1/Powerline configs ========================================================
[ -f "$SRC_GLOBAL_PATH/prompt/init.sh" ] && \
    source "$SRC_GLOBAL_PATH/prompt/init.sh"

# inputrc ======================================================================
[ -f "$SRC_GLOBAL_PATH/inputrc" ] && \
    export INPUTRC="$SRC_GLOBAL_PATH/inputrc" && \
    bind -f "$INPUTRC"
