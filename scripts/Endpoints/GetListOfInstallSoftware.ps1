# Define registry paths for 32-bit and 64-bit software
$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

# Retrieve installed software from the registry
$installedSoftware = foreach ($path in $registryPaths) {
    Get-ItemProperty -Path $path\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
}

# Display the results
$installedSoftware | Where-Object { $_.DisplayName -ne $null } | Sort-Object DisplayName


# Test