#!/usr/bin/env bash
# ==============================================================================
# install_git.sh
#
# Install or update git configs.
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================

set -e

echo 'Installing/updating git configs...'

# Global Configs ===============================================================
# Note: Using '~' in paths when setting git configs expands it, which makes it
#       pretty much impossible to create a git config file that can be tracked
#       by the repo and included for arbitrary users/operating systems. So
#       instead, we're configuring the global config file
echo 'Configuring core.excludesfile...'
git config --global --get core.excludesfile &&
    echo 'core.excludesfile already configured.' ||
    (git config --global core.excludesfile ~/.bash_config/globalrc.d/git/gitignore_global &&
    echo 'Set core.excludesfile to global gitignore.')
echo ''

# Module Configs ===============================================================
# TODO: if enabled, include gitconfig_fancy-diff

# Local Configs ================================================================
# TODO: if file exists, include gitconfig_local

