# ==============================================================================
# Sources bash configuration files
# ==============================================================================


# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Path to shared configuration sources
SRC_GLOBAL_PATH="$HOME/.bash_config/globalrc.d"
# Path to local configuration sources
SRC_LOCAL_PATH="$HOME/.bash_config/localrc.d"
# Path to installed modules
MODULE_PATH="$HOME/.bash_config/modules"

if [ -f "$SRC_GLOBAL_PATH/init.sh" ]; then
    . "$SRC_GLOBAL_PATH/init.sh"
fi

if [ -f "$SRC_LOCAL_PATH/init.sh" ]; then
    . "$SRC_LOCAL_PATH/init.sh"
fi

unset SRC_GLOBAL_PATH SRC_LOCAL_PATH MODULE_PATH
