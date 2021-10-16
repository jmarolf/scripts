param(
    [string]$edition = "Enterprise",
    [string]$version = "2019",
    [string]$basePath = "",
    [switch]$noWeb = $false,
    [string]$title = "",
    [string]$channel = "intpreview"
)

function append-path {
    param(
        [string[]][Parameter(Mandatory = $true)]$pathsToAdd
    )

    $local:separator = ";"
    if (($PSVersionTable.PSVersion.Major -gt 5) -and ($PSVersionTable.Platform -eq "Unix")) {
        $local:separator = ":"
    }

    $env:PATH = $env:PATH + $local:separator + ($pathsToAdd -join $local:separator)
}

# Only support one prompt environment at a time
if ($PromptEnvironment -ne $null) {
    write-host "error: Prompt is already in a custom environment." -ForegroundColor Red
    exit 1
}

$vswhere = join-path ( join-path (join-path ${env:ProgramFiles(x86)} "Microsoft Visual Studio") "Installer") "vswhere.exe"
$args = @('-all', '-prerelease', '-format', 'json')
$vsInfos =& $vswhere $args | ConvertFrom-Json
ForEach ($vsInfo In $vsInfos) {
    if ($vsInfo.channelId -like "*$channel*") {
        $vsInstallDir = $vsInfo.installationPath
        $vsInstallationVersion = $vsInfo.installationVersion
        $instanceId=$vsInfo.instanceId
        break
    }
}

# Find VsDevCmd.bat
$path = join-path (join-path $vsInstallDir "Common7") "Tools"

if ((test-path $path) -eq $false) {
    write-warning "Visual Studio $version edition '$edition' could not be found."
    exit 1
}

$cmdPath = join-path $path "Launch-VsDevShell.ps1"
& $cmdPath -VsInstanceId:$instanceId

# Set the prompt environment variable (printed in our prompt function)
$vsMajorVersion = $vsInstallationVersion.Split('.')[0]
$vsMinorVersion = $vsInstallationVersion.Split('.')[1]
$displayString = "$vsMajorVersion.$vsMinorVersion"

$global:PromptEnvironment = "  v$displayString "