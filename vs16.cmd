@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vs16.ps1"""
exit /b %ErrorLevel%