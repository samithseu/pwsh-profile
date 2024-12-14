# clear terminal
Clear-Host
# install PSReadLine module
# check if the module is already installed
if (!(Get-Module -ListAvailable -Name PSReadLine)) {
  Install-Module PSReadLine -Force -SkipPublisherCheck
}
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView

# for `refreshenv` command to work
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
  Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
}

# setting alias
Set-Alias cls Clear-Host
Set-Alias fetch neofetch
Set-Alias search es

# customize the prompt
function Prompt {
    $currentDir = (Get-Location | Split-Path -Leaf)
    # Set colors using Write-Host and escape sequences
    $boldYellow = "Yellow"      # Bold yellow color in PowerShell
    # Construct the prompt
    Write-Host "┌─[$currentDir]" -ForegroundColor $boldYellow
    Write-Host "└─◉" -ForegroundColor $boldYellow -NoNewline
    return " "  # Ensure the prompt ends with a space for user input
}