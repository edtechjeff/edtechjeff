# Get List of all Members in a Distribution Group
$FormatEnumerationLimit=-1
Get-DistributionGroup -Identity allconferencerooms@wfyi.org
Get-DistributionGroupMember -Identity allconferencerooms@wfyi.org
$members = Get-DistributionGroupMember -Identity allconferencerooms@wfyi.org | select Name | foreach {Get-Place -Identity $_.Name | Format-List}
$members