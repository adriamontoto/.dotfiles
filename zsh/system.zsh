# System Functions
function mkd() {
    mkdir -p $1 && cd $1
}


# System Aliases
alias l='ls -la'
alias ll='ls -l'
alias la='ls -la'
alias lla='ls -la'

alias cls='clear'
alias cll='clear;ll'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias de='cd ~/Desktop'
alias desktop='cd ~/Desktop'
alias docs='cd ~/Documents'
alias p='cd ~/Documents/sync/projects'
alias projects='cd ~/Documents/sync/projects'
alias dw='cd ~/Downloads'
alias downloads='cd ~/Downloads'
alias dotfiles='cd ~/.dotfiles'

alias reload='exec $SHELL -l'


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
