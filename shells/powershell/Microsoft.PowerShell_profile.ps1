oh-my-posh init pwsh --config "${env:POSH_THEMES_PATH}/robbyrussell.omp.json" | Invoke-Expression

Get-ChildItem -Path "${HOME}/.dotfiles/shells/aliases" -Recurse -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}
