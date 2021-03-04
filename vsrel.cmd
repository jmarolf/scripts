@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0vsrel.ps1"""
exit /b %ErrorLevel%