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
function get_ip_address() {
    curl ifconfig.co
}

function get_local_ip_address() {
    INTERFACES_TO_CHECK=("wlan0" "eth0")  # Add more interfaces if needed

    for interface in "${INTERFACES_TO_CHECK[@]}"; do
        ip=$(ip a show $interface 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

        if [ -n "$ip" ]; then
            echo $ip
            return
        fi
    done
}


# Extra Aliases
alias myip="get_ip_address"
alias localip="get_local_ip_address"

alias bat="batcat"
alias cat="bat"
alias dog="bat"
alias please="sudo"
