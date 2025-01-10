# Backup the old profile
$profilePath = Split-Path -Path $PROFILE
Get-Item -Path $PROFILE | Move-Item -Destination $profilePath\oldprofile.ps1 -Force
# Download the new profile
Invoke-RestMethod "https://raw.githubusercontent.com/samithseu/pwsh-profile/main/setup.ps1" -OutFile $PROFILE