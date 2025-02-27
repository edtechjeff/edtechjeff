# Notes
    # Entra, ID = ObjectID

    # Autopilot, ID = AzureActiveDirectoryDeviceId

    # DeviceID is the common ID between Entra and Autopilot
############################################################################################################################
# Remove devices from Autopilot and Entra ID

# Import the required module
Import-Module Microsoft.Graph

# Define all required variables at the beginning
$scopes = "Device.Read.All", "Group.ReadWrite.All"  # Adjust scopes as needed

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Remove devices from Autopilot and Entra ID
# Define the CSV file path
$CsvFile = "C:\Temp\FullDeviceList.csv"

# Import the CSV file
$DeviceList = Import-Csv -Path $CsvFile

# Loop through each device in the CSV
foreach ($device in $DeviceList) {
    $AutopilotID = $device.AutoPilotID
    $EntraID = $device.EntraID  # Use EntraID instead of DeviceId

    # Check if the Autopilot ID exists before attempting deletion
    if ($AutopilotID) {
        Write-Host "Removing device from Autopilot: $AutopilotID"
        Remove-MgDeviceManagementWindowsAutopilotDeviceIdentity -WindowsAutopilotDeviceIdentityId $AutopilotID -Confirm:$false
    } else {
        Write-Host "No Autopilot ID found for device."
    }

    # Check if the Entra ID exists before attempting deletion
    if ($EntraID) {
        Write-Host "Removing device from Entra ID: $EntraID"
        Remove-MgDevice -DeviceId $EntraID -Confirm:$false
    } else {
        Write-Host "No Entra ID found for this entry."
    }
}

Write-Host "Device cleanup process complete."

# Disconnect from Microsoft Graph
Disconnect-MgGraph
