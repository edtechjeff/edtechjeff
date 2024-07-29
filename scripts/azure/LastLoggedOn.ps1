# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the OU to query
$ou = "OU=Carmel,OU=SePRO,DC=in,DC=sepro,DC=com"

# Specify Output File
$output = "C:\SCRIPTS\output\users.csv"

Get-ADUser -Filter * -SearchBase $ou -Properties "LastLogonDate" | Select-Object Name, LastLogonDate | Export-Csv -Path $output  -NoTypeInformation
