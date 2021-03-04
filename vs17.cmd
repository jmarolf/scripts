@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vs17.ps1"""
exit /b %ErrorLevel%