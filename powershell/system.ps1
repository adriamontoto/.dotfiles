# System functions
function Set-ParentDirectory {
	Set-Location ..
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
