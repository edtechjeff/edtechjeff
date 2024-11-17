#Gets Information about Mailboxes
Get-Mailbox -RecipientTypeDetails RoomMailbox | Format-Table Name, DisplayName, PrimarySmtpAddress, RecipientTypeDetails