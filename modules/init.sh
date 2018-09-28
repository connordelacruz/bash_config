# ==============================================================================
# Sources enabled submodules
# ==============================================================================

# --------------------------------
# Import configurations
# --------------------------------

[ -f "$MODULE_PATH/config.sh" ] && . "$MODULE_PATH/config.sh"

# --------------------------------
# Module imports
# --------------------------------

# Base16 Shell
[[ $ENABLE_BASE16_SHELL -gt 0 ]] && [ -f "$MODULE_PATH/base16-shell/profile_helper.sh" ] &&
    [ -n "$PS1" ] && [ -s $MODULE_PATH/base16-shell/profile_helper.sh ] && eval "$($MODULE_PATH/base16-shell/profile_helper.sh)"

# iTerm2 Tab Colors
[[ $ENABLE_IT2_TAB_COLOR -gt 0 ]] && [ -f "$MODULE_PATH/iterm2-tab-color/functions.sh" ] &&
    . "$MODULE_PATH/iterm2-tab-color/functions.sh"

