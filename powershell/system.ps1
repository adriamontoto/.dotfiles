# System functions
function Set-ParentDirectory {
	Set-Location ..
}

function New-SetDirectory([string] $directory_name) {
    New-Item -ItemType Directory -Path $directory_name
    Set-Location -Path $directory_name
}

# System aliases
Set-Alias -Name .. -Value Set-ParentDirectory
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:~} = { Set-Location ~ }

${function:de} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:p} = { Set-Location ~\Documents\sync\projects }
${function:dw} = { Set-Location ~\Downloads }

Set-Alias -Name mkd -Value New-SetDirectory
