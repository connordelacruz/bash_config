# Bash Config
My custom bash configuration repo.

## Install Instructions
Clone repo as ~/.bash_config and run install script:
```
git clone https://connordelacruz@bitbucket.org/connordelacruz/bash_config.git ~/.bash_config
sh ~/.bash_config/install.sh
```

## Directory Structure
- `src_global/` - Shared bash configuration files  
  - `init.sh` - Sources all bash configuration files in directory. Sourced in `bash_source.sh`
  - `variables.sh` - Environment variables
  - `config.sh` - Various configuration settings for bash (color, PS1, etc)
  - `aliases.sh` - Alias definitions
  - `functions.sh` - Function definitions
  - `inputrc` - inputrc file (set in `variables.sh`)
- `src_local/` - Additional bash configurations specific to the machine. These are ignored by git.
  - `init.sh` - Looks for `variables.sh`, `config.sh`, `aliases.sh`, and `functions.sh` in `src_local/` and sources them if they exist. Sourced in `bash_source.sh`. 
