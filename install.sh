#!/usr/bin/env bash
# ==============================================================================
# install.sh
#
# Backs up existing .bashrc, creates a new one that uses configurations from
# this repo, and installs any git submodules.
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================

set -e

echo 'Installing bash config...'

# Backup existing .bashrc
if [ -f ~/.bashrc ]; then
    echo 'Backing up current .bashrc...'
    cd ~
    # append timestamp to backup file in case .bashrc.bak already exists
    timestamp="$(date +'%s')"
    backup_file=".bashrc.bak.$timestamp"
    cp .bashrc "$backup_file"
    echo "Backup of .bashrc created ($backup_file)"
fi

# ~/.bashrc is a one-liner that sources .bash_config/init
echo 'Creating new .bashrc...'
echo '. ~/.bash_config/init.sh' > ~/.bashrc
echo 'New .bashrc created.'

# initialize submodules
echo 'Initializing plugin submodules...'
current_dir="$(pwd)"
cd ~/.bash_config
git submodule update --init --recursive
cd "$current_dir"
unset current_dir
echo 'Plugin submodules initialized.'

# Setup git configs
~/.bash_config/install_git.sh

echo 'Bash config installed.'
echo 'Restarting bash.'

exec bash
