# Notes
    # Entra, ID = ObjectID

    # Autopilot, ID = AzureActiveDirectoryDeviceId

    # DeviceID is the common ID between Entra and Autopilot
############################################################################################################################
# Get a list of device in Entra ID and export to CSV

# Import the required module
Import-Module Microsoft.Graph

# Define all required variables at the beginning
$scopes = "Device.Read.All", "Group.ReadWrite.All"  # Adjust scopes as needed

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Define the output file path
$csvPath = "C:\Temp\EntraDevices.csv"

# Ensure the Temp directory exists
if (!(Test-Path "C:\Temp")) { New-Item -ItemType Directory -Path "C:\Temp" -Force }

# Connect to Microsoft Graph if not already connected
if (!(Get-MgContext)) {
    Connect-MgGraph -Scopes "Directory.Read.All"
}

# Retrieve all devices from Entra ID and export to CSV
Get-MgDevice -All -Property DisplayName, Id, DeviceId |
    Select-Object DisplayName, Id, DeviceId |
    Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "Export completed: $csvPath"

# Disconnect from Microsoft Graph
Disconnect-MgGraph
