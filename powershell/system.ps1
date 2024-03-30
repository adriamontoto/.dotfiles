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

function Clear-List() {
    Clear-Host
    Get-ChildItem
}


# System aliases
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name lla -Value Get-ChildItem

Set-Alias -Name cll -Value Clear-List

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
