param(
    [string]$edition,
    [string]$basePath = "",
    [switch]$noWeb = $false
)

$folder = Split-Path $PSCommandPath
$script = Join-Path $folder "vs.ps1"
& $script -channel:"VisualStudio.17.IntPreview" -title:"dev17 internal preview"