# Retrieve the GUID for user 'johndoe'
$user = Get-ADUser -Identity "johndoe" -Properties objectGUID
$user.objectGUID
###########################################################################
# Retrieve the GUID for All Users
Get-ADUser -Filter * -Properties objectGUID, UserPrincipalName | Select-Object UserPrincipalName, @{Name="GUID";Expression={[System.Guid]::New($_.objectGUID)}}
###########################################################
#Convert to base 64 String
[Convert]::ToBase64String([guid]::New("YOURGUIDID").ToByteArray())
###########################################################
# Run Commands to get MSOnline Running
Install-Module MSOnline
Import-Module MSOnline
Connect-MsolService
############################################################
#Check to see if the user has an ImmutableID
Get-Msoluser -UserPrincipalName johndoe@edtechjeff.com | Select-Object ImmutableId
############################################################
#Set ImmutableID
Set-MsolUser -UserPrincipalName johndoe@edtechjeff.com -ImmutableId EpoakjdlfkajdlkfjiJQ==
############################################################
#Disconnect Graph
disconnect-mggraph
############################################################
