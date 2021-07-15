param(
    [string]$edition,
    [string]$basePath = "",
    [switch]$noWeb = $false
)

$currentDir = Get-Location
$folder = Split-Path $PSCommandPath
$script = Join-Path $folder "vs.ps1"
& $script -channel:"VisualStudio.17.IntPreview" -title:"dev17 internal preview"
Push-Location $currentDir