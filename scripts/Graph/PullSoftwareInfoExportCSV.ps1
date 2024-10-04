Connect-MgGraph -Scopes "DeviceManagementApps.Read.All","DeviceManagementManagedDevices.Read.All"


$result=@()
Get-MgDeviceManagementDetectedApp -All | ForEach-Object {
    $tmp = $_
    
    # Check if the detected app's display name contains "Sophos"
    if ($tmp.DisplayName -like "*Sophos*") {
        $result += (Get-MgDeviceManagementDetectedAppManagedDevice -DetectedAppId $_.id | Select-Object -Property @{Name="Device";Expression={$_.DeviceName}}, 
            @{Name="App";Expression={$tmp.DisplayName}}, 
            @{Name="Version";Expression={$tmp.Version}}, 
            @{Name="Platform";Expression={$tmp.Platform}})
    }
}

# Sort and export the result to a CSV file
$result | Sort-Object -Property Device, App, Version | Export-Csv -Path "C:\temp2\ChromeDetectedApps.csv" -NoTypeInformation