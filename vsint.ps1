param(
    [string]$edition,
    [string]$basePath = "",
    [switch]$noWeb = $false
)

$folder = Split-Path $PSCommandPath
$script = Join-Path $folder "vs.ps1"
& $script -channel:"VisualStudio.16.IntPreview" -title:"16.10 P2"