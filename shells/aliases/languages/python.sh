# Python functions
function activate_pyvenv() {
    local venv_name="${1}"
    if [[ -z "${venv_name}" ]]; then
        venv_name=".venv"
    fi

    if [[ ! -d "${venv_name}" ]]; then
        return 1
    fi

    source "${venv_name}/bin/activate"
}

function create_pyvenv() {
    local venv_name="${1}"
    if [[ -z "${venv_name}" ]]; then
        venv_name=".venv"
    fi

    if [[ -d "${venv_name}" ]]; then
        return 1
    fi

    python -m venv "${venv_name}"
    activate_pyvenv "${venv_name}"
    python -m pip install --upgrade pip
}

function remove_pyvenv() {
    local venv_name="${1}"
    if [[ -z "${venv_name}" ]]; then
        venv_name=".venv"
    fi

    if [[ ! -d "${venv_name}" ]]; then
        return 1
    fi

    deactivate || true
    rm -rf "${venv_name}"
}

function install_requirements() {
    local requirements_file="${1}"
    if [[ -z "${requirements_file}" ]]; then
        requirements_file="requirements.txt"
    fi

    python -m pip install -r "${requirements_file}"
}

function install_dev_requirements() {
    install_requirements "requirements_dev.txt"
}

# Python aliases
alias py="python3.13"
alias python="python3.13"
alias pip="noglob python3.13 -m pip"
alias create="create_pyvenv"
alias activate="activate_pyvenv"
# deactivate is a built-in command in Python
alias remove="remove_pyvenv"

alias install="install_dev_requirements"
alias installr="install_requirements"
alias installd="install_dev_requirements"
