#!/usr/bin/env bash
# ================================================================================
# Download and install Homebrew, then install packages in brew-leaves.txt
# ================================================================================
set -e

# TODO: This is quick and dirty for now cuz I've got a deadline to wipe this
# computer, but might be nice to streamline this for the future.

# Download and install brew
echo "Installing brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Installed!"
echo ""

# Install packages
echo "Installing packages in brew-leaves.txt..."
xargs brew install < brew-leaves.txt
echo "Installed!"
echo ""

