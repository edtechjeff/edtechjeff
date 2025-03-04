# Define registry paths for 64-bit and 32-bit applications
$uninstallPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

# Create an array to store application details
$applications = @()

foreach ($path in $uninstallPaths) {
    # Get all subkeys under the uninstall path
    $subKeys = Get-ChildItem -Path $path -ErrorAction SilentlyContinue
    foreach ($subKey in $subKeys) {
        # Retrieve application details
        $app = Get-ItemProperty -Path $subKey.PSPath -ErrorAction SilentlyContinue
        if ($app.DisplayName) {
            $applications += [PSCustomObject]@{
                Name            = $app.DisplayName
                UninstallString = $app.UninstallString
                # Version         = $app.DisplayVersion
                # Publisher       = $app.Publisher
            }
        }
    }
}

# Output the results to the console with wrapping
$applications | Format-Table -Wrap -AutoSize

# Optionally export to a CSV file
$applications | Export-Csv -Path "$env:USERPROFILE\Desktop\InstalledApps.csv" -NoTypeInformation
