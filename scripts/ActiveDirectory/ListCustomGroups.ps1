# Import Active Directory module (if not already loaded)
Import-Module ActiveDirectory

# Define output file
$outputFile = "C:\Temp\Custom_AD_Groups.csv"

# List of built-in and default groups to exclude
$defaultGroups = @(
    "Domain Admins", "Enterprise Admins", "Schema Admins", "Administrators", "Users", "Guests",
    "Account Operators", "Backup Operators", "Print Operators", "Server Operators", "Replicator",
    "Domain Users", "Domain Guests", "Cert Publishers", "DnsAdmins", "DnsUpdateProxy", "Enterprise Key Admins",
    "Group Policy Creator Owners", "Read-only Domain Controllers", "Enterprise Read-only Domain Controllers",
    "Allowed RODC Password Replication Group", "Denied RODC Password Replication Group", "Protected Users",
    "Remote Desktop Users", "Incoming Forest Trust Builders", "Pre-Windows 2000 Compatible Access",
    "Windows Authorization Access Group", "Terminal Server License Servers"
)

# Retrieve all AD groups and exclude built-in ones
$customGroups = Get-ADGroup -Filter * | Where-Object { $_.Name -notin $defaultGroups -and $_.DistinguishedName -notlike "*CN=Builtin,*" }

# Store results in an array
$results = @()

foreach ($group in $customGroups) {
    $results += [PSCustomObject]@{
        GroupName = $group.Name
        DistinguishedName = $group.DistinguishedName
        CreatedDate = $group.WhenCreated
        Description = $group.Description
    }
}

# Export to CSV
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Custom AD groups exported to $outputFile"
