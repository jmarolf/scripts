# Update chocolatey apps
& choco upgrade all -y

# Update Apps installed via winget
& winget upgrade --all

# Update Windows Store Apps
Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod

# Update Visual Studio Installations
& vs update all

# Update Steam Apps
& "C:\Users\jmarolf\source\repos\UpdateSteam\UpdateSteam\bin\Release\net7.0\UpdateSteam.exe"

# Install Windows Updates
Install-WindowsUpdate
