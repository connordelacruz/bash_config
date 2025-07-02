#!/usr/bin/env bash
# ==============================================================================
# install.sh
#
# Backs up existing .bashrc, creates a new one that uses configurations from
# this repo. Then install git configs.
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================
set -e

install_git() {
    echo 'Installing/updating git configs...'
    echo ''
    # Global Configs ===========================================================
    # Note: Using '~' in paths when setting git configs expands it, which makes it
    #       pretty much impossible to create a git config file that can be tracked
    #       by the repo and included for arbitrary users/operating systems. So
    #       instead, we're configuring the global config file
    echo 'Configuring core.excludesfile...'
    local current_core_excludesfile
    current_core_excludesfile="$(git config --global --get core.excludesfile)"
    if [[ $? -gt 0 ]]; then
        git config --global core.excludesfile ~/.bash_config/globalrc.d/git/gitignore_global &&
            echo 'Set core.excludesfile to global gitignore.'
    else
        echo 'core.excludesfile already configured, will not overwrite:'
        echo "$current_core_excludesfile"
    fi
    echo ''
    # Local Configs ============================================================
    # TODO: if file exists and is not already in include.path, include gitconfig_local

    # Module Configs ===========================================================
    . ~/.bash_config/modules/config.sh
    # Fancy Git Diff -----------------------------------------------------------
    if [[ $ENABLE_DIFF_SO_FANCY -gt 0 ]]; then
        echo 'Configuring fancy git diff...'
        # Ensure that neither of the required configs for fancy diff are set
        # already. Keep track of their names for output to show which ones are
        # set
        local current_fancy_diff_target_configs
        current_fancy_diff_target_configs="$(git config --global --includes --name-only --get-regexp '(core\.pager|interactive\.diffFilter)')"
        if [[ $? -gt 0 ]]; then
            git config --global --add include.path ~/.bash_config/globalrc.d/git/gitconfig_diff-so-fancy &&
                echo 'Added fancy diff config to include.path.'
        else
            echo 'The following configs required by diff-so-fancy are already configured, will not overwrite:'
            echo "$current_fancy_diff_target_configs"
        fi
        echo ''
    fi
    # Post-install =============================================================
    echo 'Git config setup finished.'
}

install_bash_config() {
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
}

main() {
    # Install bash configs =====================================================
    install_bash_config
    # Install git configs ======================================================
    install_git
    # Post-install =============================================================
    echo 'Bash config installed.'
    echo 'Restarting bash...'
    exec bash
}

main "$@"
