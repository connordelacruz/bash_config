# Bash Config

I wanted to setup my runtime configuration in a way that was reasonably portable
and consistent across a variety of operating systems, bash versions, and
terminal emulators, while allowing for additional configurations and overrides
specific to each environment.


## TODO:

* Info on powerline
* Add a localrc.d file that gets loaded prior to globalrc.d where you can
  enable/disable things before running global stuff?
* Add a section detailing functions/aliases
* Update directory structure, it's out of date
* Update info on modules, configs


## Installation

Clone repo as ~/.bash_config and run install script:

```
git clone https://github.com/connordelacruz/bash_config.git ~/.bash_config
~/.bash_config/install.sh
```


## Updating

To pull changes from the remote repository and initialize any new submodules,
run:

```
~/.bash_config/update.sh
```

If you're using my [vim runtime
repo](https://github.com/connordelacruz/vim_runtime) (or a fork of it), you can
run the following script to update it as well:

```
~/.bash_config/update_all.sh
```


## Submodules

### Included Modules

- [base16-shell](https://github.com/chriskempson/base16-shell) is included as a
submodule for quickly setting the terminal colorscheme.
- [iterm2-tab-color](https://github.com/connordelacruz/iterm2-tab-color)
  adds functions for setting the tab color in iTerm2.


### Enabling/Disabling Modules

Enabled submodules can be configured in `modules/config.sh`. To
disable a submodule, set the corresponding variable to `0`. E.g. if you wanted
to disable iterm2-tab-color:

`modules/config.sh`:

```bash
ENABLE_IT2_TAB_COLOR=0
```


## Directory Structure

- `install.sh` - Backs up the existing `~/.bashrc` (if one exists) and creates a
  one-line `.bashrc` that sources `~/.bash_config/init.sh`
- `update.sh` - Pulls updates to main repo and submodules
- `init.sh` - Sources `globalrc.d/init.sh` and `localrc.d/init.sh`
- `globalrc.d/` - Shared runtime configuration files  
    - `init.sh` - Sources all bash configuration files in directory
    - `bashrc.sh` - Bash runtime configurations
    - `inputrc` - Input configurations
    - `functions.sh` - Declarations of bash functions
    - `prompt/` - Configurations for PS1 prompt
        - `init.sh` - Configuration variables for PS1/powerline prompts and
          sources one of the following scripts
        - `powerline.sh` - If `POWERLINE_ENABLE` is set to `1`, this file will
          be sourced to set the PS1 prompt to a modified version of powerline
        - `ps1.sh` - If `POWERLINE_ENABLE` is set to `0`, this file will
          be sourced to set the PS1 prompt to a vanilla PS1
- `localrc.d/` - Additional configurations specific to the machine. These are
  ignored by git.  
    - `init.sh` - Looks for any of the following files in `localrc.d/` and
      sources them if they exist:
        - `bashrc.sh`
        - `inputrc`
        - `variables.sh`
        - `config.sh`
        - `aliases.sh`  
        - `functions.sh`
- `modules/` - git submodules  
    - `config.sh` - Configurations for enabled/disabled submodules
    - `init.sh` - Sources `config.sh` and all enabled modules
    - [`base16-shell`](https://github.com/chriskempson/base16-shell)
    - [`iterm2-tab-color`](https://github.com/connordelacruz/iterm2-tab-color)


