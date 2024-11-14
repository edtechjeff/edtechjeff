# Install Modules
Install-Module Microsoft.Graph -Scope CurrentUser

# Connect to Azure Graph
Connect-MgGraph -Scopes "Device.Read.All"

# Body of Script
# Get the current date and time
$currentDateTime = Get-Date
# Get the date and time for 48 hours ago
$lastSyncThreshold = $currentDateTime.AddHours(-24).ToString("o") # ISO 8601 format

# Get the devices that have synced in the last 48 hours
$devices = Get-MgDeviceManagementManagedDevice -Filter "lastSyncDateTime ge $lastSyncThreshold"

# Count the devices
$deviceCount = $devices.Count

Write-Host "Number of devices that synced in the last 48 hours: $deviceCount"
