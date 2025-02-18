$Model = (Get-CimInstance -ClassName Win32_ComputerSystem).Model -replace " ", ""
$DriverPath = "Z:\$Model"

if (Test-Path $DriverPath) {
    Write-Output "Applying drivers from: $DriverPath"
    dism /image:C:\ /add-driver /driver:$DriverPath /recurse /forceunsigned
} else {
    Write-Output "No driver pack found for model: $Model"
}

