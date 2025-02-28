$csvPath = "d:\scripts\Perms.csv"

if (!(Test-Path $csvPath)) {
    Write-Output "Error: CSV file not found at $csvPath"
    exit
}

$permissionsList = Import-Csv -Path $csvPath

foreach ($entry in $permissionsList) {
    $folderPath = $entry.Path
    $group = $entry.Group
    $permissions = $entry.Permissions
    $disableInheritance = $entry.DisableInheritance -as [bool]  # Convert CSV value to boolean

    # Validate folderPath
    if ([string]::IsNullOrWhiteSpace($folderPath)) {
        Write-Output "Skipping: Empty folder path"
        continue
    }

    if (!(Test-Path $folderPath)) {
        Write-Output "Skipping: Folder does not exist - $folderPath"
        continue
    }

    try {
        # Validate and parse permissions correctly
        $rights = [System.Enum]::Parse([System.Security.AccessControl.FileSystemRights], $permissions, $true)

        # Get the current ACL
        $acl = Get-Acl -Path $folderPath

        # Apply inheritance settings based on CSV flag
        if ($disableInheritance) {
            $acl.SetAccessRuleProtection($true, $true)  # Disables inheritance but keeps inherited permissions
            Write-Output "Inheritance Disabled (kept inherited permissions) for $folderPath"
        } else {
            Write-Output "Inheritance Kept for $folderPath"
        }

        # Create a new FileSystemAccessRule with inheritance for subfolders and files
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($group, $rights, "ContainerInherit, ObjectInherit", "None", "Allow")

        # Add the rule to the ACL
        $acl.AddAccessRule($rule)

        # Apply the ACL back to the folder
        Set-Acl -Path $folderPath -AclObject $acl

        Write-Output "Applied permissions to $folderPath for $group with $permissions (DisableInheritance: $disableInheritance)"
    } catch {
        Write-Output ("Error processing " + $folderPath + ": " + $_.Exception.Message)
    }
}