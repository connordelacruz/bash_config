#!/usr/bin/env bash
# ==============================================================================
# update_all.sh
#
# Call update scripts in personal repos (if they exist).
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================

# Older versions of git don't have the -C option
current_dir="$(pwd)"

# vim_runtime
if [ -f ~/.vim_runtime/update.sh ]; then
    echo 'Updating vim runtime...'
    . ~/.vim_runtime/update.sh
fi

# bash_config
if [ -f ~/.bash_config/update.sh ]; then
    echo 'Updating bash configurations...'
    . ~/.bash_config/update.sh
fi

cd "$current_dir"
unset current_dir

echo 'Finished running update scripts.'

