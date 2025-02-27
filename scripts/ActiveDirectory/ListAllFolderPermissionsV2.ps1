# Define the folder to scan (Change this to your target folder)
$folderPath = "C:\SharedFolder"

# Define output file
$outputFile = "C:\Temp\Folder_Permissions.csv"

# Define groups to exclude
$excludedGroups = @(
    "NT AUTHORITY\SYSTEM",
    "BUILTIN\Administrators",
    "HBP\File Admin",
    "HBP\ESIadmin"
)

# Initialize an array to store results
$results = @()

# Get all folders recursively
$folders = Get-ChildItem -Path $folderPath -Recurse -Directory -Force

# Include the root folder itself
$folders = @($folderPath) + $folders.FullName

foreach ($folder in $folders) {
    # Get ACL (permissions)
    $acl = Get-Acl -Path $folder

    foreach ($access in $acl.Access) {
        # Exclude specified groups
        if ($excludedGroups -notcontains $access.IdentityReference.Value) {
            $results += [PSCustomObject]@{
                FolderPath    = $folder
                Account       = $access.IdentityReference
                AccessRights  = $access.FileSystemRights
                AccessType    = $access.AccessControlType
                Inherited     = $access.IsInherited
            }
        }
    }
}

# Export to CSV
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Folder permissions exported to $outputFile"
