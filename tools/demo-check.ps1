$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$failed = 0
$warnings = 0

function Pass($message) {
    Write-Host "[PASS] $message" -ForegroundColor Green
}

function Fail($message) {
    $script:failed++
    Write-Host "[FAIL] $message" -ForegroundColor Red
}

function Warn($message) {
    $script:warnings++
    Write-Host "[WARN] $message" -ForegroundColor Yellow
}

Write-Host '=== Financial Analysis Demo Check ===' -ForegroundColor Cyan

try {
    $mysql = Get-Service -Name 'MySQL80' -ErrorAction Stop
    if ($mysql.Status -eq 'Running') {
        Pass 'MySQL80 is running'
    } else {
        Fail "MySQL80 status: $($mysql.Status)"
    }
} catch {
    Warn 'MySQL80 service was not found by name; verify the database manually'
}

try {
    $health = Invoke-RestMethod -Uri 'http://localhost:8006/api/health' -TimeoutSec 5
    if ($health.code -eq 200) {
        Pass 'Backend health endpoint is available'
    } else {
        Fail "Backend health code: $($health.code)"
    }
} catch {
    Fail 'Backend is not running on port 8006'
}

try {
    $loginPage = Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:8006/admin/pc/login' -TimeoutSec 5
    if ($loginPage.StatusCode -eq 200) {
        Pass 'Web admin login page is available'
    } else {
        Fail "Web login status: $($loginPage.StatusCode)"
    }
} catch {
    Fail 'Web admin login page is unavailable'
}

try {
    $modernWeb = Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:8006/web/' -TimeoutSec 5
    if ($modernWeb.StatusCode -eq 200 -and $modernWeb.Content -match '<div id="app">') {
        Pass 'Modern web console is available at /web/'
    } else {
        Fail 'Modern web console returned an unexpected page'
    }
} catch {
    Fail 'Modern web console is unavailable'
}

try {
    $loginBody = '{"account":"root","password":"123456"}'
    $login = Invoke-RestMethod -Method Post -Uri 'http://localhost:8006/api/auth/login' `
        -ContentType 'application/json' -Body $loginBody -TimeoutSec 5
    if ($login.code -eq 200) {
        Pass 'Demo account root / 123456 can log in'
    } else {
        Fail "Login API code: $($login.code)"
    }
} catch {
    Fail 'Login API failed'
}

$configPath = Join-Path $root 'mobile\common\config.js'
if (Test-Path -LiteralPath $configPath) {
    $config = Get-Content -LiteralPath $configPath -Raw
    if ($config -match "API_BASE = '([^']+)'") {
        $apiBase = $matches[1]
        Pass "Mobile API_BASE: $apiBase"
        if ($apiBase -match '127\.0\.0\.1' -or $apiBase -match 'localhost') {
            $adb = Join-Path $root 'tools\adb\adb\adb.exe'
            if (Test-Path -LiteralPath $adb) {
                $devices = & $adb devices 2>$null
                if ($devices -match '\sdevice$') {
                    Pass 'Android USB device is authorized'
                    $reverse = & $adb reverse --list 2>$null
                    if ($reverse -match '8006') {
                        Pass 'ADB reverse for port 8006 is active'
                    } else {
                        Fail 'ADB reverse for port 8006 is missing; run setup-adb-reverse.ps1'
                    }
                } else {
                    Fail 'No authorized Android USB device; connect USB or use a LAN IP'
                }
            } else {
                Warn 'adb.exe was not found'
            }
        } else {
            try {
                $hostUri = $apiBase + '/api/health'
                $remote = Invoke-RestMethod -Uri $hostUri -TimeoutSec 5
                if ($remote.code -eq 200) {
                    Pass "LAN health endpoint: $hostUri"
                }
            } catch {
                Warn "LAN address is not reachable from this PC: $apiBase"
            }
        }
    } else {
        Fail 'API_BASE line was not found in config.js'
    }
} else {
    Fail 'mobile/common/config.js was not found'
}

Write-Host ''
Write-Host "Demo sample files: $root\demo-files"
Write-Host "Result: $failed failed, $warnings warnings"
if ($failed -gt 0) {
    exit 1
}
Write-Host 'Ready for demo.' -ForegroundColor Green
