# Define the required modules
$RequiredModules = @("Az", "Az.Storage")

# Initialize a flag to track missing modules
$MissingModules = $false

# Check each required module
foreach ($Module in $RequiredModules) {
    if (-not (Get-Module -ListAvailable -Name $Module)) {
        Write-Host "Module '$Module' is not installed or not available."
        $MissingModules = $true
    } else {
        Write-Host "Module '$Module' is installed and available."
    }
}

# Exit with appropriate code
if ($MissingModules) {
    Write-Host "One or more required modules are missing."
    Exit 1
} else {
    Write-Host "All required modules are installed and available."
    Exit 0
}
