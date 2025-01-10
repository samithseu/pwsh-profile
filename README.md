# PowerShell Profile

⌨️ This is a PowerShell profile that I use on Windows.

> [!IMPORTANT]
> To backup the old profile, run the following command:
>
> ```powershell
> Get-Content $PROFILE | Out-File PS_old_profile.bak
> ```

## Installation

To install the profile, run the following command:

```powershell
iwr "https://raw.githubusercontent.com/samithseu/pwsh-profile/main/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE
```
