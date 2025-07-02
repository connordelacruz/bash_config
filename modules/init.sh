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
if [[ $ENABLE_BASE16_SHELL -gt 0 ]] && \
    [ -n "$PS1" ] && \
    [ -s $SRC_MODULE_PATH/base16-shell/profile_helper.sh ];
then
    # Set environment variable and source profile helper
    export BASE16_SHELL="$SRC_MODULE_PATH/base16-shell/"
    source "$BASE16_SHELL/profile_helper.sh"
    # Add colortest command (if enabled)
    [[ $B16_COLORTEST -gt 0 ]] && [ -f "$BASE16_SHELL/colortest" ] &&
        alias colortest="$BASE16_SHELL/colortest"
fi

# iTerm2 Tab Colors
# --------------------------------
[[ $ENABLE_IT2_TAB_COLOR -gt 0 ]] && [ -f "$SRC_MODULE_PATH/iterm2-tab-color/functions.sh" ] &&
    . "$SRC_MODULE_PATH/iterm2-tab-color/functions.sh"

# Fancy Diff -------------------------------------------------------------------
# TODO: add global bin so we can just have single command and not everything in this dir
# TODO: git global configs + colors
[[ $ENABLE_DIFF_SO_FANCY -gt 0 ]] && [[ -f "$SRC_MODULE_PATH/diff-so-fancy/diff-so-fancy" ]] &&
    export PATH="$SRC_MODULE_PATH/diff-so-fancy:$PATH"
