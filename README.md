# Bash Config

My .bashrc repo. Designed to be reasonably portable across a variety of operating systems, bash versions, and terminal emulators and allow for additional configurations specific to a machine.

## Features
// TODO  

## Install Instructions
Clone repo as ~/.bash_config and run install script:
```
git clone https://connordelacruz@bitbucket.org/connordelacruz/bash_config.git ~/.bash_config
sh ~/.bash_config/install.sh
```

## Keeping Up-To-Date
// TODO: document and explain update_all.sh

## Directory Structure
// TODO: update this info

* `install.sh` - Backs up the existing `~/.bashrc` (if one exists) and creates a one-line `.bashrc` that sources `~/.bash_config/init.sh`
* `init.sh` - Sources `globalrc.d/init.sh` and `localrc.d/init.sh`
* `globalrc.d/` - Shared runtime configuration files  
    * `init.sh` - Sources all bash configuration files in directory
    * `bashrc.sh` - Bash runtime configurations
    * `inputrc` - Input configurations
* `localrc.d/` - Additional configurations specific to the machine. These are ignored by git.  
    * `init.sh` - Looks for `bashrc.sh`, `inputrc`, `variables.sh`, `config.sh`, `aliases.sh`, and `functions.sh` in `localrc.d/` and sources them if they exist
* `modules/` - git submodules.  
