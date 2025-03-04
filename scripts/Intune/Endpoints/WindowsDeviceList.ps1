# Ensure Microsoft Graph module is installed
Install-Module Microsoft.Graph -Force -Scope CurrentUser

# Connect to MS Graph
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

# Retrieve all devices from Intune
$allDevices = Get-MgDeviceManagementManagedDevice -All

# Filter for Windows devices (based on operatingSystem field)
$windowsDevices = $allDevices | Where-Object { $_.operatingSystem -eq "Windows" }

# Export relevant information to CSV
$windowsDevices | Select-Object deviceName, operatingSystem, complianceState, lastContactedDateTime | Export-Csv -Path "C:\temp2\WindowsDevices.csv" -NoTypeInformation

# Notify when done
Write-Host "CSV export complete. File saved to C:\temp2\WindowsDevices.csv"

