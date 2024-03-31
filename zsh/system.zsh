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


# Extra Functions
function get_ip_address() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

function get_local_ip_address() {
    ip=$(ip a show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

    if [ -z "$ip" ]; then
        ip=$(ip a show eth0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    fi

    # Add more interfaces here
    # if [ -z "$ip" ]; then
    #     ip=$(ip a show <interface-name> | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    # fi

    echo $ip
}


# Extra Aliases
alias myip='get_ip_address'
alias iplocal='get_local_ip_address'

alias dog='cat'
alias please='sudo'
