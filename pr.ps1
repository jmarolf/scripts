[CmdletBinding(PositionalBinding=$false)]
Param(
)

try {
    & git fetch --all --prune
    & git push origin
    & hub pull-request
}
catch {
  Write-Host $_.ScriptStackTrace
}