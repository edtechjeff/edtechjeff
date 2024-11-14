# Import Active Directory module
Import-Module ActiveDirectory

# Search for locked-out accounts
$lockedAccounts = Search-ADAccount -LockedOut -UsersOnly | 
    Select-Object Name, SamAccountName, UserPrincipalName

# Output the list of locked accounts
if ($lockedAccounts) {
    $lockedAccounts | Format-Table -AutoSize
} else {
    Write-Host "No locked-out accounts found."
}