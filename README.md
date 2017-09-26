# Bash Config
Over the past few years, I've found myself having to work on several computers and VMs with a variety of operating systems, bash versions, and terminal emulators. I created this repo to share my bash runtime configurations across each of these platforms, while taking into account compatibility with a wide range of environments. I also wanted to make it reasonably simple to add machine- or job-specific configurations on top of these without having to modify files in the repository.

// TODO: finish documentation (lol I'm bad at READMEs)

## Install Instructions
Clone repo as ~/.bash_config and run install script:
```
git clone https://connordelacruz@bitbucket.org/connordelacruz/bash_config.git ~/.bash_config
sh ~/.bash_config/install.sh
```

## Keeping Up-To-Date
// TODO

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
