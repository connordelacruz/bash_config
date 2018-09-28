# ==============================================================================
# Sources enabled submodules
# ==============================================================================

# TODO: implement

# --------------------------------
# Import configurations
# --------------------------------

if [ -f "$MODULE_PATH/config.sh" ]; then
    . "$MODULE_PATH/config.sh"
fi


# --------------------------------
# Module imports
# --------------------------------

# Base16 Shell
if [[ $ENABLE_BASE16_SHELL -gt 0 ]] && [ -f "$MODULE_PATH/base16-shell/profile_helper.sh" ]; then
    [ -n "$PS1" ] && [ -s $MODULE_PATH/base16-shell/profile_helper.sh ] && eval "$($MODULE_PATH/base16-shell/profile_helper.sh)"
fi

# iTerm2 Tab Colors
if [[ $ENABLE_IT2_TAB_COLOR -gt 0 ]] && [ -f "$MODULE_PATH/iterm2-tab-color/functions.sh" ]; then
    . "$MODULE_PATH/iterm2-tab-color/functions.sh"
fi

# TODO: run initial configurations? Or leave that to localrc.d


