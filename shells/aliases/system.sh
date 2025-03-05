# System functions
function mkd() {
    mkdir -p $1 && cd $1
}

function freverse_search() {
  LBUFFER=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | awk '!seen[$0]++' | fzf)
}

function fsearch_preview() {  
    IGNORED_FILES=(-not -name '.pyc' -not -name '.pyo' -not -name '.pyi' -not -name '.pyd')
    IGNORED_FOLDERS=(-not -path '.' -not -path '*venv' -not -path 'cache' -not -path '.git' -not -path 'node_modules*')

    RBUFFER=$(find . -type f "${IGNORED_FILES[@]}" "${IGNORED_FOLDERS[@]}" -o -type d "${IGNORED_FOLDERS[@]}" | fzf --prompt='Search> ' --query='' --preview '
        if [[ -d {} ]]; then
            eza --sort Name --long --all {}
        else
            bat --theme=OneHalfDark  --style=numbers --color=always --line-range=:500 {}
        fi
    ')
}

function fkill() {
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ -n "${pid}" ]; then
        LBUFFER="sudo kill -9 ${pid}"
    fi
}

function jump_code() {
    j $1 && code .
}

function jump_code_exit() {
    j $1 && code . && exit
}


# System aliases
alias l="eza --sort Name"
alias ll="eza --sort Name --long"
alias la="eza --sort Name --long --all"
alias lr="eza --sort Name --long --recurse"
alias lra="eza --sort Name --long --recurse --all"
alias lt="eza --sort Name --long --tree"
alias lta="eza --sort Name --long --tree --all"

alias cls="clear"
alias cll="clear;ll"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias de="cd ${HOME}/desktop"
alias desktop="cd ${HOME}/desktop"
alias docs="cd ${HOME}/documents"
alias p="cd ${HOME}/documents/projects"
alias projects="cd ${HOME}/documents/projects"
alias dw="cd ${HOME}/downloads"
alias downloads="cd ${HOME}/downloads"
alias dotfiles="cd ${HOME}/.dotfiles"

alias reload="exec ${SHELL} -l"

alias c="jump_code"
alias ce="jump_code_exit"

zle -N freverse_search
bindkey '^r' freverse_search

zle -N fsearch_preview
bindkey '^f' fsearch_preview

zle -N fkill
bindkey '^k' fkill


# Extra functions
function copy() {
    local input=$1

    if [ -z "${input}" ]; then
        input=$(cat)
    fi

    if command -v pbcopy &> /dev/null; then
        echo -n "${input}" | pbcopy &> /dev/null  # macOS

    elif command -v clip.exe &> /dev/null; then
        echo -n "${input}" | clip.exe &> /dev/null  # WSL

    else
        echo "Error: No clipboard utility found!" >&2
        return 1
    fi
}

function get_ip_address() {
    ip=$(curl -s ifconfig.co)
    echo "${ip}" | copy
    echo "${ip}"
}



# Extra aliases
alias myip="get_ip_address"

alias bat="batcat"
alias cat="bat"
alias dog="bat"
alias please="sudo"
