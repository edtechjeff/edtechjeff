# Specify the folder path
$folderPath = "C:\YourFolder"

# Specify the user or group (replace with the appropriate username or group)
$userOrGroup = "YourSecurityGroup"

# Get the current access control (ACL) settings of the folder
$acl = Get-Acl $folderPath

# Define the deny rule for the Delete action
$denyRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    $userOrGroup, 
    'Delete',  # Deny Delete permission
    'Deny'
)

# Add the deny rule to the ACL
$acl.AddAccessRule($denyRule)

# Apply the updated ACL to the folder
Set-Acl -Path $folderPath -AclObject $acl

Write-Host "Deny permission for deleting the folder has been applied to $userOrGroup"
