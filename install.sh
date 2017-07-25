#!/bin/sh
set -e

echo 'Installing bash config...'

# Backup existing .bashrc
# TODO: copy .bash_aliases, .bash_variables, etc to a directory in local?
if [ -f ~/.bashrc ]; then
    echo 'Backing up current .bashrc...'
    cd ~
    # append timestamp to backup file in case .bashrc.bak already exists
    timestamp="$(date +'%s')"
    backup_file=".bashrc.bak.$timestamp"
    cp .bashrc "$backup_file"
    echo "Backup of .bashrc created ($backup_file)"
fi

# ~/.bashrc is a one-liner that sources .bash_config/bash_source
echo '. ~/.bash_config/bash_source.sh' > ~/.bashrc

echo 'Bash config installed.'
echo 'Restarting bash.'

exec bash
