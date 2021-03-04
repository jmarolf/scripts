@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vsmain.ps1"""
exit /b %ErrorLevel%