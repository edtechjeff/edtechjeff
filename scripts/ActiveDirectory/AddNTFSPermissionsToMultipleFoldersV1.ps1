# Information About CSV and how it should look
# Path,Group,Permissions
# C:\Folder1,Domain\Group1,ReadAndExecute
# C:\Folder2,Domain\Group2,Modify


# Define the path to the CSV file
$csvPath = "C:\Path\To\Permissions.csv"

# Import the CSV file
$permissionsList = Import-Csv -Path $csvPath

foreach ($entry in $permissionsList) {
    $folderPath = $entry.Path
    $group = $entry.Group
    $permissions = $entry.Permissions
    
    # Convert string permissions to FileSystemRights
    $rights = [System.Security.AccessControl.FileSystemRights]::$permissions
    
    # Get the current ACL
    $acl = Get-Acl -Path $folderPath
    
    # Create a new FileSystemAccessRule
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($group, $rights, "ContainerInherit,ObjectInherit", "None", "Allow")
    
    # Add the rule to the ACL
    $acl.SetAccessRule($rule)
    
    # Enable inheritance
    $acl.SetAccessRuleProtection($false, $true)
    
    # Apply the ACL back to the folder
    Set-Acl -Path $folderPath -AclObject $acl
    
    Write-Output "Applied permissions to $folderPath for $group with $permissions"
}