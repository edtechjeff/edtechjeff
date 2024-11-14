# Connect to MSGraph
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

# Get all devices in Intune
$devices = Get-MgDeviceManagementManagedDevice -All

# Filter devices with enabled accounts
$enabledDevices = $devices | Where-Object { $_.userPrincipalName -ne $null }

# Output the count of enabled devices
$enabledDeviceCount = $enabledDevices.Count
Write-Host "Number of devices with enabled accounts: $enabledDeviceCount"

# Disconnect the session
Disconnect-MgGraph
