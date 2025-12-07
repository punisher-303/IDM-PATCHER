# Fixed version with proper line endings
$fixedScript = @'
# Check the instructions here on how to use it https://github.com/punisher-303/IDM-ACTIVATION-SCRIPT/wiki

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = "https://github.com/punisher-303/IDM-PATCHER/raw/refs/heads/main/IAS.cmd"

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\IAS_$rand.cmd" } else { "$env:TEMP\IAS_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    Write-Error "Failed to download from $DownloadURL"
    exit 1
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content -Encoding UTF8

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\IAS*.cmd", "$env:SystemRoot\Temp\IAS*.cmd")
foreach ($path in $FilePaths) { 
    if (Test-Path $path) {
        Get-Item $path -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
    }
}
'@

# Execute the fixed script
Invoke-Expression $fixedScript