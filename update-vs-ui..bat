call \\ddrelqa\preinstall\Preinstall.cmd
call C:\PROGRA~2\MICROS~2\Installer\vs_installer.exe update --passive --norestart --installpath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community"
call C:\PROGRA~2\MICROS~2\Installer\vs_installer.exe update --passive --norestart --installpath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview.Released"
call C:\PROGRA~2\MICROS~2\Installer\vs_installer.exe update --passive --norestart --installpath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview"
choco upgrade all -y
