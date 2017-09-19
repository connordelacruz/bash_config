#!/bin/bash
# Older versions of git don't have the -C option
current_dir="$(pwd)"
cd ~/.bash_config/
git pull --rebase
cd "$current_dir"
