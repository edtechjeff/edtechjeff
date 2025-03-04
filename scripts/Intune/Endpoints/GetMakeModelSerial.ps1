$system = Get-CimInstance -ClassName Win32_ComputerSystem
$bios = Get-CimInstance -ClassName Win32_BIOS
[PSCustomObject]@{
    Manufacturer = $system.Manufacturer
    Model = $system.Model
    SerialNumber = $bios.SerialNumber
}