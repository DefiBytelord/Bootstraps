# PowerShell script to update navbar structure in all HTML files

# Get all HTML files in the project (excluding specific directories if needed)
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { $_.FullName -notlike "*\login_portal\*" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.Name)..."
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if the file has the old navbar structure with More and Login Portal outside navbar-nav
    if ($content -match '</a>\s*</div>\s*<div class="nav-item dropdown">\s*<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"\s*>More</a>') {
        Write-Host "Updating navbar structure in $($file.Name)..."
        
        # Replace the structure to move More and Login Portal inside navbar-nav
        $newContent = $content -replace '(</a>\s*</div>)\s*(<div class="nav-item dropdown">\s*<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"\s*>More</a>)', '$1\n          $2'
        
        # Fix the closing div tags
        $newContent = $newContent -replace '(</div>\s*</div>)\s*</div>\s*</div>\s*</nav>', '$1\n        </div>\n      </div>\n    </nav>'
        
        # Save the modified content back to the file
        Set-Content -Path $file.FullName -Value $newContent
        
        Write-Host "Updated $($file.Name)"
    }
}

Write-Host "All HTML files processed successfully."