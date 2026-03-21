# System functions
function mkd() {
    mkdir -p "$1" && cd "$1"
}

function freverse_search() {
    LBUFFER=$(
        fc -rl 1 |
            awk '{$1="";print substr($0,2)}' |
            awk '!seen[$0]++' |
            fzf \
                --cycle \
                --border \
                --prompt="Execute> " \
                --layout="reverse-list"
    )
}

function fkill() {
    local pid=$(
        ps -ef |
            fzf \
                --tac \
                --cycle \
                --exact \
                --border \
                --header-lines=1 \
                --layout="reverse-list" \
                --prompt="Kill Process> " |
            awk '{print $2}'
    )

    if [[ -z "${pid}" ]]; then
        return 1
    fi

    LBUFFER="sudo kill -9 ${pid}"
}

function jump_code() {
    z "$1" && code .
}

function jump_code_exit() {
    z "$1" && code . && exit
}

# System aliases
alias l="eza --sort Name --group-directories-first --icons"
alias ll="eza --sort Name --long --group-directories-first --icons"
alias la="eza --sort Name --long --all --group-directories-first --icons"
alias lr="eza --sort Name --long --recurse --group-directories-first --icons"
alias lra="eza --sort Name --long --recurse --all --group-directories-first --icons"
alias lt="eza --sort Name --long --tree --group-directories-first --icons"
alias lta="eza --sort Name --long --tree --all --group-directories-first --icons"

alias cls="clear"
alias cll="clear;ll"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias de="cd ${HOME}/desktop"
alias desktop="cd ${HOME}/desktop"
alias docs="cd ${HOME}/documents"
alias dw="cd ${HOME}/downloads"
alias downloads="cd ${HOME}/downloads"
alias wp="cd ${HOME}/workspace"
alias dotfiles="cd ${HOME}/.dotfiles"

alias reload="exec ${SHELL} -l"

alias c="jump_code"
alias ce="jump_code_exit"

zle -N freverse_search
bindkey "^r" freverse_search

zle -N fkill
bindkey "^k" fkill

# Extra functions
function update() {
    if command -v brew &>/dev/null; then
        brew update && brew upgrade # macOS

    elif command -v apt &>/dev/null; then
        sudo apt update && sudo apt upgrade -y # debian

    else
        echo "Error: No package manager found!" >&2
        return 1
    fi
}

function copy() {
    local input="${1}"

    if [[ -z "${input}" ]]; then
        input=$(cat)
    fi

    if command -v pbcopy &>/dev/null; then
        echo -n "${input}" | pbcopy &>/dev/null # macOS

    elif command -v clip.exe &>/dev/null; then
        echo -n "${input}" | clip.exe &>/dev/null # WSL

    else
        echo "Error: No clipboard utility found!" >&2
        return 1
    fi
}

function now() {
    local timestamp
    timestamp=$(date "+%Y-%m-%dT%H:%M:%S%z" | sed -E 's/([+-][0-9]{2})([0-9]{2})$/\1:\2/')
    echo "${timestamp}" | copy
    echo "${timestamp}"
}

function utc() {
    local timestamp
    timestamp=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
    echo "${timestamp}" | copy
    echo "${timestamp}"
}

function myip() {
    local ip
    ip=$(curl -s "https://api64.ipify.org")
    echo "${ip}" | copy
    echo "${ip}"
}

function myprivate() {
    local ip
    ip=$(ipconfig getifaddr en0)
    echo "${ip}" | copy
    echo "${ip}"
}

if command -v bat &>/dev/null; then
    alias cat="bat"
fi

if command -v batcat &>/dev/null; then
    alias cat="batcat"
fi

alias dog="cat"
alias please="sudo"
