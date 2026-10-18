$ErrorActionPreference = 'Stop'
$base = 'http://localhost:8006'

$login = Invoke-RestMethod -Method Post -Uri "$base/api/auth/login" -ContentType 'application/json' `
    -Body '{"account":"root","password":"123456"}'
if ($login.code -ne 200) {
    throw 'Login API failed'
}
$headers = @{ 'X-Token' = $login.data.token }
$checks = @(
    '/api/health',
    '/api/auth/profile',
    '/api/home/report',
    '/api/finance/overview',
    '/api/report/profit',
    '/api/report/balance',
    '/api/report/cashflow',
    '/api/report/account-balance',
    '/api/analysis/home',
    '/api/analysis/balance',
    '/api/analysis/profit',
    '/api/analysis/cashflow',
    '/api/analysis/profit/chart',
    '/api/analysis/cashflow/chart',
    '/api/analysis/ratio',
    '/api/finance/detail?code=ZCFZ-G',
    '/api/finance/detail/chart?code=LR-A',
    '/api/finance/aging?type=7',
    '/api/finance/summary-warning',
    '/api/forecast/profit?months=6',
    '/api/news'
)

$failed = 0
foreach ($path in $checks) {
    try {
        $raw = Invoke-WebRequest -UseBasicParsing -Headers $headers -Uri ($base + $path)
        $response = $raw.Content | ConvertFrom-Json
        if ($response.code -ne 200) {
            throw "code=$($response.code) message=$($response.message)"
        }
        Write-Host "PASS $path"
    } catch {
        $failed++
        Write-Host "FAIL $path -> $($_.Exception.Message)"
    }
}

$body = @{
    initialInvestment = 5000000
    projectYears = 5
    annualRevenue = 8000000
    annualCost = 4500000
    loanAmount = 2000000
} | ConvertTo-Json
foreach ($path in @('/api/investment/preview', '/api/investment/forecast')) {
    try {
        $raw = Invoke-WebRequest -UseBasicParsing -Method Post -Headers $headers -ContentType 'application/json' `
            -Body $body -Uri ($base + $path)
        $response = $raw.Content | ConvertFrom-Json
        if ($response.code -ne 200) {
            throw "code=$($response.code)"
        }
        Write-Host "PASS $path"
    } catch {
        $failed++
        Write-Host "FAIL $path -> $($_.Exception.Message)"
    }
}

if ($failed -gt 0) {
    throw "$failed API checks failed"
}
Write-Host 'All API checks passed'
