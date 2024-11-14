# Define the number of days for inactivity
$daysInactive = 90

# Calculate the date 90 days ago
$inactiveDate = (Get-Date).AddDays(-$daysInactive)

# Define the distinguished name (DN) of the OU
$ouDN = "OU=YourOU,DC=YourDomain,DC=com"  # Replace with your OU's DN

# Import the Active Directory module
Import-Module ActiveDirectory

# Find all users in the specified OU and sub-OUs who have not logged on in the last 90 days
$inactiveUsers = Get-ADUser -Filter {LastLogonDate -lt $inactiveDate} -SearchBase $ouDN -SearchScope Subtree -Properties LastLogonDate |
                 Select-Object Name, SamAccountName, LastLogonDate |
                 Sort-Object LastLogonDate

# Display the results
$inactiveUsers | Format-Table -AutoSize
