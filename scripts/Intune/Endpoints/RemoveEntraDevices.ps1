# Remove devices from Entra ID

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
    $EntraID = $device.EntraID  # Entra ID from the CSV

    # Check if the Entra ID exists before attempting deletion
    if ($EntraID) {
        Write-Host "Removing device from Entra ID: $EntraID"
        Remove-MgDevice -DeviceId $EntraID -Confirm:$false
    } else {
        Write-Host "No Entra ID found for this entry."
    }
}

Write-Host "Entra ID device cleanup process complete."

# Disconnect from Microsoft Graph
Disconnect-MgGraph