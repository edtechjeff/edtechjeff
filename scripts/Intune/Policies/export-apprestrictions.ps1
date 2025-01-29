<#PSScriptInfo
.VERSION 0.1
.GUID a7d9a727-03d3-4521-972a-0f46d7e21edc
.AUTHOR
 Maarten Peeters
.COMPANYNAME
 CloudSecuritea
#>

<#
.SYNOPSIS
 This script will export Intune policies.

.DESCRIPTION
 This script will export Intune policies.

.PARAMETER client_Id
 Enter the client ID of the application created for this task.

.PARAMETER client_Secret
 Enter the client Secret of the application created for this task.

.PARAMETER tenant_Id
 Enter the tenant ID.

.PARAMETER location
 Enter the location to store the .JSON files.

.EXAMPLE
 export-intune.ps1 -client_Id <String> -client_Secret <string> -tenant_Id <String> -location <String>
#>

param(
  [Parameter(mandatory = $true)]
  [String]$client_Id,
  [Parameter(mandatory = $true)]
  [String]$client_Secret,
  [Parameter(mandatory = $true)]
  [String]$tenant_Id,
  [Parameter(mandatory = $true)]
  [String]$location
)

######################
# Connect to Graph API
######################
$Body = @{    
  Grant_Type    = "client_credentials"
  Scope         = "https://graph.microsoft.com/.default"
  client_id     = $client_Id
  client_secret = $client_Secret
} 

$ConnectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenant_Id/oauth2/v2.0/token" -Method POST -Body $Body 

########################
# Variable Collections
########################

$HeaderParams = @{
  'Content-Type'  = "application/json"
  'Authorization' = "Bearer $($ConnectGraph.access_token)"
}

# Managed app policies
$managedAppPoliciesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceAppManagement/managedAppPolicies" -Method Get
$managedAppPolicies = $managedAppPoliciesRequest.value

##################
# Export to JSON
##################

# Managed app policies
try {
  foreach ($policy in $managedAppPolicies) {
    $filePath = "$location\Managed App - $($policy.displayName).json"
    $policy | ConvertTo-Json -Depth 10 | Out-File $filePath
    $Clean = Get-Content $filePath | Select-String -Pattern '"id":', '"createdDateTime":', '"lastModifiedDateTime":', '"version":' -NotMatch
    $Clean | Out-File -FilePath $filePath
    Write-Host "Exported policy: $($policy.displayName)" -ForegroundColor Green
  }  
}
catch {
  Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
