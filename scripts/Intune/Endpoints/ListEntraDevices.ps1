# Notes
    # Entra, ID = ObjectID

    # Autopilot, ID = AzureActiveDirectoryDeviceId

    # DeviceID is the common ID between Entra and Autopilot
############################################################################################################################
# Get a list of device in Entra ID

# Import the required module
Import-Module Microsoft.Graph

# Define all required variables at the beginning
$scopes = "Device.Read.All", "Group.ReadWrite.All"  # Adjust scopes as needed

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Get a list of Devices in AzureAD
Get-MgDevice -All -Property DisplayName, DeviceId, Id, ApproximateLastSignInDateTime | Select-Object DisplayName, DeviceId, Id, ApproximateLastSignInDateTime

# Disconnect from Microsoft Graph
Disconnect-MgGraph
