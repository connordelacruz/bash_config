# ==============================================================================
# Bash Functions
# ==============================================================================


# Shorthand command that changes directory and lists the contents of it
cdl() {
    cd "$@";
    l;
}
# alias it to c (redundant, but cdl is a more informative function name and
# c is easier to type)
alias c='cdl'

# Print todo/fixme comments in the specified directory
todo() {
    # If no args are provided, call from current directory
    proj_dir="${1:-.}";
    grep -REIin --exclude-dir='.git' "TODO|FIXME" $proj_dir;
}
