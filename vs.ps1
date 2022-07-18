param(
    [string]$channel = "VisualStudio.17.IntPreview"
)

$vswhere = join-path ( join-path (join-path ${env:ProgramFiles(x86)} "Microsoft Visual Studio") "Installer") "vswhere.exe"
$args = @('-all', '-prerelease', '-format', 'json')
$hightestVersion = [System.Management.Automation.SemanticVersion]"0.0.0"
$vsInfos =& "$vswhere" $args | ConvertFrom-Json
ForEach ($vsInfo In $vsInfos) {
    if ($vsInfo.channelId -like $channel) {
        $vsInstallDir = $vsInfo.installationPath
        $instanceId=$vsInfo.instanceId
        break
    }

    $versionString = [string]$vsInfo.catalog.productSemanticVersion
    if ($versionString.Indexof("-pre") -ne -1) {
        $vsVersion = [System.Management.Automation.SemanticVersion]$versionString
    }
    else {
        $vsVersion = [System.Management.Automation.SemanticVersion](($versionString -split "\+")[0])
    }
    if ($vsVersion -gt $hightestVersion) {
        $hightestVersion = $vsVersion 
        $vsInstallDir = $vsInfo.installationPath
        $instanceId=$vsInfo.instanceId
    }
}

# Find VsDevCmd.bat
$path = join-path (join-path $vsInstallDir "Common7") "Tools"

if ((test-path $path) -eq $false) {
    write-warning "Visual Studio $version edition '$edition' could not be found."
    exit 1
}

$cmdPath = join-path $path "Launch-VsDevShell.ps1"
& $cmdPath -VsInstanceId:$instanceId -Arch amd64 -VsWherePath "$vswhere"
