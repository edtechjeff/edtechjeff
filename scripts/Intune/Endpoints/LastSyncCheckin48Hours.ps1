# Force Install and Import of Graph Modules if not present
Install-Module -Name Microsoft.Graph -Force -AllowClobber
Import-Module Microsoft.Graph

# Connect to MS Graph
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

# Set time range for 48 hours ago
$48HoursAgo = (Get-Date).AddHours(-48).ToString("yyyy-MM-ddTHH:mm:ssZ")

# Retrieve devices that have checked in during the last 48 hours and filter for Windows devices
$devices = Get-MgDeviceManagementManagedDevice -Filter "LastSyncDateTime ge $48HoursAgo"

# Filter only Windows devices
$windowsDevices = $devices | Where-Object { $_.operatingSystem -eq "Windows" }

# Export relevant information to CSV
$windowsDevices | Select-Object deviceName, LastSyncDateTime, operatingSystem | Export-Csv -Path "C:\temp2\WindowsDevices48HourCheckIn.csv" -NoTypeInformation

# Notify when done
Write-Host "CSV export complete. File saved to C:\temp2\WindowsDevices48HourCheckIn.csv"
