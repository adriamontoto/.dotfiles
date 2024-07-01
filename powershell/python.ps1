# Python functions
function Set-PyvenvActive([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    . $venvName/Scripts/Activate.ps1
}

function New-Pyvenv([string] $venvName) {
    if ([string]::IsNullOrEmpty($venvName)) {
        $venvName = ".venv"
    }

    if (Test-Path $venvName) {
        return
    }

    python -m venv $venvName
    Set-PyvenvActive $venvName
    python.exe -m pip install --upgrade pip
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

function Install-Requirements([string] $requirementsFile) {
    if ([string]::IsNullOrEmpty($requirementsFile)) {
        $requirementsFile = "requirements.txt"
    }

    pip install -r $requirementsFile
}

function Install-DevRequirements() {
    Install-Requirements "requirements_dev.txt"
}


# Python aliases
Set-Alias -Name py -Value python
Set-Alias -Name python3 -Value python

Set-Alias -Name create -Value New-Pyvenv
Set-Alias -Name activate -Value Set-PyvenvActive
# deactivate is a built-in command in Python
Set-Alias -Name remove -Value Remove-Pyvenv

Set-Alias -Name install -Value Install-DevRequirements
Set-Alias -Name installr -Value Install-Requirements
Set-Alias -Name installd -Value Install-DevRequirements

${function:pipi} = { pip install $args }
${function:pipu} = { pip uninstall $args }
${function:pips} = { pip show $args }
${function:pipl} = { pip list }