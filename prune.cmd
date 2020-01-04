@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0prune.ps1""" %*"
exit /b %ErrorLevel%