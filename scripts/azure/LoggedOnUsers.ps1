Connect-MgGraph -Scopes "AuditLog.Read.All", "Directory.Read.All"

# Set the date range to the last two weeks
$twoWeeksAgo = (Get-Date).AddDays(-14)

# Fetch sign-in logs for the last two weeks
$logons = Get-MgAuditLogSignIn -Filter "createdDateTime ge $($twoWeeksAgo.ToString('yyyy-MM-ddTHH:mm:ssZ'))" -All

# Prepare the result with unique UPNs only
$result = $logons | Select-Object -Property @{Name="UserPrincipalName";Expression={$_.UserPrincipalName}},
                                        @{Name="ObjectId";Expression={$_.UserId}} |
    Sort-Object UserPrincipalName -Unique

# Export the result to CSV
$result | Export-Csv -Path "C:\temp2\UsersLoggedOn.csv" -NoTypeInformation