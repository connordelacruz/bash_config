#!/bin/sh
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

echo 'Bash config installed.'
echo 'Restarting bash.'

exec bash
