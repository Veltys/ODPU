#!/usr/bin/env pwsh
# Title         : generator.ps1
# Description   : Script to batch generating dynamic DNS updaters
# Author        : Veltys
# Date          : 2022-12-15
# Version       : 1.0.0
# Usage         : powershell generator.ps1
# Notes         : 


$user = ''
$password = ''

$hosts = @('');

if(                                                                                     # Some tests to avoid mistakes (mainly empty vars)
    [string]::IsNullOrEmpty($user) -or
    [string]::IsNullOrEmpty($password) -or
    $hosts.Length -eq 0 -or
    ($hosts.Length -eq 1 -and [string]::IsNullOrEmpty($hosts[0]))
    ) {
    $error = 1

    Write-Output 'ERROR: Please fill all the required parameters before using'
}
else {
    for($i = 0; $i -lt $hosts.Length; $i++) {
        $machine = $hosts[$i].Split('.')[0]
        $machine = $machine.substring(0,1).toupper() + $machine.substring(1).tolower()

        $text = Get-Content -Path updater.ps1 # -Raw
        $text = $text.replace('$user = ''''', "`$user = '$user'")
        $text = $text.replace('$password = ''''', "`$password = '$password'")
        # $text = $text.replace("`$hosts = @(`n''", "`$hosts = @(`n'$($hosts[$i])'")    # New lines are odd 
        $text = $text.replace('''''', "'$($hosts[$i])'")

        Set-Content -Path "$machine.ps1" -Value $text
    }
}

Exit $error