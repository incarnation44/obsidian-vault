@echo off
chcp 65001 > nul
title Dell Latitude 7440 Antigravity Remote Setup
echo =================================================================
echo  Dell Latitude 7440 Antigravity 2.0 원격 허브 1분 세팅 시작
echo =================================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup_dell7440_laptop.ps1"

echo.
pause
