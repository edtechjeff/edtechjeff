Connect-MGGraph -Scopes "DeviceManagementApps.Read.All","DeviceManagementManagedDevices.Read.All"

$result=@()
Get-MGDeviceManagementDetectedApp -All | ForEach-Object {
    $tmp = $_
    
    # Check if the detected app's display name contains "Sophos"
    if ($tmp.DisplayName -like "*Sophos*") {
        $result += (Get-MGDeviceManagementDetectedAppManagedDevice -DetectedAppId $_.id | Select-Object -Property @{Name="Device";Expression={$_.DeviceName}}, 
            @{Name="App";Expression={$tmp.DisplayName}}, 
            @{Name="Version";Expression={$tmp.Version}}, 
            @{Name="Platform";Expression={$tmp.Platform}})
    }
}

$result | Sort-Object -Property Device, App, Version | Out-GridView