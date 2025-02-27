# Need a CSV with Header of DeviceId

Install-Module Microsoft.Graph -Scope CurrentUser
Connect-MgGraph -Scopes "Device.ReadWrite.All"


$devices = Import-Csv -Path "C:\temp\devices.csv"

foreach ($device in $devices) {
    try {
        Remove-MgDevice -DeviceId $device.DeviceId -Confirm:$false
        Write-Host "Removed device: $($device.DeviceId)"
    } catch {
        Write-Host "Failed to remove device: $($device.DeviceId) - $_"
    }
}

Disconnect-MgGraph