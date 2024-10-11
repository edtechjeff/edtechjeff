# Import the Active Directory module
Import-Module ActiveDirectory

# Get all user accounts and their ObjectGUID
$Users = Get-ADUser -Filter * -Property ObjectGUID | Select-Object Name, SamAccountName, ObjectGUID

# Export the result to a CSV file
$Users | Export-Csv -Path "C:\Temp2\ADUsersObjectGUIDs.csv" -NoTypeInformation

Write-Host "User ObjectGUID export completed. File saved to C:\Temp2\ADUsersObjectGUIDs.csv"