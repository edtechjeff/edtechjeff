# Define output file
$outputFile = "C:\Temp\Shared_Folders_Permissions.csv"

# Retrieve all shared folders
$shares = Get-WmiObject -Class Win32_Share | Where-Object { $_.Name -ne "IPC$" -and $_.Name -ne "ADMIN$" -and $_.Name -ne "C$" }

# Initialize an array to store results
$results = @()

foreach ($share in $shares) {
    # Get share permissions
    $permissions = Get-Acl -Path "\\$env:COMPUTERNAME\$($share.Name)" -ErrorAction SilentlyContinue
    if ($permissions) {
        foreach ($access in $permissions.Access) {
            $results += [PSCustomObject]@{
                ShareName = $share.Name
                Path = $share.Path
                Account = $access.IdentityReference
                AccessRights = $access.FileSystemRights
                AccessType = $access.AccessControlType
            }
        }
    } else {
        # If unable to get permissions, log the share
        $results += [PSCustomObject]@{
            ShareName = $share.Name
            Path = $share.Path
            Account = "Unable to retrieve"
            AccessRights = "N/A"
            AccessType = "N/A"
        }
    }
}

# Export to CSV
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Shared folders and permissions exported to $outputFile"
