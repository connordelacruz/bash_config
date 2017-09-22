#!/bin/bash
# Call update scripts in personal repos (if they exist)

# Older versions of git don't have the -C option
current_dir="$(pwd)"


# vim_runtime
if [ -f ~/.vim_runtime/update.sh ]; then
    . ~/.vim_runtime/update.sh
fi

# bash_config
if [ -f ~/.bash_config/update.sh ]; then
    . ~/.bash_config/update.sh
fi

cd "$current_dir"
unset current_dir

echo 'Finished running update scripts.'

