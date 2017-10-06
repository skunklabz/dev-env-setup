#Posh-Docker
Import-Module posh-docker

#Octoposh
Set-OctopusConnectionInfo -URL <URL> -APIKey <API-KEY-GOES-HERE> | Out-Null

# Access history with up arrow
Import-Module PSReadLine

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Remember History
$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
Register-EngineEvent PowerShell.Exiting -Action { Get-History | Export-Clixml $HistoryFilePath } | out-null
if (Test-path $HistoryFilePath) { Import-Clixml $HistoryFilePath | Add-History }
# if you don't already have this configured...
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Aliases
# Requires: Find-Module Get-ChildItemColor | Install-Module -Force
Set-Alias ll Get-ChildItemColor
Set-Alias vi vim

#Change prompt to be git aware
Function prompt { 
  if($(git branch)){
    $branch = "[$(git branch)] "
  }
  Write-Host "$PWD " -NoNewline -ForegroundColor Gray
  Write-Host $branch -NoNewline -ForegroundColor Yellow
 }

 #Change console colors
 $console = $Host.UI.RawUI
 $console.ForegroundColor = 'gray'
 $console.BackgroundColor = 'black'
 $console.BufferSize.Width = 200
 $console.BufferSize.Height = 10000
 
