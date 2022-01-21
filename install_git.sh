#!/usr/bin/env bash
# ==============================================================================
# install_git.sh
#
# Install or update git configs.
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================

main() {
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
    # TODO: && file exists
    if [[ $? -gt 0 ]]; then
        git config --global core.excludesfile ~/.bash_config/globalrc.d/git/gitignore_global &&
            echo 'Set core.excludesfile to global gitignore.'
    else
        echo 'core.excludesfile already configured, will not overwrite:'
        echo "$current_core_excludesfile"
    fi
    echo ''
    # Local Configs ============================================================
    # TODO: if file exists, include gitconfig_local

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
        # TODO: && file exists
        if [[ $? -gt 0 ]]; then
            git config --global --add include.path ~/.bash_config/globalrc.d/git/gitconfig_diff-so-fancy &&
                echo 'Added gitconfig_diff-so-fancy to include.path.'
        else
            echo 'The following configs required by diff-so-fancy are already configured, will not overwrite:'
            echo "$current_fancy_diff_target_configs"
        fi
        echo ''
    fi
}
main "$@"
