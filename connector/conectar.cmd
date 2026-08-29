@echo off
setlocal EnableExtensions
title Conector do Lab (Tailscale portatil)
REM ============================================================
REM  Conector portatil do lab - roda o Tailscale em modo userspace
REM  (sem instalar / sem driver) e abre o Open WebUI da base.
REM  EXPERIMENTAL no Windows: se falhar, use a opcao A (instalar
REM  o Tailscale normalmente) descrita no LEIA-ME.txt.
REM ============================================================
set "DIR=%~dp0"
set "BIN=%DIR%bin"
set "STATE=%DIR%state"
set "TS=%BIN%\tailscale.exe"
set "TSD=%BIN%\tailscaled.exe"
set "SOCK=\\.\pipe\tailscaled-lab"
set "PROXY=127.0.0.1:1055"
set "URL=https://desktop-ucgr4k4.tailcd6345.ts.net/"

if not exist "%TS%" goto :missing
if not exist "%TSD%" goto :missing
if not exist "%STATE%" mkdir "%STATE%"

echo.
echo [1/3] Iniciando Tailscale (userspace, sem instalar)...
start "" /b "%TSD%" --tun=userspace-networking --socks5-server=%PROXY% --state="%STATE%\tailscaled.state" --socket=%SOCK%
timeout /t 3 >nul

echo [2/3] Conectando a sua tailnet (vai abrir o navegador p/ login)...
"%TS%" --socket=%SOCK% up --hostname=lab-conector
if errorlevel 1 goto :fail

echo [3/3] Abrindo o Open WebUI...
set "EDGE=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if exist "%EDGE%" (
  start "" "%EDGE%" --proxy-server="socks5://%PROXY%" --new-window "%URL%"
) else if exist "%CHROME%" (
  start "" "%CHROME%" --proxy-server="socks5://%PROXY%" --new-window "%URL%"
) else (
  echo [aviso] Edge/Chrome nao encontrados. Configure o proxy SOCKS5 %PROXY% no seu navegador e acesse %URL%
)
echo.
echo ============================================================
echo  CONECTADO. Deixe esta janela ABERTA enquanto usa o lab.
echo  Ao terminar: rode desconectar.cmd (ou feche esta janela).
echo ============================================================
pause
goto :eof

:missing
echo.
echo [ERRO] Faltam os binarios do Tailscale.
echo Baixe "tailscale.exe" e "tailscaled.exe" (Windows amd64, versao estatica)
echo em https://pkgs.tailscale.com/stable/  e coloque na pasta:  %BIN%
echo.
pause
goto :eof

:fail
echo.
echo [ERRO] Nao consegui conectar. Tente a opcao A (instalar o Tailscale) do LEIA-ME.txt.
echo.
pause
goto :eof
