#!/usr/bin/env bash
# TODO: document and implement

# ---------------------------------------
# Configurations
# ---------------------------------------

# General
# ----------------

# Prompt symbol
PS_SYMBOL='\$'

# TODO: Colors
# ----------------


# Powerline
# ----------------

# Set to 1 to use powerline.sh instead of a standard PS1
POWERLINE_ENABLE=1
# Set to 1 to enable git info
POWERLINE_GIT=1
# Set to 1 to enable success/failure symbol color changes
POWERLINE_EXIT_CODE_COLOR=0
# Set to 1 to show user in powerline
POWERLINE_SHOW_USER=0


if [ $POWERLINE_ENABLE -gt 0 ] && [ -f "$SRC_GLOBAL_PATH/prompt/powerline.sh" ]; then
    . "$SRC_GLOBAL_PATH/prompt/powerline.sh"
elif [ -f "$SRC_GLOBAL_PATH/prompt/ps1.sh" ]; then
    . "$SRC_GLOBAL_PATH/prompt/ps1.sh"
fi

