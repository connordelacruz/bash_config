# Bash Config
Over the past few years, I've found myself having to work on several computers and VMs with a variety of operating systems, bash versions, and terminal emulators. I created this repo to share my bash runtime configurations across each of these platforms, while taking into account compatibility with a wide range of environments. I also wanted to make it reasonably simple to add machine- or job-specific configurations on top of these without having to modify files in the repository.  

Feel free to fork it or use it as a reference for your own bashrc. You can use it as-is too if you want, but many of the configurations are personal preference.

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

* `globalrc.d/` - Shared runtime configuration files  
    * `init.sh` - Sources all bash configuration files in directory. Sourced in `../init.sh`
    * `bashrc.sh` - Bash runtime configurations
    * `inputrc` - Input configurations
* `localrc.d/` - Additional configurations specific to the machine. These are ignored by git.  
    * `init.sh` - Looks for `bashrc.sh`, `inputrc`, `variables.sh`, `config.sh`, `aliases.sh`, and `functions.sh` in `localrc.d/` and sources them if they exist. Sourced in `../init.sh`.  
* `modules/` - git submodules.  
