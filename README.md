# Bash Config

I wanted to setup my runtime configuration in a way that was reasonably portable
and consistent across a variety of operating systems, bash versions, and
terminal emulators, while allowing for additional configurations and overrides
specific to each environment.


## TODO:

* Info on [powerline](https://github.com/riobard/bash-powerline)
* Add a section detailing aliases?
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

This repo includes a few useful submodules. These are stored in the `modules/`
directory.

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


## PS1 Prompt

**TODO:** document PS1/powerline config details


## Functions

The following convenience functions are included from `globalrc.d/functions.sh`.

`todo` - Recursively searches files for `TODO` or `FIXME` comments using grep
and prints them out. Optionally takes a positional argument for the directory to
search. If no arguments are specified, it will search the current directory.


`todo-less` - Like `todo` but pipes output into `less` to keep terminal history
less cluttered.


`cdl` (alias: `c`) - Shorthand function that changes into a directory and lists
its contents. Equivalent to:

```bash
cd <directory>
l
```


`mkcd` - Shorthand function that creates a directory and changes into it.
Equivalent to:

```bash
mkdir <directory>
cd <directory>
```


`le` - If used on a file, will run `less <file>`. If used on a directory, will
run `ls <directory>`.


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
        - `config.sh` - Configuration variables for PS1/powerline prompts
        - `init.sh` - Sources `config.sh` and one of the following scripts
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


