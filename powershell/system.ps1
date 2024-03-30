# System functions
function Set-ParentDirectory {
    Set-Location ..
}

function New-SetDirectory([string] $directory_name) {
    New-Item -ItemType Directory -Path $directory_name
    Set-Location -Path $directory_name
}

function New-File([string] $file_name) {
    New-Item -ItemType File -Path $file_name
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

Set-Alias -Name touch -Value New-File
Set-Alias -Name mkd -Value New-SetDirectory


# Extra functions
function Get-IpAddress() {
    (Resolve-DnsName -Name myip.opendns.com -Server resolver1.opendns.com).IPAddress
}

function Get-LocalIpAddress() {
    $ip = (Get-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4).IPAddress

    if (-not $ip) {
        $ip = (Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).IPAddress
    }

    # Add more interfaces here
    # if (-not $ip) {
    #     $ip = (Get-NetIPAddress -InterfaceAlias "<interface-name>" -AddressFamily IPv4).IPAddress
    # }

    return $ip
}


# Extra aliases
Set-Alias -Name ip -Value Get-IpAddress
Set-Alias -Name localip -Value Get-LocalIpAddress
