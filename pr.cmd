@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0pr.ps1""" %*"
exit /b %ErrorLevel%