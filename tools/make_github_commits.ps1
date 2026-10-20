$repo = 'D:\code\CodexProgram\ShixunCode\gh-clone-temp'
$git = 'git'
$count = 0

function Invoke-Git {
    & $git -c safe.directory='*' -C $repo @args
}

function Commit-Path([string]$relativePath, [string]$message) {
    Invoke-Git add -- $relativePath 2>$null | Out-Null
    Invoke-Git diff --cached --quiet
    if ($LASTEXITCODE -ne 0) {
        Invoke-Git commit -m $message 2>$null | Out-Null
        if ($LASTEXITCODE -eq 0) {
            $script:count++
            Write-Host ("{0:D3} {1}" -f $script:count, $message)
        }
    }
}

function Relative-Path([string]$fullName) {
    return $fullName.Substring($repo.Length + 1).Replace('\', '/')
}

# Preserve the previous repository content without losing it.
Invoke-Git add -u 2>$null | Out-Null
Invoke-Git add -A -- legacy 2>$null | Out-Null
Invoke-Git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    Invoke-Git commit -m 'chore: preserve previous project under legacy' 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $script:count++
        Write-Host ("{0:D3} chore: preserve previous project under legacy" -f $script:count)
    }
}

Commit-Path '.gitignore' 'chore: add repository ignore rules'

$javaFiles = Get-ChildItem (Join-Path $repo 'backend\src\main\java') -Recurse -File -Filter '*.java' | Sort-Object FullName
foreach ($file in $javaFiles) {
    Commit-Path (Relative-Path $file.FullName) ("feat(backend): add " + $file.BaseName)
}

$jspFiles = Get-ChildItem (Join-Path $repo 'backend\src\main\webapp') -Recurse -File | Where-Object {
    $_.Extension -in '.jsp', '.jspf', '.tld'
} | Sort-Object FullName
foreach ($file in $jspFiles) {
    Commit-Path (Relative-Path $file.FullName) ("feat(web-jsp): add " + $file.Name)
}

$mobileFiles = Get-ChildItem (Join-Path $repo 'mobile') -Recurse -File | Where-Object {
    $_.FullName -notmatch '\\node_modules\\' -and $_.Name -notmatch '^\.'
} | Sort-Object FullName
foreach ($file in $mobileFiles) {
    Commit-Path (Relative-Path $file.FullName) ("feat(mobile): add " + $file.Name)
}

$webFiles = Get-ChildItem (Join-Path $repo 'web') -Recurse -File | Where-Object {
    $_.FullName -notmatch '\\(node_modules|dist)\\' -and $_.Name -notmatch '^\.'
} | Sort-Object FullName
foreach ($file in $webFiles) {
    Commit-Path (Relative-Path $file.FullName) ("feat(web): add " + $file.Name)
}

foreach ($file in (Get-ChildItem (Join-Path $repo 'sql') -File | Sort-Object Name)) {
    Commit-Path (Relative-Path $file.FullName) ("feat(sql): add " + $file.Name)
}
foreach ($file in (Get-ChildItem (Join-Path $repo 'docs') -File | Sort-Object Name)) {
    Commit-Path (Relative-Path $file.FullName) ("docs: add " + $file.Name)
}
foreach ($file in (Get-ChildItem (Join-Path $repo 'demo-files') -File | Sort-Object Name)) {
    Commit-Path (Relative-Path $file.FullName) ("test-data: add " + $file.Name)
}
foreach ($file in (Get-ChildItem (Join-Path $repo 'tools') -File | Sort-Object Name)) {
    Commit-Path (Relative-Path $file.FullName) ("tools: add " + $file.Name)
}

Commit-Path 'backend/src/main/resources/application.yml' 'config: add backend application settings'
Commit-Path 'backend/src/main/resources/demo-data' 'data: add 2021 monthly Excel fixtures'
Commit-Path 'backend/src/main/resources/static/ace' 'assets: add legacy Ace admin assets'
Commit-Path 'backend/src/main/resources/static/js' 'assets: add legacy admin scripts'
Commit-Path 'backend/src/main/resources/static/web' 'build: add compiled modern web console'
Commit-Path 'tools/adb' 'tools: add Android USB bridge'

Write-Host ''
Write-Host "TOTAL_NEW_COMMITS=$count"
