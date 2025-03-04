#Pull Information about Devices with Specified Software
Connect-MgGraph -Scopes "DeviceManagementApps.Read.All","DeviceManagementManagedDevices.Read.All"

# Test with a single detected app to see its properties
$testApp = Get-MgDeviceManagementDetectedApp -All | Where-Object { $_.DisplayName -like "*Sophos*" } | Select-Object -First 1
Get-MgDeviceManagementDetectedAppManagedDevice -DetectedAppId $testApp.id | Select-Object *

# Disconnect from Microsoft Graph
Disconnect-MgGraph
