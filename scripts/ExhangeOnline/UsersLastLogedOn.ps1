# Connect to EntraID (Azure AD)
Connect-MgGraph -Scopes "User.Read.All", "AuditLog.Read.All"

$Users = Get-MgUser -All -Property Id, UserPrincipalName, DisplayName, UserType, SignInActivity, Mail, AccountEnabled | 
Select-Object Id, UserPrincipalName, DisplayName, UserType, Mail, AccountEnabled,
@{n = "LastSuccessfulSignInDateTime"; e = { $_.SignInActivity.LastSuccessfulSignInDateTime } },
@{n = 'LastNonInteractiveSignInDateTime'; e = { $_.SignInActivity.LastNonInteractiveSignInDateTime } },
@{n = 'LastSignInDateTime'; e = { $_.SignInActivity.LastSignInDateTime } },
@{n = 'DaysSinceLastSuccessfulSignIn'; e = { (New-TimeSpan -Start $_.SignInActivity.LastSuccessfulSignInDateTime -End (Get-Date)).Days } }


$Users | Out-GridView -Title "Last sign-in activity report"
$Users | Export-Csv -Path "C:\temp\LastSignInActivity.csv" -NoTypeInformation -Encoding utf8