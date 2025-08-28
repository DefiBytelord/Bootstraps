# PowerShell script to update CSS for all HTML files

# Get the path to the style.css file
$cssFilePath = "c:\Users\ADULOVE STUDIOS\Desktop\PROJECTS\School Projects\Workshop\Liberty\css\style.css"

# Check if the file exists
if (Test-Path $cssFilePath) {
    Write-Host "Updating navigation spacing in style.css..."
    
    # Read the CSS file content
    $cssContent = Get-Content -Path $cssFilePath -Raw
    
    # Update the margin-right for nav links
    $cssContent = $cssContent -replace '(margin-right:\s*)20px(\s*/\*\s*Consistent spacing\s*\*/)', '$15px$2 /* Reduced for closer spacing between nav items */'
    
    # Update the padding for nav links
    $cssContent = $cssContent -replace '(padding:\s*)25px\s*15px(\s*/\*\s*Added horizontal padding\s*\*/)', '$125px 10px$2 /* Reduced horizontal padding */'
    
    # Update the margin-right for navbar-brand
    $cssContent = $cssContent -replace '(margin-right:\s*)30px(\s*/\*\s*Add space between logo and nav items\s*\*/)', '$160px$2 /* Increased to create more space between logo and nav items */'
    
    # Save the modified content back to the file
    Set-Content -Path $cssFilePath -Value $cssContent
    
    Write-Host "Navigation spacing updated successfully."
} else {
    Write-Host "Error: style.css file not found at $cssFilePath"
}