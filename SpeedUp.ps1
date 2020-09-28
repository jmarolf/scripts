# Example usage:
#
# .\SpeedUp.ps1 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise' -check
# .\SpeedUp.ps1 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview' -check

param (
    [string]$installPath,
    [switch]$check
)

Add-Type -AssemblyName 'System.Xml.Linq'
function Test-Config([string]$path) {
    $doc = [Xml.Linq.XDocument]::Load($path)
    $enabled = [Xml.XPath.Extensions]::XPathSelectElements($doc, '/configuration/runtime/gcServer[@enabled="true"]')
    return [Linq.Enumerable]::Any($enabled)
}

function Backup-File([string]$path) {
    $backupIndex = 0
    while ($true) {
        if ($backupIndex -eq 0) {
            $backupPath = $path + '.bak'
        } else {
            $backupPath = $path + ".bak$backupIndex"
        }

        if (Test-Path $backupPath) {
            $backupIndex++
            continue
        }

        Copy-Item $path $backupPath
        return
    }
}

function Fix-Config([string]$path) {
    $lines = [IO.File]::ReadAllLines($path)
    $insertIndex = -1
    foreach ($i in 0..($lines.Count - 1)) {
        if ($lines[$i] -match '^\s*<runtime>$') {
            $insertIndex = $i + 1
            break
        }
    }

    if ($insertIndex -eq -1) {
        Write-Host "Could not find <runtime> element"
        return
    }

    #Write-Host "Found <runtime> element at index ${$insertIndex - 1}"
    [Collections.ArrayList]$list = $lines
    $newLine = $lines[$insertIndex - 1] -replace "<runtime>", '  <gcServer enabled="true" />'
    #Write-Host $lines[$insertIndex - 1]
    #Write-Host $newLine

    if (-not $check) {
        Backup-File $path

        $list.Insert($insertIndex, $newLine)
        $newContent = $list -join "`r`n"
        [IO.File]::WriteAllText($path, $newContent)
    }
}

$configPaths = @(
    'Common7\ServiceHub\Hosts\ServiceHub.Host.CLR.x86\ServiceHub.RoslynCodeAnalysisService32.exe.config'
    'Common7\ServiceHub\Hosts\ServiceHub.Host.CLR.AnyCPU\ServiceHub.RoslynCodeAnalysisService.exe.config'
    'MSBuild\Current\Bin\MSBuild.exe.config'
    'Common7\IDE\Extensions\TestPlatform\testhost.exe.config'
    'Common7\IDE\Extensions\TestPlatform\testhost.x86.exe.config'
    'Common7\ServiceHub\Hosts\ServiceHub.Host.CLR.AnyCPU\ServiceHub.TestWindowStoreHost.exe.config'
)

foreach ($configPath in $configPaths) {
    $fullConfigPath = Join-Path $installPath $configPath
    $fileName = Split-Path $fullConfigPath -leaf
    if (-not (Test-Path $fullConfigPath)) {
        Write-Host "${fileName}: File does not exist"
        continue
    }

    if (Test-Config $fullConfigPath) {
        Write-Host "${fileName}: File is already configured" -ForegroundColor Green
    } else {
        Write-Host "${fileName}: File is not configured" -ForegroundColor Red
        Fix-Config $fullConfigPath
    }
}

$vsregedit = Join-Path $installPath 'Common7\IDE\VsRegEdit.exe'
if ($check) {
    &$vsregedit read "$installPath" HKCU 'Roslyn\Internal\OnOff\Features' OOP64Bit dword
    &$vsregedit read "$installPath" HKCU 'Roslyn\Internal\OnOff\Features' SQLiteInMemoryWriteCache dword
} else {
    &$vsregedit set "$installPath" HKCU 'Roslyn\Internal\OnOff\Features' OOP64Bit dword 1
    &$vsregedit set "$installPath" HKCU 'Roslyn\Internal\OnOff\Features' SQLiteInMemoryWriteCache dword 1
}