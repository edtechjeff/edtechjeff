# Install Modules
Install-Module -Name Microsoft.Graph

# Connect to Graph
Connect-MgGraph

$devices = Get-MgDevice
$thresholdDate = (Get-Date).AddDays(-90)

$inactiveDevices = $devices | Where-Object {
    $_.ApproximateLastSignInDateTime -lt $thresholdDate
}

$inactiveDevices | Select-Object DisplayName, ApproximateLastSignInDateTime



$inactiveDevices | Select-Object DisplayName, ApproximateLastSignInDateTime | Export-Csv -Path "InactiveDevices.csv" -NoTypeInformation