List Deleted Users
Get-MsolUser -ReturnDeletedUsers

Rmove Specific UserCredential
Remove-MsolUser -UserPrincipalName johndoe@edtechjeff.com -RemoveFromRecycleBin

Remove All Users
Get-MsolUser -ReturnDeletedUsers | Remove-MsolUser -RemoveFromRecycleBin -Force