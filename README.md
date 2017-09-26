# Bash Config
Over the past few years, I've found myself having to work on several computers and VMs with a variety of operating systems, bash versions, and terminal emulators. I created this repo to share my bash runtime configurations across each of these platforms, while taking into account compatibility with a wide range of environments. I also wanted to make it reasonably simple to add machine- or job-specific configurations on top of these without having to modify files in the repository.  

**Disclaimer**: There's a lot of configurations specific to personal preference, so if you want to use this as-is you should familiarize yourself with the details. Feel free to fork it or use it as an example for your own rc files. I'm always open to recommendations or suggestions, too.  

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

- `src_global/` - Shared bash configuration files  
  - `init.sh` - Sources all bash configuration files in directory. Sourced in `bash_source.sh`
  - `variables.sh` - Environment variables
  - `config.sh` - Various configuration settings for bash (color, PS1, etc)
  - `aliases.sh` - Alias definitions
  - `functions.sh` - Function definitions
  - `inputrc` - inputrc file (set in `variables.sh`)
- `src_local/` - Additional bash configurations specific to the machine. These are ignored by git.
  - `init.sh` - Looks for `variables.sh`, `config.sh`, `aliases.sh`, and `functions.sh` in `src_local/` and sources them if they exist. Sourced in `bash_source.sh`.
- `modules/` - git submodules.  
