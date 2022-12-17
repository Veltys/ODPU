# OVH DNS PowerShell Updater

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/75c795c189724fecbaa44c8133020213)](https://www.codacy.com/gh/Veltys/ODPU/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Veltys/ODPU&amp;utm_campaign=Badge_Grade)

Script to update dynamic DNS services provided by OVH

## Description
Script that can be used to automatically update the dynamic DNS services provided by OVH, ensuring a domain name always points to the right IP address even if it changes over time

## Systems
- **generator.ps1**: Batch generator of custom DDNS updaters
- **updater.ps1**: Dynamic DNS updater system

## Version history
### ➡ 1.1.1 - 2022-12-17
#### Fixed
- Improved code quality

### ➡ 1.1.0 - 2022-12-15
#### Added
- Batch generator system

### ➡ 1.0.0 - 2022-12-15
- Initial version, with all required features implemented
