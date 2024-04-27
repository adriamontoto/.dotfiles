# System functions
function Set-ParentDirectory {
    Set-Location ..
}

function New-SetDirectory([string] $directory_name) {
    New-Item -ItemType Directory -Path $directory_name
    Set-Location -Path $directory_name
}

function New-File() {
    foreach ($file in $args) {
        New-Item -ItemType File -Path $file
    }
}


# System aliases
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name lla -Value Get-ChildItem

${function:cll} = { clear; Get-ChildItem }

Set-Alias -Name .. -Value Set-ParentDirectory
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:~} = { Set-Location ~ }

${function:de} = { Set-Location ~\Desktop }
${function:desktop} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:p} = { Set-Location ~\Documents\sync\projects }
${function:projects} = { Set-Location ~\Documents\sync\projects }
${function:dw} = { Set-Location ~\Downloads }
${function:downloads} = { Set-Location ~\Downloads }
${function:dotfiles} = { Set-Location ~\.dotfiles }

Set-Alias -Name touch -Value New-File
Set-Alias -Name grep -Value findstr
Set-Alias -Name mkd -Value New-SetDirectory
${function:cwd} = { (Get-Location).Path | Set-Clipboard }


# Extra functions
function Get-IpAddress() {
    (Resolve-DnsName -Name myip.opendns.com -Server resolver1.opendns.com).IPAddress
}

function Get-LocalIpAddress() {
    $interfacesToCheck = @("Wi-Fi", "Ethernet")  # Add more interfaces if needed

    foreach ($interface in $interfacesToCheck) {
        try {
            $ip = (Get-NetIPAddress -InterfaceAlias $interface -AddressFamily IPv4 -ErrorAction Stop).IPAddress

            if ($ip) {
                return $ip
            }
        }
        catch {
            continue
        }
    }
}


# Extra aliases
Set-Alias -Name myip -Value Get-IpAddress
Set-Alias -Name localip -Value Get-LocalIpAddress
