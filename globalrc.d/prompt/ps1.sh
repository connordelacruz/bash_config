#!/usr/bin/env bash
# PS1 configurations

__ps1() {
    # TODO: configure these in a centralized location so powerline can use same values?

    # Colorscheme
    readonly RESET='\[\033[m\]'
    readonly COLOR_USER='\[\033[01;36m\]' # cyan (bold)
    readonly COLOR_CWD='\[\033[0;34m\]' # blue
    readonly COLOR_SYMBOL='\[\033[02;37m\]'

    # XTerm Window Title
    case "$TERM" in
        xterm*|rxvt*)
            PREFIX="$XTERM_WINDOW_TITLE";;
        *)
            PREFIX='';;
    esac

    ps1() {
        if [ "$color_prompt" = yes ]; then
            local user="$COLOR_USER\u@\h$RESET "
            local cwd="$COLOR_CWD\w$RESET"
            local symbol="\n$COLOR_SYMBOL$PS_SYMBOL $RESET"

            PS1="$PREFIX$user$cwd$symbol"
        else
            PS1='\u@\h:\w\$ '
        fi
        export PS1
    }

    ps1
}

__ps1
unset __ps1

