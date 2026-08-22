@echo off
chcp 65001 > nul
title Dell Latitude 7440 Antigravity Remote Setup
echo =================================================================
echo  Dell Latitude 7440 Antigravity 2.0 Remote Hub Setup
echo =================================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup_dell7440_laptop.ps1"

echo.
pause
