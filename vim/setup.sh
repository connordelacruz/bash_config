#!/bin/bash
set -e

# Backup existing my_configs.vim
if [ -f ~/.vim_runtime/my_configs.vim ]; then
    echo 'Backing up current my_configs.vim...'
    cd ~/.vim_runtime
    # append timestamp to backup file in case my_configs.vim.bak already exists
    timestamp="$(date +'%s')"
    backup_file="my_configs.vim.bak.$timestamp"
    cp my_configs.vim "$backup_file"
    echo "Backup of my_configs.vim created ($backup_file)"
fi

# my_configs.vim is a one-liner that sources .bash_config/vim/my_configs.vim
echo 'source ~/.bash_config/vim/my_configs.vim' > ~/.vim_runtime/my_configs.vim

echo 'Vim custom configurations set.'

