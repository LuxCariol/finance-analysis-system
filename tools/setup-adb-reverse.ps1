param(
    [string]$ApiHost = '127.0.0.1:8006'
)

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$adbCandidates = @(
    'D:\Takagi_apps\HBuilderX\plugins\launcher-tools\tools\adbs\adb.exe',
    (Join-Path $root 'tools\adb\adb\adb.exe')
)
$adb = $adbCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1

if (-not $adb) {
    throw 'adb.exe not found. Install Android platform-tools or HBuilderX first.'
}

$devices = & $adb devices
$devices | ForEach-Object { Write-Host $_ }
$online = @($devices | Where-Object { $_ -match '\s+device$' })
if ($online.Count -eq 0) {
    Write-Host ''
    Write-Host 'No Android device detected.'
    Write-Host '1. Connect the phone with a data-capable USB cable.'
    Write-Host '2. Enable Developer options and USB debugging.'
    Write-Host '3. Allow the USB debugging authorization prompt on the phone.'
    Write-Host '4. Run this script again.'
    exit 1
}

& $adb reverse tcp:8006 tcp:8006
if ($LASTEXITCODE -ne 0) {
    throw 'adb reverse failed'
}

Write-Host ''
Write-Host 'ADB reverse is active:'
& $adb reverse --list

$setter = Join-Path $root 'tools\set-mobile-api.ps1'
& powershell -ExecutionPolicy Bypass -File $setter -ApiHost $ApiHost

Write-Host ''
Write-Host 'Now run the uni-app project to the Android App base.'
Write-Host "Phone API URL: http://$ApiHost"
