# Define output file
$outputFile = "C:\Temp\Printers_Shares.csv"

# Retrieve all printers
$printers = Get-Printer | Select-Object Name, Shared, ShareName, DriverName, PortName

# Initialize an array to store results
$results = @()

foreach ($printer in $printers) {
    $results += [PSCustomObject]@{
        PrinterName = $printer.Name
        Shared = $printer.Shared
        ShareName = if ($printer.Shared) { $printer.ShareName } else { "Not Shared" }
        DriverName = $printer.DriverName
        PortName = $printer.PortName
    }
}

# Export to CSV
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Printer and share list exported to $outputFile"
