# IDM Activation Script - Fixed Version
# This fixes the line ending issue from the GitHub version

# Run as Administrator if not already
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath'`""
    exit
}

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

Write-Host "Downloading IDM Activation Script..." -ForegroundColor Yellow

$DownloadURL = "https://github.com/punisher-303/IDM-PATCHER/raw/refs/heads/main/IAS.cmd"
$rand = Get-Random -Maximum 99999999
$FilePath = "$env:TEMP\IAS_$rand.cmd"

try {
    # Download the CMD script
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
    Write-Host "Download successful!" -ForegroundColor Green
}
catch {
    Write-Host "Error downloading script: $_" -ForegroundColor Red
    Write-Host "Trying alternative download method..." -ForegroundColor Yellow
    
    # Alternative download method
    $webClient = New-Object System.Net.WebClient
    $webClient.Headers.Add("User-Agent", "Mozilla/5.0")
    $response = $webClient.DownloadString($DownloadURL)
}

# Prepare the script content with proper Windows line endings
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
$content = $content -replace "`r`n?|`n", "`r`n"  # Force Windows line endings

# Save the file with proper encoding
Set-Content -Path $FilePath -Value $content -Encoding UTF8 -Force

Write-Host "Executing activation script..." -ForegroundColor Yellow
Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$FilePath`"" -Wait -NoNewWindow

# Cleanup
if (Test-Path $FilePath) {
    Remove-Item $FilePath -Force
}

Write-Host "Cleaning up temporary files..." -ForegroundColor Yellow
Get-Item "$env:TEMP\IAS*.cmd" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
Get-Item "$env:SystemRoot\Temp\IAS*.cmd" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

Write-Host "Process completed!" -ForegroundColor Green
Write-Host "Please restart IDM to check if activation was successful." -ForegroundColor Cyan
pause