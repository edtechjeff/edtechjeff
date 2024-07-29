Connect-ExchangeOnline

$onPremDLs = Get-DistributionGroup | Where-Object { ($_.IsDirSynced -eq $true -and $_.GroupType -ne "Universal, SecurityEnabled") }
$onPremDLs | Select-Object Name, EmailAddresses | Export-Csv "C:\Synced-Distribution-Groups-Email-alias.csv" -NoTypeInformation -Encoding UTF8

