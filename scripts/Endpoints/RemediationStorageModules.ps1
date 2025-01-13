# Define the required module and version
$ModuleName = "Az"
$RequiredVersion = "10.0.0" # Specify the version or use the latest version by omitting this line

# Check if the module is already installed
$module = Get-Module -ListAvailable -Name $ModuleName

if ($module -eq $null -or $module.Version -lt [Version]$RequiredVersion) {
    Write-Output "Module '$ModuleName' is not installed or is outdated. Installing/Updating..."
    
    # Install or update the module
    try {
        Install-Module -Name $ModuleName -AllowClobber -Force -Scope CurrentUser
        Write-Output "Module '$ModuleName' installed successfully."
    } catch {
        Write-Output "Error installing module '$ModuleName': $_"
        Exit 1
    }
} else {
    Write-Output "Module '$ModuleName' is already installed and up-to-date."
}

# Import the module
try {
    Import-Module $ModuleName -ErrorAction Stop
    Write-Output "Module '$ModuleName' imported successfully."
} catch {
    Write-Output "Error importing module '$ModuleName': $_"
    Exit 1
}

# Verify cmdlets are available
$cmdlets = @("New-AzStorageContext", "Set-AzStorageBlobContent")
foreach ($cmdlet in $cmdlets) {
    if (Get-Command $cmdlet -ErrorAction SilentlyContinue) {
        Write-Output "Cmdlet '$cmdlet' is available."
    } else {
        Write-Output "Cmdlet '$cmdlet' is missing. Please check the module installation."
        Exit 1
    }
}

Write-Output "All prerequisites for Azure Storage operations are installed and verified."