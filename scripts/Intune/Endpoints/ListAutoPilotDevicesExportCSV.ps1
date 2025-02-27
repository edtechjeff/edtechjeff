# Notes
    # Entra, ID = ObjectID

    # Autopilot, ID = AzureActiveDirectoryDeviceId

    # DeviceID is the common ID between Entra and Autopilot
############################################################################################################################
# Getting list of device in AutoPilot and export to CSV
# Import the required module
Import-Module Microsoft.Graph

# Define all required variables at the beginning
$scopes = "Device.Read.All", "Group.ReadWrite.All"  # Adjust scopes as needed

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Get a list of devices in AutoPilot and export to CSV
# Ensure the Temp directory exists
$csvPath = "C:\Temp\AutoPilotDevice.csv"
if (!(Test-Path "C:\Temp")) { New-Item -ItemType Directory -Path "C:\Temp" -Force }

# Retrieve Autopilot devices and export to CSV
Get-MgDeviceManagementWindowsAutopilotDeviceIdentity |
    Select-Object SerialNumber, Id, AzureActiveDirectoryDeviceId |
    Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "Export completed: $csvPath"

# Disconnect from Microsoft Graph
Disconnect-MgGraph
