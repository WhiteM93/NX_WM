@echo off
chcp 65001 >nul
rem Запуск install.ps1 с правами администратора. Параметры передаются дальше, например:
rem   install.bat -DryRun
rem   install.bat -Uninstall
powershell -NoProfile -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -NoExit -File \"%~dp0install.ps1\" %*'"
