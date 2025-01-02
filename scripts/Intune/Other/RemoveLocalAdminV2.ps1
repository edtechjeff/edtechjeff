# Get the current logged-in user
$CurrentUser = (Get-WmiObject -Class Win32_ComputerSystem).UserName

# Check if the current user is a member of the local Administrators group
$IsAdmin = (Get-LocalGroupMember -Group "Administrators" | Where-Object { $_.Name -eq $CurrentUser })

if ($IsAdmin) {
    Write-Host "The user $CurrentUser is a member of the Administrators group. Attempting to remove them..."
    try {
        # Remove the user from the Administrators group
        Remove-LocalGroupMember -Group "Administrators" -Member $CurrentUser -ErrorAction Stop
        Write-Host "The user $CurrentUser has been removed from the Administrators group."
        exit 0
    } catch {
        Write-Host "Failed to remove the user $CurrentUser from the Administrators group. Error: $_"
        exit 1
    }
} else {
    Write-Host "The user $CurrentUser is NOT a member of the Administrators group. No action needed."
    exit 0
}
