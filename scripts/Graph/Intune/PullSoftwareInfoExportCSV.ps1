#Pull Information about Devices with Specified Software
Connect-MgGraph -Scopes "DeviceManagementApps.Read.All","DeviceManagementManagedDevices.Read.All"

$result = @()  # Initialize an array to store results

# Get all detected apps
Get-MgDeviceManagementDetectedApp -All | ForEach-Object {
    $tmp = $_

    # Check if the detected app's display name contains "Sentinel"
    if ($tmp.DisplayName -like "*Sentinel*") {
        # Get managed devices for the detected app
        Get-MgDeviceManagementDetectedAppManagedDevice -DetectedAppId $tmp.id | ForEach-Object {
            # Add each device to the results
            $result += [pscustomobject]@{
                Device   = $_.DeviceName
                App      = $tmp.DisplayName
                Version  = $tmp.Version
                Platform = $tmp.Platform
            }
        }
    }
}

# Export the results to a CSV file
$result | Export-Csv -Path "C:\temp2\SentinelSoftware.csv" -NoTypeInformation
# Disconnect from Microsoft Graph
Disconnect-MgGraph
