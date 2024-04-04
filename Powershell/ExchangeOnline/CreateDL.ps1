Connect-ExchangeOnline
New-DistributionGroup -Name "DLNAME" -DisplayName "DISPLAYNAME" -PrimarySmtpAddress primarysmtp.com -Members "MEMBER1@domain.com", "Member2@domain.com" -ManagedBy @{Add="GUIDIDOFUSER"}



