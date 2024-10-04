# Specify the root folder path
$rootFolderPath = "C:\YourRootFolder"

# Get a list of all subfolders and their full paths
$subfolders = Get-ChildItem -Path $rootFolderPath -Directory | Select-Object FullName

# Export the list of subfolders to a CSV file
$csvPath = "C:\path\to\folders.csv"
$subfolders | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "Subfolder paths exported to $csvPath"

# Specify the path to the CSV file
$csvPath = "C:\path\to\folders.csv"

# Specify the user or group for which you want to deny delete permissions
$userOrGroup = "YourSecurityGroup"

# Import the subfolder paths from the CSV file
$folderList = Import-Csv -Path $csvPath

# Loop through each subfolder and apply the deny permission for delete
foreach ($folder in $folderList) {
    $folderPath = $folder.FullName  # Access the folder path from the CSV

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

    Write-Host "Deny permission for deleting the folder has been applied to $userOrGroup on $folderPath"
}
