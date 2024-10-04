# Install Microsoft Graph module (if not installed yet)
Install-Module Microsoft.Graph -Scope CurrentUser

# Connect to EntraID (Azure AD)
Connect-MgGraph -Scopes "User.Read.All"

# Get all users from EntraID
$Users = Get-MgUser -All

# Iterate through the list of users and extract details
$UserDetails = $Users | ForEach-Object {
    [PSCustomObject]@{
        "Full Name"      = $_.DisplayName
        "Email Address"  = $_.Mail
        "User Principal Name (UPN)" = $_.UserPrincipalName
        "SMTP Addresses" = ($_.ProxyAddresses -join "; ")
    }
}

# Export the result to CSV file (optional)
$UserDetails | Export-Csv -Path "C:\temp2\Pike\EntraID_Users.csv" -NoTypeInformation

# Display the result in the console
$UserDetails
