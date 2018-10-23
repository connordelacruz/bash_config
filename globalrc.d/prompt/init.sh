# ==============================================================================
# PS1 Configuration
# ==============================================================================

# --------------------------------
# Import configurations
# --------------------------------

[ -f "$SRC_GLOBAL_PATH/prompt/config.sh" ] && . "$SRC_GLOBAL_PATH/prompt/config.sh"

# ---------------------------------------
# Source PS1/Powerline
# ---------------------------------------

if [ $POWERLINE_ENABLE -gt 0 ] && [ -f "$SRC_GLOBAL_PATH/prompt/powerline.sh" ]; then
    . "$SRC_GLOBAL_PATH/prompt/powerline.sh"
elif [ -f "$SRC_GLOBAL_PATH/prompt/ps1.sh" ]; then
    . "$SRC_GLOBAL_PATH/prompt/ps1.sh"
fi

