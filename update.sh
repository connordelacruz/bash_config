#!/usr/bin/env bash

# TODO: Add --help argument
# TODO: Add --clean argument (run git clean -dff)
# TODO: Add --check argument (checks for updates, doesn't apply)

# Older versions of git don't have the -C option
current_dir="$(pwd)"
cd ~/.bash_config/

echo 'Pulling recent changes...'
git pull --rebase

echo 'Updating submodules...'
git submodule update --init --recursive

# TODO: remove
# Copy old local config contents to localrc.d/
if [ -d ~/.bash_config/src_local ]; then
    echo 'Moving contents of src_local/ to localrc.d/ ...'
    mv ~/.bash_config/src_local/* ~/.bash_config/localrc.d/.
    rmdir ~/.bash_config/src_local
    echo 'Local configs moved.'
fi

cd "$current_dir"
unset current_dir

echo 'Finished.'

# TODO: if changes were pulled, restart bash
