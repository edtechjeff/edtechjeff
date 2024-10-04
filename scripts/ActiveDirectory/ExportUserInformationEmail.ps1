# Import the Active Directory module (make sure it's installed on your system)
Import-Module ActiveDirectory

# Retrieve user information and export to CSV
Get-ADUser -Filter * -Property DisplayName, EmailAddress, SamAccountName, ProxyAddresses, mailNickName | 
Select-Object DisplayName, EmailAddress, SamAccountName, @{Name="Alias";Expression={$_.mailNickName}}, 
@{Name="ProxyAddresses";Expression={$_.ProxyAddresses -join "; "}} | 
Export-Csv -Path "C:\temp\ADUsers1.csv" -NoTypeInformation