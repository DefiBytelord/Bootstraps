# PowerShell script to fix duplicate jQuery libraries in HTML files

$htmlFiles = Get-ChildItem -Path . -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.FullName)..."
    
    # Read the content of the file
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if the file contains multiple jQuery references
    if ($content -match "jquery-3\.4\.1\.min\.js" -and $content -match "jquery-3\.6\.0\.min\.js") {
        Write-Host "Fixing duplicate jQuery in $($file.Name)..."
        
        # Replace jQuery 3.4.1 with jQuery 3.6.0
        $newContent = $content -replace '<script src="https://code\.jquery\.com/jquery-3\.4\.1\.min\.js"></script>', ''
        
        # Remove CDN Owl Carousel if local version exists
        if ($newContent -match "lib/owlcarousel/owl\.carousel\.min\.js" -and $newContent -match "cdnjs\.cloudflare\.com/ajax/libs/OwlCarousel2") {
            $newContent = $newContent -replace '<script src="https://cdnjs\.cloudflare\.com/ajax/libs/OwlCarousel2/[\d\.]+/owl\.carousel\.min\.js"></script>', ''
        }
        
        # Save the modified content back to the file
        Set-Content -Path $file.FullName -Value $newContent
        
        Write-Host "Fixed $($file.Name)"
    }
}

Write-Host "All HTML files processed successfully."