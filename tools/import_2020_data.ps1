param(
    [string]$Source = 'D:\code\CodexProgram\ShixunCode\软件项目高级实战与优化资料分享\2020年链接版KIS旗舰版格式\2020年链接版KIS旗舰版格式'
)

$cookie = Join-Path $env:TEMP 'finance_import_2020.cookie'
curl.exe -s -c $cookie -d 'accountName=root&password=123456' 'http://localhost:8006/admin/pc/login' -o NUL

$success = 0
$failed = @()
foreach ($file in (Get-ChildItem -LiteralPath $Source -File -Filter '*.xlsx' | Sort-Object Name)) {
    $name = $file.Name
    $url = $null
    $fields = @()
    if ($name -match '利润表|损益表') {
        $url = '/report/importTBasiProfitBulk'
        $fields = @('-F', 'proSubject=1')
    } elseif ($name -match '资产负债表') {
        $url = '/report/importTBasiAssetsAndLiabilitiesBulk'
        $fields = @('-F', 'proSubject=2')
    } elseif ($name -match '现金流量表') {
        $url = '/report/importTBasiCashFlowBulk'
        $fields = @('-F', 'proSubject=5')
    } elseif ($name -match '科目余额表') {
        $url = '/report/importTKmyeBulk'
        $fields = @('-F', 'proSubject=3')
    } elseif ($name -match '账龄分析') {
        $url = '/report/importTAgeAnalysisBulk'
        $type = if ($name -match '其他应收') { '4' }
            elseif ($name -match '其他应付') { '3' }
            elseif ($name -match '应付账款') { '5' }
            elseif ($name -match '应收账款') { '6' }
            elseif ($name -match '预付账款') { '7' }
            elseif ($name -match '预收账款') { '8' }
            elseif ($name -match '产成品') { '9' }
            else { '10' }
        $fields = @('-F', 'proSubject=22', '-F', "type=$type")
    }
    if (-not $url) {
        $failed += "$name (unrecognized)"
        continue
    }
    $response = & curl.exe -s -b $cookie -F "excelFile=@$($file.FullName)" @fields "http://localhost:8006$url"
    try {
        $json = $response | ConvertFrom-Json
        if ($json.flag -and $json.flag -ne '-1' -and $json.flag -notmatch '数据不正确') {
            $success++
        } else {
            $failed += "$name ($($json.flag))"
        }
    } catch {
        $failed += "$name ($response)"
    }
}

curl.exe -s -b $cookie -d 'org_id=1' 'http://localhost:8006/dataFormat/dataFormatAll' | Out-Null
Write-Host "Imported files: $success"
if ($failed.Count -gt 0) {
    Write-Host 'Failed:'
    $failed | ForEach-Object { Write-Host $_ }
}
