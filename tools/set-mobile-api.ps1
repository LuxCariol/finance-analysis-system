param(
    [string]$ApiHost
)

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$configPath = Join-Path $root 'mobile\common\config.js'

if (-not $ApiHost) {
    Write-Host 'Available IPv4 addresses:'
    $addresses = @()
    try {
        $addresses = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop |
            Where-Object {
                $_.IPAddress -ne '127.0.0.1' -and
                $_.PrefixOrigin -ne 'WellKnown' -and
                $_.IPAddress -notlike '169.254.*'
            }
    } catch {
        $ipconfig = ipconfig 2>$null
        foreach ($line in $ipconfig) {
            if ($line -match 'IPv4.*?:\s*([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)') {
                $addresses += [PSCustomObject]@{
                    InterfaceAlias = 'IPv4'
                    IPAddress = $matches[1]
                }
            }
        }
    }
    $addresses | Select-Object InterfaceAlias, IPAddress | Format-Table -AutoSize
    Write-Host ''
    Write-Host 'Usage:'
    Write-Host '  .\set-mobile-api.ps1 -ApiHost 192.168.1.20'
    exit 0
}

if ($ApiHost -notmatch '^https?://') {
    $ApiHost = 'http://' + $ApiHost
}
$ApiHost = $ApiHost.TrimEnd('/')
if ($ApiHost -match '/api$') {
    throw 'API_BASE must not include /api. The request helper adds /api automatically.'
}
if (-not (Test-Path -LiteralPath $configPath)) {
    throw "config.js not found: $configPath"
}

$text = [IO.File]::ReadAllText($configPath, [Text.Encoding]::UTF8)
$updated = [regex]::Replace($text, "export const API_BASE = '[^']*'", "export const API_BASE = '$ApiHost'")
if ($updated -eq $text -and $text -notmatch [regex]::Escape($ApiHost)) {
    throw 'API_BASE line was not found in config.js'
}
[IO.File]::WriteAllText($configPath, $updated, (New-Object Text.UTF8Encoding($false)))
Write-Host "API_BASE updated to: $ApiHost"
Write-Host "Config file: $configPath"
