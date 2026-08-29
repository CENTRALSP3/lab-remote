@echo off
setlocal EnableExtensions
title Desconectar - Conector do Lab
set "DIR=%~dp0"
set "TS=%DIR%bin\tailscale.exe"
set "SOCK=\\.\pipe\tailscaled-lab"
echo Desconectando da tailnet...
if exist "%TS%" "%TS%" --socket=%SOCK% down 2>nul
echo Encerrando o Tailscale portatil...
taskkill /f /im tailscaled.exe >nul 2>&1
echo Pronto. Voce pode remover o USB com seguranca.
timeout /t 2 >nul
