# ==============================================================================
# Functions
# ==============================================================================

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
    grep -RPIino --exclude-dir={.git,.idea,node_modules} --color=$color_arg "(TODO|FIXME).{0,$N}" $targets
}

# Print todo/fixme comments in the specified file/directory
todo() {
    # If no args are provided, call from current directory
    _todo-grep "${@:-.}"
}

# Show todo/fixme comments in less
todo-less() {
    # If no args are provided, call from current directory
    _todo-grep "${@:-.}" -c | less -R
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

