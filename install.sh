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
echo '. ~/.bash_config/bash_source' > ~/.bashrc

# Install "the ultimate vimrc" if it isn't installed already
# TODO: move this to vim/install.sh and merge w/ vim/setup.sh
if [ ! -d ~/.vim_runtime ]; then
    # TODO: Confirm installation
    echo '~/.vim_runtime not found, installing...'
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
    . ~/.vim_runtime/install_awesome_vimrc.sh
fi
# TODO: compare file contents before setting up my_configs.vim
# Set cutsom configurations for vim
. ~/.bash_config/vim/setup.sh


# TODO copy .fonts to ~

echo 'Bash config installed.'
echo 'Restarting bash.'

exec bash
