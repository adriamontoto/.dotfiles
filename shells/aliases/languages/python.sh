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

# Python aliases
alias py="python"
alias pip="noglob python -m pip"
alias create="create_pyvenv"
alias activate="activate_pyvenv"
# deactivate is a built-in command in Python
alias remove="remove_pyvenv"
