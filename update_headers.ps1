# PowerShell script to update headers in all HTML files in the indices folder

$indicesFolder = "c:\Users\ADULOVE STUDIOS\Desktop\PROJECTS\School Projects\Workshop\Liberty\indices"

# Get the standardized header from sec-beyond.html
$secBeyondContent = Get-Content -Path "$indicesFolder\sec-beyond.html" -Raw

# Extract the header section from sec-beyond.html
$headerPattern = '(?s)<!-- Navbar Start -->.*?<!-- Navbar End -->'
$standardHeader = [regex]::Match($secBeyondContent, $headerPattern).Value

# Get all HTML files in the indices folder (excluding login_portal directory)
$htmlFiles = Get-ChildItem -Path $indicesFolder -Filter "*.html" | Where-Object { $_.FullName -ne "$indicesFolder\sec-beyond.html" -and $_.FullName -ne "$indicesFolder\contact.html" }

# PowerShell script to update headers in all HTML files

# Get all HTML files in the project (excluding specific directories if needed)
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { $_.FullName -notlike "*\login_portal\*" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.Name)..."
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if the file has the old navbar structure without container
    if ($content -match '<nav class="navbar navbar-expand-lg bg-dark navbar-light shadow sticky-top">\s*<a href="[^"]*" class="navbar-brand') {
        Write-Host "Updating navbar in $($file.Name)..."
        
        # Replace the old navbar structure with the new one that includes container
        $newContent = $content -replace '(<nav class="navbar navbar-expand-lg bg-dark navbar-light shadow sticky-top">)\s*<a href="([^"]*)" class="navbar-brand[^>]*>\s*<img src="([^"]*)" alt="([^"]*)"[^>]*>\s*</a>', '$1\n      <div class="container">\n        <a href="$2" class="navbar-brand d-flex align-items-center">\n          <img src="$3" alt="$4" width="80px" />\n        </a>'
        
        # Replace the old navbar-nav class with padding
        $newContent = $newContent -replace '<div class="navbar-nav ms-auto p-4 p-lg-0">', '<div class="navbar-nav ms-auto">'
        
        # Add closing div for container if not present
        if ($newContent -notmatch '</div>\s*</nav>') {
            $newContent = $newContent -replace '</div>\s*</nav>', '</div>\n      </div>\n    </nav>'
        }
        
        # Save the modified content back to the file
        Set-Content -Path $file.FullName -Value $newContent
        
        Write-Host "Updated $($file.Name)"
    }
}

Write-Host "All HTML files processed successfully."

# Check if the file has a header section
if ($content -match $headerPattern) {
    # Determine which nav item should be active based on the filename
    $fileName = $file.Name
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    
    # Create a modified header with the appropriate active class
    $modifiedHeader = $standardHeader
    
    # Handle special cases for navigation items
    switch -Wildcard ($baseName) {
        "index" { 
            $modifiedHeader = $modifiedHeader -replace 'href="../indices/index.html" class="nav-item nav-link"', 'href="../indices/index.html" class="nav-item nav-link active"' 
        }
        "unique" { 
            # About section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">About</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">About</a>' 
        }
        "history" { 
            # About section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">About</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">About</a>' 
        }
        "publication" { 
            # About section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">About</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">About</a>' 
        }
        "policy" { 
            # About section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">About</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">About</a>' 
        }
        "directors" { 
            # About section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">About</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">About</a>' 
        }
        "choose" { 
            # Admission section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Admission</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Admission</a>' 
        }
        "faqs" { 
            # Admission section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Admission</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Admission</a>' 
        }
        "moving" { 
            # Admission section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Admission</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Admission</a>' 
        }
        "Nursery" { 
            $modifiedHeader = $modifiedHeader -replace '<a href="Nursery.html" class="nav-item nav-link">', '<a href="Nursery.html" class="nav-item nav-link active">' 
        }
        "pri-*" { 
            # Primary section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Primary</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Primary</a>' 
        }
        "sec-*" { 
            # Secondary section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Secondary</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Secondary</a>' 
        }
        "pta" { 
            # More section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">More</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">More</a>' 
        }
        "alumni" { 
            # More section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">More</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">More</a>' 
        }
        "gallery" { 
            # More section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">More</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">More</a>' 
        }
        "news" { 
            # More section
            $modifiedHeader = $modifiedHeader -replace '<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">More</a>', '<a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">More</a>' 
        }
        default { 
            # No active class for other files
        }
    }
    
    # Replace the old header with the modified header
    $updatedContent = $content -replace $headerPattern, $modifiedHeader
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $updatedContent
    
    Write-Host "Updated header in $($file.Name)"
}

Write-Host "Header update completed for all HTML files in the indices folder."