[CmdletBinding(PositionalBinding=$false)]
Param(
  [string][Alias('a')]$alias,
  [switch] $bugfix,
  [switch] $feature,
  [switch] $infra
)

try {
    $path = "C:\source\_w\"
    $branch = $alias
    if ($bugfix) {
        $branch = "bugfix/$alias"
    }
    if ($feature) {
        $branch = "features/$alias"
    }
    if ($infra) {
        $branch = "infrastructure/$alias"
    }
    $path = Join-Path $path $branch
    
    New-Item -ItemType Directory -Force -Path $path
    & git fetch --all --prune
    & git worktree add --track -b $branch $path upstream/main
    Set-Location -LiteralPath $path
}
catch {
  Write-Host $_.ScriptStackTrace
}
