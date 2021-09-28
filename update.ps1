winget export -o installedPrograms.json
$installedPrograms = Get-Content -Raw -Path installedPrograms.json | ConvertFrom-Json
$installedPackages= ($installedPrograms.Sources | Select-Object -Property Packages).Packages 
$installedPackages 
    | Where-Object {$_.PackageIdentifier -notlike "Microsoft.Teams"}
    | Where-Object {$_.PackageIdentifier -notlike "Microsoft.VisualStudio.2022*"}
    | Where-Object {$_.PackageIdentifier -notlike "Microsoft.VisualStudio.2019*"}
    | Where-Object {$_.PackageIdentifier -notlike "NZXT.CAM"}
    | Where-Object {$_.PackageIdentifier -notlike "b1f79681"}
    | Where-Object {$_.PackageIdentifier -notlike "BlueMicrophones.BlueSherpa"}
    | ForEach-Object { 
        winget upgrade --id $_.PackageIdentifier
    }
Remove-Item installedPrograms.json