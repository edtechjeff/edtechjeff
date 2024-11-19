# Purpose of this is to set up a resource to be viewable in Outlook and Teams in order 

# Create the Room in the Gui or via command which ever

Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName navin@contoso.onmicrosoft.com


# Set Information to include the following
set-place room303@edtechjeff.com -CountryOrRegion "US" -State "Indiana" -City "Indianapolis" -Building Main -Floor 3 -FloorLabel "3rd Floor" -Capacity 200

# List Mailboxes and verify information is correct
Get-EXOMailbox -RecipientTypeDetails RoomMailbox | Sort Displayname | Get-Place | Format-Table Identity, DisplayName, Building, Floor, City

# Next you will need to create the distribution group for the conference rooms.
New-DistributionGroup -Name allconfrooms -DisplayName “All Conference Rooms” -PrimarySmtpAddress allconferencerooms@edtechjeff.com -RoomList

# Now we need to add the mailboxes to the distribution list. You do that with the following command. You do have to do this command per mailbox.
Add-DistributionGroupMember -Identity "allconferencerooms@edtechjeff.com" -Member "IT@edtechjeff.com"
Add-DistributionGroupMember -Identity "allconferencerooms@edtechjeff.com" -Member "Room303@edtechjeff.com"

# Verify that the groups are all configured correctly
$FormatEnumerationLimit=-1
Get-DistributionGroup -Identity allconferencerooms@edtechjeff.com
Get-DistributionGroupMember -Identity allconferencerooms@edtechjeff.com
$members = Get-DistributionGroupMember -Identity allconferencerooms@edtechjeff.com | select Name | foreach {Get-Place -Identity $_.Name | Format-List}
$members