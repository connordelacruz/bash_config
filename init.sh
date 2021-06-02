# ==============================================================================
# Sources bash configuration files
# ==============================================================================
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac
# RC File Paths ----------------------------------------------------------------
# Path to shared configuration sources
export SRC_GLOBAL_PATH="$HOME/.bash_config/globalrc.d"
# Path to local configuration sources
export SRC_LOCAL_PATH="$HOME/.bash_config/localrc.d"
# Path to installed modules
export SRC_MODULE_PATH="$HOME/.bash_config/modules"
# Source RC Files --------------------------------------------------------------
# Global configurations
[ -f "$SRC_GLOBAL_PATH/init.sh" ] && . "$SRC_GLOBAL_PATH/init.sh"
# Submodules
[ -f "$SRC_MODULE_PATH/init.sh" ] && . "$SRC_MODULE_PATH/init.sh"
# Local configurations
[ -f "$SRC_LOCAL_PATH/init.sh" ] && . "$SRC_LOCAL_PATH/init.sh"
# Code to run after everything is sourced
# TODO: allow local override
[ -f "$SRC_GLOBAL_PATH/after.sh" ] && . "$SRC_GLOBAL_PATH/after.sh"
