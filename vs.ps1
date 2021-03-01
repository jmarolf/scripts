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
# if ($PromptEnvironment -ne $null) {
#     write-host "error: Prompt is already in a custom environment." -ForegroundColor Red
#     exit 1
# }

$vswhere = join-path ( join-path (join-path ${env:ProgramFiles(x86)} "Microsoft Visual Studio") "Installer") "vswhere.exe"
$args = @('-prerelease', '-format', 'json')
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


# if ((test-path $cmdPath) -eq $false) {
#     write-warning "File not found: $cmdPath"
#     exit 1
# }

# # Run VsDevCmd.bat and then dump all environment variables, so we can
# # overwrite ours with theirs
# $tempFile = [IO.Path]::GetTempFileName()

# cmd /c " `"$cmdPath`" && set > `"$tempFile`" "

# Get-Content $tempFile | %{
#     if ($_ -match "^(.*?)=(.*)$") {
#         Set-Content "env:\$($matches[1])" $matches[2]
#     }
# }

# # Optionally add the external web tools unless skipped
# if ($noWeb -eq $false) {
#     $path = join-path (join-path (join-path $basePath $edition) "Web") "External"

#     if (test-path $path) {
#         append-path $path
#     } else {
#         write-warning "Path $path not found; specify -noWeb to skip searching for web tools"
#     }
# }

# Set the prompt environment variable (printed in our prompt function)
$global:PromptEnvironment = "  $title v$vsInstallationVersion "