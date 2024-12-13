Import-Module ActiveDirectory

# Replace 'username' with the user's SamAccountName
Get-ADUser -Identity username -Properties msDS-UserPasswordExpiryTimeComputed | 
    Select-Object Name, @{Name="PasswordExpiryDate"; Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
