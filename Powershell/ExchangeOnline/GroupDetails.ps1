Connect-ExchangeOnline

$onPremDLs = Get-DistributionGroup | Where-Object { ($_.IsDirSynced -eq $true -and $_.GroupType -ne "Universal, SecurityEnabled") }
$onPremDLs | Select-Object Name, Alias, Description, PrimarySmtpAddress, EmailAddresses, MemberJoinRestriction, MemberDepartRestriction, GrantSendOnBehalfTo | Export-Csv "C:\FullFile.csv" -NoTypeInformation -Encoding UTF8