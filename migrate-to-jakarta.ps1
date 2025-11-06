# PowerShell script to migrate from javax.* to jakarta.*

Write-Host "Migrating Java files from javax.* to jakarta.*" -ForegroundColor Green

$javaPath = "src\main\java"

# Get all Java files
$javaFiles = Get-ChildItem -Path $javaPath -Recurse -Filter "*.java"

$count = 0

foreach ($file in $javaFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content

    # Replace javax.servlet with jakarta.servlet
    $content = $content -replace 'import javax\.servlet\.', 'import jakarta.servlet.'
    $content = $content -replace 'javax\.servlet\.', 'jakarta.servlet.'

    # Only save if content changed
    if ($content -ne $original) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  Updated: $($file.Name)" -ForegroundColor Yellow
        $count++
    }
}

Write-Host "`nMigration complete!" -ForegroundColor Green
Write-Host "Total files updated: $count" -ForegroundColor Cyan
