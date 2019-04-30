#!/usr/bin/env bash
# Modified version of bash-powerline.
#
# Based on:
#   https://github.com/riobard/bash-powerline

__powerline() {
    # Colorscheme
    # General
    readonly RESET='\[\033[m\]'
    # PS1 item colors
    readonly COLOR_USER='\[\033[01;36m\]' # cyan (bold)
    readonly COLOR_CWD='\[\033[0;34m\]' # blue
    readonly COLOR_SYMBOL='\[\033[02;37m\]'
    # Powerline function colors
    readonly COLOR_GIT='\[\033[0;35m\]' # magenta
    readonly COLOR_VIRTUALENV='\[\033[0;36m\]' # cyan
    readonly COLOR_JOBS='\[\033[0;32m\]' # green
    # Command exit code colors
    readonly COLOR_SUCCESS='\[\033[0;32m\]' # green
    readonly COLOR_FAILURE='\[\033[0;31m\]' # red

    # Symbols
    readonly SYMBOL_GIT_BRANCH=''
    readonly SYMBOL_GIT_MODIFIED='*'
    readonly SYMBOL_GIT_PUSH='↑'
    readonly SYMBOL_GIT_PULL='↓'

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_SYMBOL='';;
          Linux)    PS_SYMBOL='$';;
          *)        PS_SYMBOL='%';;
      esac
    fi

    # XTerm Window Title
    case "$TERM" in
        xterm*|rxvt*)
            PREFIX="$XTERM_WINDOW_TITLE";;
        *)
            PREFIX='';;
    esac


    __git_info() {
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH$ref
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf " $ref$marks"
    }


    __virtualenv_info() {
        # TODO: || [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ] ?
        [[ $POWERLINE_VIRTUALENV = 0 ]] && return # disabled
        if [ -n "$VIRTUAL_ENV" ]; then
            printf "(`basename \"$VIRTUAL_ENV\"`) "
        fi
    }

    __jobs_info() {
        [[ $POWERLINE_JOBS = 0 ]] && return # disabled
        local job_count="$(jobs -p | wc -l | tr -d " ")"
        [[ $job_count = 0 ]] && return # No jobs
        printf "(jobs: $job_count) "
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $POWERLINE_EXIT_CODE_COLOR -ne 0 ]; then
            if [ $? -eq 0 ]; then
                local symbol="$COLOR_SUCCESS$PS_SYMBOL $RESET"
            else
                local symbol="$COLOR_FAILURE$PS_SYMBOL $RESET"
            fi
        else
            local symbol="$COLOR_SYMBOL$PS_SYMBOL $RESET"
        fi

        local cwd="$COLOR_CWD\w$RESET"
        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            local git="$COLOR_GIT\${__powerline_git_info}$RESET"
            __powerline_virtualenv_info="$(__virtualenv_info)"
            local venv="$COLOR_VIRTUALENV\${__powerline_virtualenv_info}$RESET"
            __powerline_jobs_info="$(__jobs_info)"
            local jobs="$COLOR_JOBS\${__powerline_jobs_info}$RESET"
        else
            # promptvars is disabled. Avoid creating unnecessary env vars.
            local git="$COLOR_GIT$(__git_info)$RESET"
            local venv="$COLOR_VIRTUALENV$(__virtualenv_info)$RESET"
            local jobs="$COLOR_JOBS$(__jobs_info)$RESET"
        fi

        if [ $POWERLINE_SHOW_USER -ne 0 ]; then
            local user="$COLOR_USER\u$RESET "
        else
            local user=
        fi

        PS1="$PREFIX$jobs$venv$user$cwd$git\n$symbol"
    }

    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline
