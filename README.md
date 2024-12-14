# PowerShell Profile

⌨️ This is a PowerShell profile that I use on Windows.

## Backup Old Profile

To backup the old profile, run the following command:

```powershell
Get-Content $PROFILE | Out-File PS_old_profile.bak
```

## Installation

To install the profile, run the following command:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/samithseu/pwsh-profile/34333914ed400e5ab1afba4e514b307c5800a960/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE
```
