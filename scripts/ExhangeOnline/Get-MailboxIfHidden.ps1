#Gets if the mailbox is hidden or not
Get-Mailbox contentrm@edtechjeff.com | Select-Object Name, HiddenFromAddressListsEnabled