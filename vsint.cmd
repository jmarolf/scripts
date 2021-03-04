@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vsint.ps1"""
exit /b %ErrorLevel%