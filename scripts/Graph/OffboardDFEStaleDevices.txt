# Define the necessary parameters
$tenantId = "YourTenantID"
$clientId = "YourClientID"
$clientSecret = "YourClientSecret"
$scope = "https://graph.microsoft.com/.default"
$authUrl = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

# Request the access token
$response = Invoke-RestMethod -Method Post -Uri $authUrl -ContentType "application/x-www-form-urlencoded" -Body @{
    client_id     = $clientId
    scope         = $scope
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

# Extract the access token
$accessToken = $response.access_token

# Output the access token
Write-Output "Access Token: $accessToken"


# Path to your CSV file
$csvPath = "C:\Path\To\CSV\list\devices.csv"

# Import the CSV file
$deviceIds = Import-Csv -Path $csvPath

# Loop through each device ID in the CSV
foreach ($device in $deviceIds) {
    $deviceId = $device.DeviceId
    $url = "https://api-us3.securitycenter.windows.com/api/machines/$deviceId/offboard"

    # Invoke the API request (you'll need to provide authorization headers)
    $response = Invoke-RestMethod -Uri $url -Method Post -Headers @{
        "Authorization" = "Bearer $accessToken"
    }

    # Output the response or handle errors
    if ($response.Status -eq "Success") {
        Write-Output "Device $deviceId offboarded successfully."
    } else {
        Write-Output "Failed to offboard device $deviceId. Error: $($response.Error)"
    }
}

# Output the access token
Write-Output "Access Token: $accessToken"
