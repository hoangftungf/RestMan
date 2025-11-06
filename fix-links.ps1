# PowerShell script to fix all JSP links

$jspPath = "src\main\webapp\WEB-INF\jsp"

Write-Host "Fixing links in JSP files..." -ForegroundColor Green

# Get all JSP files
$jspFiles = Get-ChildItem -Path $jspPath -Recurse -Filter "*.jsp"

foreach ($file in $jspFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow

    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # Replace old links with new servlet URLs
    $content = $content -replace '/WEB-INF/jsp/customer/gdChinhKH\.jsp', '/customer'
    $content = $content -replace '/WEB-INF/jsp/staff/gdChinhNV\.jsp', '/staff'
    $content = $content -replace '/WEB-INF/jsp/staff/gdMenuBaoCao\.jsp', '/staff/reports'

    # Save the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
}

Write-Host "`nAll files processed!" -ForegroundColor Green
Write-Host "Total files updated: $($jspFiles.Count)" -ForegroundColor Cyan
