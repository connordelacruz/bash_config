# Aliases and functions. Included in .bashrc

# FUNCTIONS

# Shorthand command that changes directory and lists the contents of it
cdl() { 
    cd "$@"; 
    l; 
}


# ALIASES
alias c='cdl'
alias md='mkdir'
alias cls='clear'
