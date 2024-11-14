# Define a list of groups typically associated with administrative roles
$adminGroups = @("Domain Admins", "Enterprise Admins", "Administrators", "Schema Admins", "Account Operators", "Server Operators", "Backup Operators", "Print Operators")

# Create an empty array to store results
$adminUsers = @()

# Loop through each group to retrieve its members
foreach ($group in $adminGroups) {
    # Retrieve group object
    $groupObj = Get-ADGroup -Filter {Name -eq $group} -Properties Members
    if ($groupObj -ne $null) {
        # Retrieve members of the group
        foreach ($member in $groupObj.Members) {
            $user = Get-ADUser -Identity $member -Properties DisplayName | Select-Object DisplayName, SamAccountName
            if ($user -ne $null) {
                # Add user information and group membership to the results
                $adminUsers += [pscustomobject]@{
                    UserName   = $user.DisplayName
                    SamAccount = $user.SamAccountName
                    Role       = $group
                }
            }
        }
    }
}

# Output the result to the console
$adminUsers | Format-Table -AutoSize

# Export the result to a CSV file
$adminUsers | Export-Csv -Path "c:\temp\AdminUsersRoles.csv" -NoTypeInformation -Encoding UTF8