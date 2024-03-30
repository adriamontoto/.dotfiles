# Python functions
function Set-PyvenvActive([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    . $venvName/Scripts/Activate.ps1
    pip install --upgrade pip
}

function New-Pyvenv([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    if (Test-Path $venvName) {
        return
    }

    python -m venv $venvName
    Activate-Pyvenv $venvName
}

function Remove-Pyvenv([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    if (-not (Test-Path $venvName)) {
        return
    }

    try {
        deactivate
    }
    catch {
        # If the virtual environment is not active, deactivate will throw an error
    }

    Remove-Item $venvName -Recurse -Force
}


# Python aliases
Set-Alias -Name py -Value python
Set-Alias -Name python3 -Value python

Set-Alias -Name create -Value New-Pyvenv
Set-Alias -Name activate -Value Set-PyvenvActive
# deactivate is a built-in command in Python
Set-Alias -Name remove -Value Remove-Pyvenv
