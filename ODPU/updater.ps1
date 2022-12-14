#!/usr/bin/env pwsh
# Title         : updater.ps1
# Description   : Script to update dynamic DNS services provided by OVH
# Author        : Veltys
# Date          : 2022-12-15
# Version       : 1.0.0
# Usage         : powershell updater.ps1
# Notes         : Must be run as superuser


## Parameters
$user = ''
$password = ''

$hosts = @(
    ''
);

$url = 'https://www.ovh.com/nic/update?system=dyndns'

## Log (1 = true, 0 = false)
$log = 1

## Debug (1 = true, 0 = false)
$debug = 0

## Error status (0 means everything OK)
$error = 0

if(                                                                                     # Some tests to avoid mistakes (mainly empty vars)
    [string]::IsNullOrEmpty($user) -or
    [string]::IsNullOrEmpty($password) -or
    $hosts.Length -eq 0 -or
    ($hosts.Length -eq 1 -and [string]::IsNullOrEmpty($hosts[0])) -or
    [string]::IsNullOrEmpty($url) -or
    [string]::IsNullOrEmpty($log) -or
    [string]::IsNullOrEmpty($debug)
    ) {
    $error = 1

    Write-Output 'ERROR: Please fill all the required parameters before using'
}
else {
    for($i = 0; $i -lt $hosts.Length; $i++) {                                           # More than one dynhost? No problem!
        try {
            $message = Invoke-WebRequest -Uri ($url + '&hostname=' + $hosts[$i]) -Headers @{'Authorization' = 'Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($user + ':' + $password))} -Method Get
            }
        catch {
            $error = 1

            $message = $_.Exception.Response
        }

        if($log -eq 1) {                                                                # Sould I log the operation?
	            if(![System.Diagnostics.EventLog]::SourceExists('OVH DNS PowerShell Updater')) {
	                New-EventLog -LogName Application -Source 'OVH DNS PowerShell Updater'
	            }

    	        Write-EventLog -ComputerName $env:COMPUTERNAME -LogName Application -Source 'OVH DNS PowerShell Updater' -EventID 00000 -Message $message
        }

        if($debug -eq 1) {                                                              # Sould I echo the operation?
            Write-Output $message
        }
    }
}

Exit $error
