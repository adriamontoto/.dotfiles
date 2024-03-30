oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/robbyrussell.omp.json" | Invoke-Expression

# Load all the scripts and aliases
Push-Location (Split-Path -parent $MyInvocation.MyCommand.Path)
"system", "python", "git" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location
