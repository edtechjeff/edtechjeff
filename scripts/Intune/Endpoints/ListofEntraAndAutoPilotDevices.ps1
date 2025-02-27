# Notes
    # Entra, ID = ObjectID

    # Autopilot, ID = AzureActiveDirectoryDeviceId

    # DeviceID is the common ID between Entra and Autopilot
############################################################################################################################
# Listing all device in Entra ID and AutoPilot
# Import the required module
Import-Module Microsoft.Graph

# Define all required variables at the beginning
$scopes = "Device.Read.All", "Group.ReadWrite.All"  # Adjust scopes as needed

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Retrieve Entra ID devices
$Devices = Get-MgDevice -All -Property DisplayName, DeviceId, Id, ApproximateLastSignInDateTime | 
    Select-Object DisplayName, DeviceId, Id, ApproximateLastSignInDateTime

# Retrieve Autopilot devices
$AutopilotDevices = Get-MgDeviceManagementWindowsAutopilotDeviceIdentity | 
    Select-Object SerialNumber, Id, AzureActiveDirectoryDeviceId, ManagedDeviceId

# Join the data using AzureActiveDirectoryDeviceId to match with DeviceId
$CombinedList = foreach ($device in $Devices) {
    $autopilot = $AutopilotDevices | Where-Object { $_.AzureActiveDirectoryDeviceId -eq $device.DeviceId }
    
    [PSCustomObject]@{
        EntraID                        = $device.Id  # Entra ID object ID
        DeviceId                       = $device.DeviceId
        SerialNumber                   = $autopilot.SerialNumber
        AutoPilotID                    = $autopilot.Id  # AutoPilot ID
        DisplayName                    = $device.DisplayName
        ApproximateLastSignInDateTime  = $device.ApproximateLastSignInDateTime
    }
}

# Output the result
$CombinedList

# Disconnect from Microsoft Graph
Disconnect-MgGraph
