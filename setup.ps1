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

# alias for clear screen
Set-Alias -Name "cls" -Value "Clear-Host"
# alias for packages update
Set-Alias -Name "update" -Value "CheckUpdates"
# alias for checking binary path
Set-Alias -Name "which" -Value "where.exe"
# alias for `sudo`
Set-Alias -Name "sudo" -Value "WithArgsSudo"
# alias for is admin
Set-Alias -Name "isadmin" -Value "IsCurrentSessionAdmin"


if (Get-Command neofetch -ErrorAction SilentlyContinue) {
    Set-Alias -Name fetch -Value neofetch
} elseif (Get-Command winfetch -ErrorAction SilentlyContinue) {
    Set-Alias -Name fetch -Value winfetch
} else {
    Write-Host "Neither neofetch nor winfetch is installed."
}

# checking if current session is admin
function IsCurrentSessionAdmin {
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# function to check available package updates
function CheckUpdates {
    winget upgrade
    choco outdated
    pip list --outdated
}

# customize the prompt
function Prompt {
    # Get the current username
    $username = $env:USERNAME
    # Get the current direcotry
    $currentDir = (Get-Location | Split-Path -Leaf)

    # if the current directory is the same as username, set it to '~'
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
    Write-Host "└─$" -ForegroundColor $green -NoNewline
    return " "  # Ensure the prompt ends with a space for user input
}

# making sudo function to accept multiple arguments
function WithArgsSudo {
    param (
        [Parameter(ValueFromRemainingArguments)]
        [string[]]$values
    )

    if ($values.Count -ge 1 -and $values[0] -eq '-ps') {
        # Remove -ps from arguments
        $command = $values[1..($values.Count - 1)] -join ' '
        # Run with pwsh.exe and sudo
        Start-Process -FilePath "sudo" -ArgumentList "pwsh.exe", "-Command", $command -Wait -NoNewWindow
    }
    else {
        # Fallback to regular sudo behavior
        Start-Process -FilePath "sudo" -ArgumentList $values -Wait -NoNewWindow
    }
}
