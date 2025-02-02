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
Set-Alias search es
if (Get-Command neofetch -ErrorAction SilentlyContinue) {
    Set-Alias -Name fetch -Value neofetch
} elseif (Get-Command winfetch -ErrorAction SilentlyContinue) {
    Set-Alias -Name fetch -Value winfetch
} else {
    Write-Host "Neither neofetch nor winfetch is installed."
}

# customize the prompt
function Prompt {
    # Get the current username
    $username = $env:USERNAME
    # Get the current direcotry
    $currentDir = (Get-Location | Split-Path -Leaf)
    if ($currentDir -eq $username) {
        $currentDir = "~"
    }
    # Set colors using Write-Host and escape sequences
    $boldYellow = "Yellow"      # Bold yellow color in PowerShell
    $green = "Green"      # Green color in PowerShell
    # Construct the prompt
    Write-Host "┌─[" -ForegroundColor $green -NoNewline
    Write-Host "$username" -ForegroundColor $boldYellow -NoNewline
    Write-Host " at " -ForegroundColor $green -NoNewline
    Write-Host "$currentDir" -ForegroundColor $boldYellow -NoNewline
    Write-Host "]" -ForegroundColor $green
    Write-Host "└─◉" -ForegroundColor $green -NoNewline
    return " "  # Ensure the prompt ends with a space for user input
}
