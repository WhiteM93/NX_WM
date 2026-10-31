@echo off
rem install.bat - wrapper for install.ps1 (requests admin rights, ExecutionPolicy Bypass)
rem   install.bat            install
rem   install.bat -DryRun    show plan only, no changes
rem   install.bat -Uninstall rollback from latest backup
chcp 65001 >nul
set "ARGS=%*"
echo %ARGS% | findstr /i /c:"-DryRun" /c:"-WhatIf" >nul && goto run
net session >nul 2>&1
if %errorlevel% neq 0 (
  echo Requesting administrator rights...
  if defined ARGS (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList '%ARGS%' -Verb RunAs"
  ) else (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  )
  exit /b
)
:run
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" %ARGS%
echo.
pause
