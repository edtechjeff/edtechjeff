<#
    .SYNOPSIS
    Import-CAPolicies.ps1

    .DESCRIPTION
    Import Conditional Access policies from JSON files for restore purposes.

    .LINK
    www.alitajran.com/import-conditional-access-policies/

    .NOTES
    Written by: ALI TAJRAN
    Website:    www.alitajran.com
    LinkedIn:   linkedin.com/in/alitajran

    .CHANGELOG
    V1.00, 11/19/2023 - Initial version
#>

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Policy.Read.All", "Policy.ReadWrite.ConditionalAccess", "Application.Read.All"

# Define the path to the directory containing your JSON files
$jsonFilesDirectory = "C:\temp\CA"

# Get all JSON files in the directory
$jsonFiles = Get-ChildItem -Path $jsonFilesDirectory -Filter *.json

# Check if there are no JSON files
if ($jsonFiles.Count -eq 0) {
    Write-Host "No JSON files found in the directory to import." -ForegroundColor Yellow
}
else {
    # Loop through each JSON file
    foreach ($jsonFile in $jsonFiles) {
        try {
            # Read the content of the JSON file and convert it to a PowerShell object
            $policyJson = Get-Content -Path $jsonFile.FullName | ConvertFrom-Json

            # Create a custom object
            $policyObject = [PSCustomObject]@{
                displayName     = $policyJson.displayName
                conditions      = $policyJson.conditions
                grantControls   = $policyJson.grantControls
                sessionControls = $policyJson.sessionControls
                state           = $policyJson.state
            }

            # Convert the custom object to JSON with a depth of 10
            $policyJsonString = $policyObject | ConvertTo-Json -Depth 10

            # Create the Conditional Access policy using the Microsoft Graph API
            $null = New-MgIdentityConditionalAccessPolicy -Body $policyJsonString
        
            # Print a success message
            Write-Host "Policy created successfully: $($policyJson.displayName) " -ForegroundColor Green
        }
        catch {
            # Print an error message if an exception occurs
            Write-Host "An error occurred while creating the policy: $_" -ForegroundColor Red
        }
    }
}