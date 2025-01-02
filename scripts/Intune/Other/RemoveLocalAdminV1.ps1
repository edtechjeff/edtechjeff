# Get the current logged-in user
$CurrentUser = (Get-WmiObject -Class Win32_ComputerSystem).UserName

# Remove the user from the Administrators group
Remove-LocalGroupMember -Group "Administrators" -Member $CurrentUser
