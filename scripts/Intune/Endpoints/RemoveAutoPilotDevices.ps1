# Remove devices from Autopilot

# Import the required module
Import-Module Microsoft.Graph

# Define all required variables at the beginning
$scopes = "Device.Read.All", "Group.ReadWrite.All"  # Adjust scopes as needed

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Define the CSV file path
$CsvFile = "C:\Temp\FullDeviceList.csv"

# Import the CSV file
$DeviceList = Import-Csv -Path $CsvFile

# Loop through each device in the CSV
foreach ($device in $DeviceList) {
    $AutopilotID = $device.AutoPilotID  # AutoPilot ID from the CSV

    # Check if the Autopilot ID exists before attempting deletion
    if ($AutopilotID) {
        Write-Host "Removing device from Autopilot: $AutopilotID"
        Remove-MgDeviceManagementWindowsAutopilotDeviceIdentity -WindowsAutopilotDeviceIdentityId $AutopilotID -Confirm:$false
    } else {
        Write-Host "No Autopilot ID found for this entry."
    }
}

Write-Host "Autopilot device cleanup process complete."

# Disconnect from Microsoft Graph
Disconnect-MgGraph
