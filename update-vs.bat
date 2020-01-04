call \\ddrelqa\preinstall\Preinstall.cmd
call C:\PROGRA~2\MICROS~2\Installer\vs_installer.exe update --quiet --norestart --installpath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community"
call C:\PROGRA~2\MICROS~2\Installer\vs_installer.exe update --quiet --norestart --installpath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview"
call C:\PROGRA~2\MICROS~2\Installer\vs_installer.exe update --quiet --norestart --installpath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview.Released"
choco upgrade all -y
