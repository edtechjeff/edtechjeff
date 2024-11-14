# Define the number of days for inactivity
$daysInactive = 90

# Calculate the date 90 days ago
$inactiveDate = (Get-Date).AddDays(-$daysInactive)

# Import the Active Directory module
Import-Module ActiveDirectory

# Find all users who have not logged on in the last 90 days
$inactiveUsers = Get-ADUser -Filter {LastLogonDate -lt $inactiveDate} -Properties LastLogonDate |
                 Select-Object Name, SamAccountName, LastLogonDate |
                 Sort-Object LastLogonDate

# Display the results
$inactiveUsers | Format-Table -AutoSize
