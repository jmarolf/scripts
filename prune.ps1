[CmdletBinding(PositionalBinding=$false)]
Param(
)

try {
    & git fetch --all --prune
    git branch --merged upstream/master --no-color | grep -v \* |  % { & git branch -D $_.Trim() }
}
catch {
  Write-Host $_.ScriptStackTrace
}
