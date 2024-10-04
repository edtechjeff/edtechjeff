# Define the number of days to check for inactivity
$daysInactive = 90

# Calculate the date to compare for inactivity
$inactiveDate = (Get-Date).AddDays(-$daysInactive)

# Get the inactive devices (computers) from Active Directory
$inactiveComputers = Get-ADComputer -Filter {LastLogonDate -lt $inactiveDate} -Properties LastLogonDate | 
    Select-Object Name, LastLogonDate

# Display the results
if ($inactiveComputers) {
    Write-Host "Inactive devices (not logged in for $daysInactive days or more):" -ForegroundColor Green
    $inactiveComputers | Format-Table -AutoSize
} else {
    Write-Host "No inactive devices found." -ForegroundColor Yellow
}
