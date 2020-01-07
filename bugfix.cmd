@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0new.ps1""" -bugfix -a %*"
exit /b %ErrorLevel%