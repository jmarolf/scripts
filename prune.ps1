[CmdletBinding(PositionalBinding=$false)]
Param(
)

try {
    & git fetch --all --prune
    git branch -r --merged upstream/master --no-color | grep -v \* |  % { 
      $strVal = $_.Trim()
      if($strVal -like 'origin/*') {
          & git push -d origin ($strVal -split "/", 2)[1]
      }
    }
    & git fetch --all --prune
}
catch {
  Write-Host $_.ScriptStackTrace
}
