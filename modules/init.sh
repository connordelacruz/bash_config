# ==============================================================================
# Sources enabled submodules
# ==============================================================================

# --------------------------------
# Import configurations
# --------------------------------

[ -f "$SRC_MODULE_PATH/config.sh" ] && . "$SRC_MODULE_PATH/config.sh"

# --------------------------------
# Module imports
# --------------------------------

# Base16 Shell
# --------------------------------
[[ $ENABLE_BASE16_SHELL -gt 0 ]] && [ -f "$SRC_MODULE_PATH/base16-shell/profile_helper.sh" ] &&
    [ -n "$PS1" ] && [ -s $SRC_MODULE_PATH/base16-shell/profile_helper.sh ] && eval "$($SRC_MODULE_PATH/base16-shell/profile_helper.sh)"
# Add colortest command (if enabled)
[[ $B16_COLORTEST -gt 0 ]] && [ -f "$SRC_MODULE_PATH/base16-shell/colortest" ] &&
    alias colortest="$SRC_MODULE_PATH/base16-shell/colortest"

# iTerm2 Tab Colors
# --------------------------------
[[ $ENABLE_IT2_TAB_COLOR -gt 0 ]] && [ -f "$SRC_MODULE_PATH/iterm2-tab-color/functions.sh" ] &&
    . "$SRC_MODULE_PATH/iterm2-tab-color/functions.sh"

