Connect-ExchangeOnline

$onPremDLs = Get-DistributionGroup | Where-Object { ($_.IsDirSynced -eq $true -and $_.GroupType -ne "Universal, SecurityEnabled") }
$onPremDLs | Select-Object Name, GrantSendOnBehalfTo, MemberJoinRestriction, MemberDepartRestriction | Export-Csv "C:\ClosedOpenGrantSendOnBehalf.csv" -NoTypeInformation -Encoding UTF8
