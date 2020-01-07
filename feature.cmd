@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0new.ps1""" -feature -a %*"
exit /b %ErrorLevel%