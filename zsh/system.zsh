# System Functions
function mkd() {
    mkdir -p $1 && cd $1
}

function freverse_search() {
  selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | awk '!seen[$0]++' | fzf)
  LBUFFER=$selected_command
}

function fsearch_preview() {  
    IGNORED_FILES=(-not -name '*.pyc' -not -name '*.pyo' -not -name '*.pyi' -not -name '*.pyd')
    IGNORED_FOLDERS=(-not -path '.' -not -path '**venv**' -not -path '**cache**' -not -path '**.git**' -not -path '**node_modules**')

    selected_command=$(find . -type f "${IGNORED_FILES[@]}" "${IGNORED_FOLDERS[@]}" -o -type d "${IGNORED_FOLDERS[@]}" | fzf --prompt='Search> ' --query='' --preview '
        if [[ -d {} ]]; then
            exa --sort Name --long --all {}
        else
            batcat --theme=OneHalfDark  --style=numbers --color=always --line-range=:500 {}
        fi
    ')

    RBUFFER=$selected_command
}

function fkill() {
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ -n "$pid" ]; then
        LBUFFER="sudo kill -9 $pid"
    fi
}


# System Aliases
alias l='exa --sort Name'
alias ll='exa --sort Name --long'
alias la='exa --sort Name --long --all'
alias lr='exa --sort Name --long --recurse'
alias lra='exa --sort Name --long --recurse --all'
alias lt="exa --sort Name --long --tree"
alias lta="exa --sort Name --long --tree --all"

alias cls='clear'
alias cll='clear;ll'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias de='cd ~/desktop'
alias desktop='cd ~/desktop'
alias docs='cd ~/documents'
alias p='cd ~/documents/projects'
alias projects='cd ~/documents/projects'
alias dw='cd ~/downloads'
alias downloads='cd ~/downloads'
alias dotfiles='cd ~/.dotfiles'

alias reload='exec $SHELL -l'

zle -N freverse_search
bindkey '^r' freverse_search

zle -N fsearch_preview
bindkey '^f' fsearch_preview

zle -N fkill
bindkey '^k' fkill


# Extra Functions
function get_ip_address() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

function get_local_ip_address() {
    interfaces_to_check=("wlan0" "eth0")  # Add more interfaces if needed

    for interface in "${interfaces_to_check[@]}"; do
        ip=$(ip a show $interface 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

        if [ -n "$ip" ]; then
            echo $ip
            return
        fi
    done
}


# Extra Aliases
alias myip='get_ip_address'
alias localip='get_local_ip_address'

alias dog='cat'
alias please='sudo'
