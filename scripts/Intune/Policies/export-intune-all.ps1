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

# Compliance policies
$compliancePoliciesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/v1.0/deviceManagement/deviceCompliancePolicies" -Method Get
$compliancePolicies = $compliancePoliciesRequest.value

# Configuration policies
$configurationPoliciesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations" -Method Get
$configurationPolicies = $configurationPoliciesRequest.value

# Endpoint Security policies
$endpointSecurityPoliciesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceManagement/intents" -Method Get
$endpointSecurityPolicies = $endpointSecurityPoliciesRequest.value

$endpointSecurityTemplatesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceManagement/templates?`$filter=(isof(%27microsoft.graph.securityBaselineTemplate%27))" -Method Get
$endpointSecurityTemplates = $endpointSecurityTemplatesRequest.value

# Managed app policies
$managedAppPoliciesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceAppManagement/managedAppPolicies" -Method Get
$managedAppPolicies = $managedAppPoliciesRequest.value

##################
# Export to JSON
##################

# Compliance policies
try {
  foreach ($policy in $compliancePolicies) {
    $filePath = "$location\Compliance - $($policy.displayName).json"
    $policy | ConvertTo-Json -Depth 10 | Out-File $filePath
    Write-Host "Exported policy: $($policy.displayName)" -ForegroundColor Green
  }  
}
catch {
  Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Configuration policies
try {
  foreach ($policy in $configurationPolicies) {
    $filePath = "$location\Configuration - $($policy.displayName).json"
    $policy | ConvertTo-Json -Depth 10 | Out-File $filePath
    $Clean = Get-Content $filePath | Select-String -Pattern '"id":', '"createdDateTime":', '"modifiedDateTime":', '"version":', '"supportsScopeTags":' -NotMatch
    $Clean | Out-File -FilePath $filePath
    Write-Host "Exported policy: $($policy.displayName)" -ForegroundColor Green
  }  
}
catch {
  Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Endpoint Security policies
try {
  foreach ($policy in $endpointSecurityPolicies) {
    $filePath = "$location\EndPoint Security - $($policy.displayName).json"
    
    # Creating object for JSON output
    $JSON = New-Object -TypeName PSObject
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'displayName' -Value $policy.displayName
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'description' -Value $policy.description
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'roleScopeTagIds' -Value $policy.roleScopeTagIds
    $ES_Template = $endpointSecurityTemplates | Where-Object { $_.id -eq $policy.templateId }
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'TemplateDisplayName' -Value $ES_Template.displayName
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'TemplateId' -Value $ES_Template.id
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'versionInfo' -Value $ES_Template.versionInfo

    # Getting all categories in specified Endpoint Security Template
    $categoriesRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceManagement/templates/$($ES_Template.id)/categories" -Method Get
    $categories = $categoriesRequest.value

    $settings = @()
    foreach ($category in $categories) {
      $policyId = $policy.id
      $categoryId = $category.id
      $categorySettingsRequest = Invoke-RestMethod -Headers $HeaderParams -Uri "https://graph.microsoft.com/beta/deviceManagement/intents/$policyId/categories/$categoryId/settings?`$expand=Microsoft.Graph.DeviceManagementComplexSettingInstance/Value" -Method Get
      $settings += $categorySettingsRequest.value
    }

    # Adding All settings to settingsDelta ready for JSON export
    Add-Member -InputObject $JSON -MemberType 'NoteProperty' -Name 'settingsDelta' -Value @($settings)

    $JSON | ConvertTo-Json -Depth 5 | Out-File $filePath
    Write-Host "Exported policy: $($policy.displayName)" -ForegroundColor Green
  }  
}
catch {
  Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

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
