#!/usr/bin/env bash
# ==============================================================================
# update_plugins.sh
#
# Pulls updates submodules remotes.
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================

# Older versions of git don't have the -C option
current_dir="$(pwd)"
cd ~/.bash_config/

echo 'Pulling changes from plugin remote repos...'
git submodule foreach git pull origin master

cd "$current_dir"
unset current_dir

echo 'Plugins updated. Changes will need to be committed.'
