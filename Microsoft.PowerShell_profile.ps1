# Backup the old profile
Get-Item -Path $PROFILE | Move-Item -Destination "oldprofile.ps1" -Force
# Download the new profile
Invoke-RestMethod "https://raw.githubusercontent.com/samithseu/pwsh-profile/main/setup.ps1" -OutFile $PROFILE