param(
    [string]$edition,
    [string]$basePath = "",
    [switch]$noWeb = $false
)

$currentDir = Get-Location
$folder = Split-Path $PSCommandPath
$script = Join-Path $folder "vs.ps1"
& $script -channel:"VisualStudio.16.IntPreview" -title:"VS 2019"
Push-Location $currentDir