# PowerShell script to fix path issues in all HTML files

# Get all HTML files in the current directory
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse

# Counter for modified files
$modifiedCount = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content
    
    # Fix CSS and library paths with dots
    $content = $content -replace '\.lib/', 'lib/'
    $content = $content -replace '\.css/', 'css/'
    $content = $content -replace '\.js/', 'js/'
    $content = $content -replace '\.img/', 'img/'
    
    # Fix incorrect index.html references
    $content = $content -replace '\.\.index\.html', 'index.html'
    
    # Only write back if changes were made
    if ($content -ne $originalContent) {
        $content | Set-Content -Path $file.FullName -NoNewline
        $modifiedCount++
        Write-Host "Fixed paths in: $($file.Name)"
    }
}

Write-Host "\nCompleted! Modified $modifiedCount HTML files."