# Install and import the MSOnline module
Install-Module -Name MSOnline -Force -AllowClobber
Import-Module MSOnline

# Connect to Azure AD (MSOnline)
Connect-MsolService

# Get all users and their associated ImmutableID
$Users = Get-MsolUser -All | Select-Object DisplayName, UserPrincipalName, ImmutableId

$Users

# Export the result to a CSV file
$Users | Export-Csv -Path "C:\Temp2\MsolUsersImmutableIDs.csv" -NoTypeInformation

# Write to Host
Write-Host "ImmutableID export completed. File saved to C:\Temp2\MsolUsersImmutableIDs.csv"
