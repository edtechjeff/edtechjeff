# Install and import the Microsoft Graph module (if not already installed)
Install-Module -Name Microsoft.Graph -Force -AllowClobber
Import-Module Microsoft.Graph

# Connect to Microsoft Graph
$UserCredential = Get-Credential
Connect-MgGraph -Credential $UserCredential

# Get all users and their ObjectID
$Users = Get-MgUser -All | Select-Object DisplayName, UserPrincipalName, Id

# Export the result to a CSV file
$Users | Export-Csv -Path "C:\Temp2\GraphUsersObjectIDs.csv" -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph

Write-Host "Microsoft Graph User ObjectID export completed. File saved to C:\Temp2\GraphUsersObjectIDs.csv"
