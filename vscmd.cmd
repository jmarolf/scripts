@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vscmd.ps1"""
exit /b %ErrorLevel%