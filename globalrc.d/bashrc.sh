# ==============================================================================
# Bash Configurations
#
# Author: Connor de la Cruz
# Repo: https://github.com/connordelacruz/bash_config
# ==============================================================================

# Environment ==================================================================

# PATH -------------------------------------------------------------------------
# Add bash_config local bin path
export PATH="$SRC_LOCAL_PATH/bin:$PATH"

# (MacOS) Homebrew has different paths depending on system architecture, so make
# sure to add the correct one to PATH.
if [[ "$(command -v brew)" ]]; then
	export BREW_ROOT_PATH="$(brew --prefix)"
	export BREW_BIN_PATH="$BREW_ROOT_PATH/bin"
	export PATH="$BREW_BIN_PATH:$PATH"
fi

# TODO: Do we still wanna add /usr/local/bin if we're on arm64 mac?


# General ----------------------------------------------------------------------
# Update window size after each command
shopt -s checkwinsize
# Enable extended globbing
shopt -s extglob
# auto cd if command is a name of a directory
shopt -s autocd
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# Suppress perl warning
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Completion -------------------------------------------------------------------
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
# Enable bash completion (MacOS)
[[ -n "$BREW_ROOT_PATH" ]] &&
[[ -r "$BREW_ROOT_PATH/etc/profile.d/bash_completion.sh" ]] &&
    . "$BREW_ROOT_PATH/etc/profile.d/bash_completion.sh"

# History ----------------------------------------------------------------------
# Append to the history file, don't overwrite it
shopt -s histappend
# Save multi-line commands as a single history entry
shopt -s cmdhist
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth
# Record each line of history after issuing it; clear history; reload history into mem
# https://www.baeldung.com/linux/preserve-history-multiple-windows#general-solution
# TODO: REMOVE?
# PROMPT_COMMAND="history -a; history -c; history -r"

# Set size of command history
# If on version 4.3+, set to -1 for unlimited history
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
if ((BASH_VERSINFO[0] >= 4 && BASH_VERSINFO[1] >= 3)); then
    HISTSIZE=-1
    HISTFILESIZE=-1
else
    HISTSIZE=100000
    HISTFILESIZE=200000
fi

# Mode -------------------------------------------------------------------------
# Use vi mode
# set -o vi

# Editor -----------------------------------------------------------------------
# See what members of the vi family are available
if [[ "$(command -v nvim)" ]]; then
    export VISUAL=nvim
elif [[ "$(command -v vim)" ]]; then
    export VISUAL=vim
else
    export VISUAL=vi
fi
# set EDITOR to match
export EDITOR="$VISUAL"
# Use vim as man pager
# TODO: nvim and vim appear to handle this differently?
# export MANPAGER="$EDITOR -c MANPAGER -"
export MANPAGER="$EDITOR +Man!"

# Color ------------------------------------------------------------------------
# Check shell for true color support and set COLORTERM appropriately
# (Used in vim configs to determine what theme to use)
# Set $COLORTERM to truecolor for iTerm2
if [[ "$TERM_PROGRAM" == "iTerm.app" || "$TERM_PROGRAM" == "Hyper" ]]; then
    export COLORTERM=truecolor
fi
# Set 256 color and $COLORTERM to truecolor for mate-terminal
if [[ "$COLORTERM" == "mate-terminal" ]]; then
    export TERM=xterm-256color
    export COLORTERM=truecolor
fi
# Set 256 color if this is an XFCE Terminal
if [ "$COLORTERM" == "xfce4-terminal" ]; then
    export TERM=xterm-256color
fi
# Color environment vars
if [[ $(tput colors) > 0 ]]; then
    # Custom environment variable, set to 1 if color is supported
    export COLOR_PROMPT=1
    # ls
    export CLICOLOR=1
    export LSCOLORS=exBxhxDxfxhxhxhxhxcxcx
    export LS_COLORS="di=34:ln=1;31:so=37:pi=1;33:ex=35:bd=37:cd=37:su=37:sg=37:tw=32:ow=32"
    # grep
    export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
fi

# Ack --------------------------------------------------------------------------
# Global ackrc
export ACKRC="$SRC_GLOBAL_PATH/ack/ackrc_global"

# Misc -------------------------------------------------------------------------
# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases and Functions ========================================================

# ls ---------------------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias L='ls -CF'
# Use ls if $1 is a directory or less if it's a file (or something else)
# Defaults to "." to if no argument is provided (i.e. ls .)
le() {
    # Wild card expansion
    if [[ $# > 1 ]]; then
        L "$@"
    # Otherwise assume directory or file
    else
        local target="${1:-.}"
        [[ -d "$target" ]] && L "$target" || less "$target"
    fi
}
alias l='le'

# cd ---------------------------------------------------------------------------
# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# cd into a directory and list its contents
cdl() {
    cd "$@" && L
}
alias c='cdl'
complete -o nospace -F _cd cdl
complete -o nospace -F _cd c

# git --------------------------------------------------------------------------
# Quickly push a new branch to remote for the first time
alias gpush-head='git push -u origin HEAD'
# Commit all staged (verbose)
alias gcommit-v='git commit -v'
alias gcv='gcommit-v'
# Commit all tracked (verbose)
alias gcommit-av='git commit -av'
alias gco='gcommit-av'
# Print current branch name
alias gcurrent-branch='git symbolic-ref --short HEAD'

# Show all commits since base branch. Takes optional arg for base branch
glog-since-branch() {
    local base="${1:-master}"
    git log "$base..$(gcurrent-branch)"
}

# Delete all merged local git branches except master and develop.
# Prompts for confirmation by default. The -y arg can be used to skip the prompt
gbranch-cleanup() {
    local yn
    if [[ $# > 0 ]] && [[ "$1" == "-y" ]]; then
        yn="y"
    else
        read -p "Delete all merged branches except master and develop? (y/[n]): " yn
    fi
    case $yn in
        [yY]* )
            git branch --no-color | grep -vE "master|develop" | xargs git branch -d
            ;;
        *)
            ;;
    esac
}

# Open a file or directory in GitHub.
#
# If no args specified, will open root of repo.
# If no branch is specified, will use the current branch.
#
# Usage:
#   gopen-url [<file or dir>] [<branch>]
gopen-url() {
local REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
# Non-zero exit code likely means we're not in a git repo
# TODO: allow arg to be the root dir of the repo and use git -C ?
if [[ $? -ne 0 ]]; then
    echo "Not in a git repo."
    return 1
fi
# Get filepath from 1st arg (if provided)
local FILEPATH="$1"
# If 2nd arg is provided, use that as the branch, otherwise use the currently checked out one
local BRANCH="${2:-$(git rev-parse --abbrev-ref HEAD)}"
# Get URL for repo
local BASE=$(git config --get remote.origin.url | sed s/\\.git// | sed 's/:/\//' | sed 's/.*github.com/https:\/\/github.com/')
# Determine if target file is a directory or file
local TARG_TYPE
if [[ $# -eq 0 ]] || [[ -d "$FILEPATH" ]]; then
    # Directories use 'tree' in their URLs
    TARG_TYPE="tree"
    # TODO: figure out how to handle case where we aren't in the repo root
elif [[ -f "$FILEPATH" ]]; then
    # Files use 'blob' in their URLs
    TARG_TYPE="blob"
    # Handle relative paths
    FILEPATH="$(git ls-files --full-name "$FILEPATH")"
else
    # If we get here, then $1 is not a valid file/dir
    echo "$1 could not be resolved to a file or directory."
    return 1
fi
local URL="$BASE/$TARG_TYPE/$BRANCH/$FILEPATH"
open "$URL"
echo "Opened $URL"
}

# Editor -----------------------------------------------------------------------
alias e="$EDITOR"
# Vim-specific Configs/aliases
if [[ "$EDITOR" == *"vi"* ]]; then
    # Shorthand for opening multiple files in splits/tabs
    alias sp="$EDITOR -o"
    alias vsp="$EDITOR -O"
    alias vs="vsp"
    alias tabe="$EDITOR -p"
    # tab by default with e command
    alias e="tabe"
fi

# python -----------------------------------------------------------------------
# Shortcut for creating a new virtual python environment in venv/
alias venv-init="python -m venv venv"
# Shortcut for sourcing venv activate script
alias venv-activate=". venv/bin/activate"

# MacOS ------------------------------------------------------------------------
if [[ "$(uname -s)" == "Darwin"* ]]; then
    # Echo the contents of the clipboard
    alias clipboard-contents="echo \$(pbpaste)"
    # Copy current directory path without newline
    alias copy-pwd="pwd | tr -d '\n' | pbcopy"
    # Shortcut to cd into copied directory using copy-pwd
    alias cd-paste="cd \"\$(pbpaste)\""
    # Copy previous command to clipboard
    alias copy-last-cmd="fc -ln -1 | awk '{\$1=\$1}1' ORS='' | pbcopy"
    # Clone a git repo using the clipboard contents as the URL
    alias gclone-paste="git clone \$(pbpaste)"
    # Set remote origin using clipboard contents as the URL
    alias gremote-origin-paste='git remote add origin "$(pbpaste)"'
    # Iterm2 tab color script
    alias it2="it2-b16-theme"
fi

# Color ------------------------------------------------------------------------
if [[ -n "$COLOR_PROMPT" ]]; then
    # ls
    # MacOS doesn't have --color option
    if [[ "$(uname -s)" != "Darwin"* ]]; then
        alias ls='ls --color=auto'
    fi
    # grep
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # If colordiff command exists, alias diff
    if [[ "$(command -v colordiff)" ]]; then
        alias diff=colordiff
    fi
    # If tree command exists, alias tree -C
    if [[ "$(command -v tree)" ]]; then
        alias tree="tree -CF"
    fi
fi

# grep/ack ---------------------------------------------------------------------
# Helper for todo functions. Usage:
# _todo-grep <target dir> [-c] [-n <max characters>]
_todo-grep() {
    local targets=
    local color_arg="auto"
    local N=80
    # Get optional args
    while [ "$1" != "" ]; do
        case $1 in
            -c)
                color_arg="always"
                ;;
            -n)
                # Get value following -n flag
                # (Or fallback to default if no value was passed)
                shift
                N=${1:-$N}
                ;;
            *)
                # Any other arg is a target dir
                targets="$targets $1"
                ;;
        esac
        shift
    done
    grep -RPIino --exclude-dir={.git,.idea,node_modules,venv} --color=$color_arg "(TODO|FIXME).{0,$N}" $targets
}

_todo-ack() {
    local targets=
    local color_arg=
    local pager_arg=
    local N=80
    # Get optional args
    while [ "$1" != "" ]; do
        case $1 in
            -c)
                color_arg="--color"
                ;;
            -p)
                pager_arg="less -R"
                ;;
            -n)
                # Get value following -n flag
                # (Or fallback to default if no value was passed)
                shift
                N=${1:-$N}
                ;;
            *)
                # Any other arg is a target dir
                targets="$1"
                ;;
        esac
        shift
    done
    echo "$pager_arg"
    ack -oH ${color_arg} --pager="${pager_arg}" --ignore-dir={.git,.idea,node_modules,venv} "(TODO|FIXME).{0,$N}" $targets
}

# Print todo/fixme comments in the specified file/directory
# (use ack if installed)
if [[ "$(command -v ack)" ]]; then
    todo() {
        _todo-ack "${@:-.}"
    }
else
    todo() {
        _todo-grep "${@:-.}"
    }
fi

# less -------------------------------------------------------------------------
_todo-less-grep() {
    _todo-grep "${@:-.}" -c | less -R
}

_todo-less-ack() {
    _todo-ack "${@:-.}" -p
}

# Show todo/fixme comments in less
# (use ack if installed)
if [[ "$(command -v ack)" ]]; then
    todo-less() {
        _todo-less-ack "${@:-.}"
    }
else
    todo-less() {
        _todo-less-grep "${@:-.}"
    }
fi

# Show diff output in less
diff-less() {
    diff -u "$1" "$2" | less -R
}

# Show tree output in less
tree-less() {
    tree "$@" | less -R
}

# Timestamps -------------------------------------------------------------------

# Print out a timestamp in the format yyyy-mm-dd
# If the -v flag is used, print verbose timestamp yyyy-mm-dd-HH.MM.SS
# Can be used to quickly print a timestamp to filenames e.g.:
#   mv "$file" "$(ts)$file"
ts() {
    local fmt="+%Y-%m-%d"
    [[ "$1" == "-v" ]] && fmt="$fmt-%H.%M.%S"
    date "$fmt"
}

# Print out the date a file was last modified in the format yyyy-mm-dd
# TODO support -v similar to ts
ts-file() {
    if [[ $# > 0 ]]; then
        local fmt="+%Y-%m-%d"
        date -r "$1" "$fmt"
    else
        echo "Usage: ts-file <filename>"
    fi
}

# Notica -----------------------------------------------------------------------

# NOTE: environment variable NOTICA_ID must be set to the unique URL ID
notica() {
    [[ -z "$NOTICA_ID" ]] && echo "NOTICA_ID must be set to use this function." && return 1
    curl --data "d:$*" "https://notica.us/?$NOTICA_ID"
}

# React ------------------------------------------------------------------------

# Shorthand to create minimal react app
alias create-react-app='npx create-react-app --template cra-template-minimal'

# Create react app and cd into created directory.
# (Assumes 1st arg is dirname, but will pass whatever to create-react-app)
cra() {
    if [[ $# > 0 ]]; then
        create-react-app "$@" && c "$1"
    else
        echo 'Usage: cra <dirname> [<other create-react-app args>]'
    fi
}

# goto -------------------------------------------------------------------------
if [[ "$(command -v goto)" ]]; then
    # 'cdl' but for goto
    # TODO: support other args, only call l if no optional args provided
    go() {
        goto "$1" && l
    }
    # tab completion
    complete -o nospace -F _complete_goto_bash go
fi

