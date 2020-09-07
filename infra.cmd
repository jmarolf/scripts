@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0new.ps1""" -infra -a %*"
exit /b %ErrorLevel%