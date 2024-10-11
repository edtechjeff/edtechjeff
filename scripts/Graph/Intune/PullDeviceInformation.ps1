# Test with a single detected app to see its properties
$testApp = Get-MgDeviceManagementDetectedApp -All | Where-Object { $_.DisplayName -like "*Sophos*" } | Select-Object -First 1
Get-MgDeviceManagementDetectedAppManagedDevice -DetectedAppId $testApp.id | Select-Object *

# Disconnect from Microsoft Graph
Disconnect-MgGraph

##########################################################################################################################################
# Pull Information out of EntraID about devices

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Device.Read.All"

# Initialize an array to store results
$deviceList = @()

# Retrieve all devices from Entra ID
$devices = Get-MgDevice -All

# Loop through each device and gather relevant information
foreach ($device in $devices) {
    $deviceList += [pscustomobject]@{
        ObjectId               = $device.Id                 # Added ObjectId
        DeviceId               = $device.DeviceId           # DeviceId if you have it available
        DisplayName            = $device.DisplayName
        OperatingSystem        = $device.OperatingSystem
        OperatingSystemVersion = $device.OperatingSystemVersion
        Manufacturer           = $device.Manufacturer
        Model                  = $device.Model
        IsEnabled              = $device.AccountEnabled      # Enabled status
    }
}

# Export the device information to a CSV file
$deviceList | Export-Csv -Path "C:\temp2\EntraID_Devices.csv" -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph
