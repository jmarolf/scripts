[CmdletBinding(PositionalBinding=$false)]
Param(
  [string][Alias('a')]$alias,
  [switch] $bugfix,
  [switch] $feature
)

try {
    & git stash
    & git fetch --all --prune
    if ($bugfix) {
        & git checkout -b bugfix/$alias upstream/master
    }
    
    if ($feature) {
        & git checkout -b feature/$alias upstream/master
    }
    
    if ((-not $bugfix) -and (-not $feature)) {
        & git checkout -b $alias upstream/master
    }
}
catch {
  Write-Host $_.ScriptStackTrace
}
