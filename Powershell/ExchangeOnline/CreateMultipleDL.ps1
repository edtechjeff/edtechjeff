Connect-ExchangeOnline

$groupData = Import-Csv -Path "C:\temp\apps\scripts\list\dl.csv"

foreach ($row in $groupData) {
    New-DistributionGroup -Name $row.Name `
                          -DisplayName $row.DisplayName `
                          -PrimarySmtpAddress $row.PrimarySmtpAddress `
                          -ManagedBy $row.Owners.Split(',')`
                          -Members $row.Members.Split(',')
}

#Set-DistributionGroup -Identity "YourGroupName" -EmailAddresses @{add="alias1@domain.com","alias2@domain.com"}