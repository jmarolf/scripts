@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vs.ps1"""
exit /b %ErrorLevel%