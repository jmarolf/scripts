winget export -o installedPrograms.json
$installedPrograms = Get-Content -Raw -Path installedPrograms.json | ConvertFrom-Json
$installedPackages= ($installedPrograms.Sources | Select-Object -Property Packages).Packages 
$installedPackages 
    | Where-Object {$_.PackageIdentifier -notlike "Microsoft.Teams"}
    | ForEach-Object { 
        winget upgrade --id $_.PackageIdentifier
    }