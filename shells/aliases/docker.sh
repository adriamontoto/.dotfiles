# Docker functions
function docker_container_connect() {
    local container=$(
        docker ps --all |
            fzf \
                --cycle \
                --border \
                --no-sort \
                --header-lines=1 \
                --layout="reverse-list" \
                --prompt="Connect Container> " \
                --preview='echo {} | awk "{print \$1}" | xargs -I{} docker logs --tail 100 {} 2>/dev/null' |
            awk '{print $1}'
    )

    if [[ -z "${container}" ]]; then
        return 1
    fi

    echo "Connecting to container with id: \"${container}\"\n"
    if docker exec "${container}" zsh &>/dev/null; then
        docker exec --interactive --tty "${container}" zsh

    elif docker exec "${container}" bash &>/dev/null; then
        docker exec --interactive --tty "${container}" bash

    else
        docker exec --interactive --tty "${container}" sh
    fi
}

function docker_container_remove() {
    local container=$(
        docker ps --all |
            fzf \
                --cycle \
                --border \
                --no-sort \
                --header-lines=1 \
                --layout="reverse-list" \
                --prompt="Remove Container> " \
                --preview='echo {} | awk "{print \$1}" | xargs -I{} docker logs --tail 100 {} 2>/dev/null' |
            awk '{print $1}'
    )

    if [[ -z "${container}" ]]; then
        return 1
    fi

    echo "Removing container with id: \"${container}\"\n"
    docker stop "${container}" 1>/dev/null
    docker rm "${container}" 1>/dev/null
}

function docker_container_restart() {
    local container=$(
        docker ps --all |
            fzf \
                --cycle \
                --border \
                --no-sort \
                --header-lines=1 \
                --layout="reverse-list" \
                --prompt="Restart Container> " \
                --preview='echo {} | awk "{print \$1}" | xargs -I{} docker logs --tail 100 {} 2>/dev/null' |
            awk '{print $1}'
    )

    if [[ -z "${container}" ]]; then
        return 1
    fi

    echo "Restarting container with id: \"${container}\"\n"
    docker restart "${container}" 1>/dev/null
}

function docker_volume_connect() {
    local volume=$(
        docker volume ls |
            fzf \
                --cycle \
                --border \
                --no-sort \
                --header-lines=1 \
                --layout="reverse-list" \
                --prompt="Connect Volume> " |
            awk '{print $2}'
    )

    if [[ -z "${volume}" ]]; then
        return 1
    fi

    echo "Connecting to volume with name: \"${volume}\"\n"
    docker run --rm --interactive --tty --volume "${volume}:/mnt" --workdir /mnt alpine sh
}

function docker_volume_remove() {
    local volume=$(
        docker volume ls |
            fzf \
                --cycle \
                --border \
                --no-sort \
                --header-lines=1 \
                --layout="reverse-list" \
                --prompt="Remove Volume> " |
            awk '{print $2}'
    )

    if [[ -z "${volume}" ]]; then
        return 1
    fi

    echo "Removing volume with name: \"${volume}\" \n"
    docker volume rm "${volume}" 1>/dev/null
}

# Docker aliases
alias dc="docker_container_connect"
alias dr="docker_container_remove"
alias drs="docker_container_restart"
alias dp="docker system prune --all --force"
alias dv="docker_volume_connect"
alias dvr="docker_volume_remove"
alias dvp="docker volume prune --force"
alias ddu="docker system df"
