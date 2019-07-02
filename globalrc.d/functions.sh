# ================================================================
# Functions
# ================================================================

# cd into a directory and list its contents
cdl() {
    cd "$@" && l
}
alias c='cdl'

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Use ls if $1 is a directory or less if it's a file (or something else)
# Defaults to "." to if no argument is provided (i.e. ls .)
le() {
    local target="${1:-.}"
    [ -d "$target" ] && l "$target" || less "$target"
}


# Show diff output in less
diff-less() {
    diff -u "$1" "$2" | less -R
}


# Show tree output in less
tree-less() {
    tree $@ | less -R
}


# Helper for todo functions. Usage:
# _todo-grep <target dir> [<color always>] [<max characters>]
_todo-grep() {
    # If arg 2 is > 0, use --color=always (default to auto)
    local color_arg="auto" && [[ $2 > 0 ]] && color_arg="always"
    # Set max characters to print per line
    local N="${3:-80}"
    grep -RPIino --exclude-dir={.git,.idea,node_modules} --color=$color_arg "(TODO|FIXME).{0,$N}" $@
}


# Print todo/fixme comments in the specified file/directory
todo() {
    # If no args are provided, call from current directory
    _todo-grep "${@:-.}"
}


# Show todo/fixme comments in less
todo-less() {
    # If no args are provided, call from current directory
    _todo-grep "${@:-.}" 1 | less -R
}


# Delete all merged local git branches except master and develop.
# Prompts for confirmation by default. The -y arg can be used to skip the prompt
git-branch-cleanup() {
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


# Print out a timestamp in the format yyyy-mm-dd
# If the -v flag is used, print verbose timestamp yyyy-mm-dd-HH.MM.SS
# Can be used to quickly print a timestamp to filenames e.g.:
#   mv "$file" "$(ts)$file"
ts() {
    local fmt="+%Y-%m-%d"
    [[ "$1" == "-v" ]] && fmt="$fmt-%H.%M.%S"
    date "$fmt"
}

