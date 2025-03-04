$csvPath = "C:\Temp\SystemInfo.csv"

$system = Get-CimInstance -ClassName Win32_ComputerSystem
$bios = Get-CimInstance -ClassName Win32_BIOS

$object = [PSCustomObject]@{
    Manufacturer = $system.Manufacturer
    Model = $system.Model
    SerialNumber = $bios.SerialNumber
}

# Export to CSV
$object | Export-Csv -Path $csvPath -NoTypeInformation

Write-Output "CSV file saved to: $csvPath"
