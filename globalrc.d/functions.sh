# ================================================================
# Functions
# ================================================================

# cd into a directory and list its contents
cdl() {
    cd "$@"
    l
}
# alias it to c
#(redundant, but cdl is a more informative function name and c is easier to type)
alias c='cdl'

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1"
  cd "$1"
}

# Use ls if $1 is a directory or less if it's a file (or something else)
le() {
    if [ -d "$1" ]; then
        l "$1"
    else
        less "$1"
    fi
}


# Show diff output in less

diff-less() {
    diff -u $1 $2 | less -r
}


# Show tree output in less
tree-less() {
tree $@ | less -r
}


# Print todo/fixme comments in the specified directory
todo() {
    # If no args are provided, call from current directory
    proj_dir="${1:-.}"
    # Set max characters to print per line
    N=80
    grep -RPIino --exclude-dir={.git,.idea,node_modules} "(TODO|FIXME).{0,$N}" $proj_dir
}


# Show todo/fixme comments in less
# TODO: remove redundant components
todo-less() {
    # If no args are provided, call from current directory
    proj_dir="${1:-.}"
    # Set max characters to print per line
    N=80
    grep -RPIino --exclude-dir={.git,.idea,node_modules} --color=always "(TODO|FIXME).{0,$N}" $proj_dir | less -R
}

