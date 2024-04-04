Connect-ExchangeOnline

$Result = @()
$groups = Get-DistributionGroup | Where-Object { ($_.IsDirSynced -eq $true -and $_.GroupType -ne "Universal, SecurityEnabled") }
$totalmbx = $groups.Count
$i = 1

$groups | ForEach-Object {
    Write-Progress -Activity "Processing $($_.DisplayName)" -Status "$i out of $totalmbx completed"
    $group = $_
    $members = Get-DistributionGroupMember -Identity $group.Name -ResultSize Unlimited
    $owners = Get-DistributionGroup $group.Name | Select-Object -ExpandProperty ManagedBy

    # Check if the group is a distribution list (DL)
    if ($group.RecipientType -eq "MailUniversalDistributionGroup") {
        foreach ($member in $members) {
            $Result += New-Object PSObject -Property @{
                GroupName = $group.DisplayName
                Member = $member.PrimarySMTPAddress
                Owner = $owners

            }
        }
    }
    $i++
}

$Result | Export-CSV -Path "C:\Synced-Distribution-Group-Members.csv" -NoTypeInformation -Encoding UTF8