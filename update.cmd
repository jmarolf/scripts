
powershell -noprofile -executionPolicy Unrestricted  -file "%~dp0update.ps1"
call update-vs.bat
choco upgrade all -y
scoop update
scoop update *