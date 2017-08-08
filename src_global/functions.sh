# ==============================================================================
# Bash Functions
# ==============================================================================


# Shorthand command that changes directory and lists the contents of it
cdl() {
    cd "$@";
    l;
}


# Print todo/fixme comments in the specified directory
todo() {
    # If no args are provided, call from current directory
    # TODO: set to empty string instead to use a relative path
    proj_dir="${1:-$(pwd)}";
    grep -REIin --exclude-dir='.git' "TODO|FIXME" $proj_dir;
}
