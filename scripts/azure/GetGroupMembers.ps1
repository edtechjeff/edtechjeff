# Install AzureAD Module
Install-Module AzureAD

# Connect to AzureAD
Connect-AzureAD

$groupId = "<Your-Group-ID>"
Get-AzureADGroupMember -ObjectId $groupId -All $true | ForEach-Object {
    if ($_.ObjectType -eq "Group") {
        $nestedGroupId = $_.ObjectId
        # Recursively get members of the nested group
        Get-AzureADGroupMember -ObjectId $nestedGroupId -All $true
    }
}
