# Javascript functions
function run_nvm() {
    export NVM_DIR="${HOME}/.nvm"
    if command -v brew &>/dev/null && [ -n "$(brew --prefix nvm 2>/dev/null)" ]; then
        export NVM_DIR="$(brew --prefix nvm)"
    fi

    [[ -s "${NVM_DIR}/nvm.sh" ]] && source "${NVM_DIR}/nvm.sh"

    if [[ -s "${NVM_DIR}/etc/bash_completion.d/nvm" ]]; then
        source "${NVM_DIR}/etc/bash_completion.d/nvm"

    elif [[ -s "${NVM_DIR}/bash_completion" ]]; then
        source "${NVM_DIR}/bash_completion"
    fi
}

function nvm() {
    unset -f nvm node npm
    run_nvm
    nvm "${@}"
}

function node() {
    unset -f nvm node npm
    run_nvm
    node "${@}"
}

function npm() {
    unset -f nvm node npm
    run_nvm
    npm "${@}"
}

# Javascript aliases
