# Import Active Directory module (if not already loaded)
Import-Module ActiveDirectory

# Define output file
$outputFile = "C:\Temp\AD_Groups_Members.csv"

# Retrieve all groups
$groups = Get-ADGroup -Filter * | Select-Object Name, DistinguishedName

# Initialize an array to store results
$results = @()

foreach ($group in $groups) {
    # Get members of the group
    $members = Get-ADGroupMember -Identity $group.DistinguishedName -ErrorAction SilentlyContinue

    if ($members) {
        foreach ($member in $members) {
            $results += [PSCustomObject]@{
                GroupName = $group.Name
                MemberName = $member.Name
                MemberType = $member.objectClass
                MemberDistinguishedName = $member.DistinguishedName
            }
        }
    } else {
        # If no members, add group with empty member fields
        $results += [PSCustomObject]@{
            GroupName = $group.Name
            MemberName = "No Members"
            MemberType = "N/A"
            MemberDistinguishedName = "N/A"
        }
    }
}

# Export to CSV
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Group membership list exported to $outputFile"
