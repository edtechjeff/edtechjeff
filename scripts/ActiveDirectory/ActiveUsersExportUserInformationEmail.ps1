# Import the Active Directory module (make sure it's installed on your system)
Import-Module ActiveDirectory

# Retrieve user information for enabled accounts and export to CSV
Get-ADUser -Filter {Enabled -eq $true} -Property DisplayName, EmailAddress, SamAccountName, ProxyAddresses, mailNickName | 
Select-Object DisplayName, EmailAddress, SamAccountName, @{Name="Alias";Expression={$_.mailNickName}}, 
@{Name="ProxyAddresses";Expression={$_.ProxyAddresses -join "; "}} | 
Export-Csv -Path "C:\temp\ADUsers1.csv" -NoTypeInformation
