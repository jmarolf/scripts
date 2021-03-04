@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vspreview.ps1"""
exit /b %ErrorLevel%