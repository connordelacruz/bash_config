# ==============================================================================
# Execute after everything else is sourced
# ==============================================================================

# iTerm2 Tab Color -------------------------------------------------------------
# Set tab color on startup if not set for session
if [ -n "$(LC_ALL=C type -t it2-b16-theme)" ] && [ -z "$IT2_SESSION_COLOR" ]; then
    it2-b16-theme
fi

# Chicago ASCII Art ------------------------------------------------------------
if [ -d "$SRC_MODULE_PATH/chicago-ascii.sh" ]; then
    # Show skyline or flag on startup
    if [ -z "$STARTUP_ASCII_SHOWN" ] || [ "$STARTUP_ASCII_SHOWN" -le 0 ]; then
        if [ $(tput cols) -gt 32 ] && [ $(tput lines) -gt 18 ]; then
            script_args="-c 5 -c 3 -c 4 -c 1 -c 6 -c 16"
            script_path="$SRC_MODULE_PATH/chicago-ascii.sh/skyline-condensed.sh"
        else
            script_args=
            script_path="$SRC_MODULE_PATH/chicago-ascii.sh/flag.sh"
        fi
        clear
        [ -f "$script_path" ] && . "$script_path" $script_args
        unset script_path script_args
        export STARTUP_ASCII_SHOWN=1
    fi
fi

