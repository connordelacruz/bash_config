#!/usr/bin/env bash
# ==============================================================================
# install.sh
#
# Backs up existing .bashrc, creates a new one that uses configurations from
# this repo.
#
# Additionally, sets up git configs using install_git.sh.
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================
set -e

main() {
    echo 'Installing bash config...'
    echo ''
    # Backup existing .bashrc ==================================================
    if [[ -f "$HOME/.bashrc" ]]; then
        echo 'Backing up current .bashrc...'
        # append timestamp to backup file to avoid name conflicts
        local timestamp="$(date +'%s')"
        local backup_file=".bashrc.bak.$timestamp"
        cp "$HOME/.bashrc" "$HOME/$backup_file"
        if [[ -f "$HOME/$backup_file" ]]; then
            echo "Backup of .bashrc created (~/$backup_file)"
        else
            echo 'Unable to create backup. Aborting.'
            return 1
        fi
        echo ''
    fi
    # Create new .bashrc =======================================================
    # ~/.bashrc is a one-liner that sources .bash_config/init
    echo 'Creating new .bashrc...'
    echo '. ~/.bash_config/init.sh' > ~/.bashrc
    echo 'New .bashrc created.'
    echo ''
    # initialize submodules ====================================================
    echo 'Initializing plugin submodules...'
    local current_dir="$(pwd)"
    cd ~/.bash_config
    git submodule update --init --recursive
    cd "$current_dir"
    echo 'Plugin submodules initialized.'
    echo ''
    # Setup git configs ========================================================
    # Handled by install_git.sh
    ~/.bash_config/install_git.sh
    # Post-install =============================================================
    echo 'Bash config installed.'
    echo 'Restarting bash...'
    exec bash
}
main "$@"
