$CheckForGVLK = Get-CimInstance SoftwareLicensingProduct -Filter "ApplicationID = '55c92734-d682-4d71-983e-d6ec3f16059f' and LicenseStatus = 5"

if ($CheckForGVLK) {
    $CheckForGVLK = $CheckForGVLK.ProductKeyChannel
} else {
    $CheckForGVLK = $null
}

if ($CheckForGVLK -eq 'Volume:GVLK') {
    $GetDigitalLicence = (Get-CimInstance SoftwareLicensingService).OA3xOriginalProductKey

    if ($GetDigitalLicence) {
        cscript c:\windows\system32\slmgr.vbs -ipk $GetDigitalLicence
    } else {
        Write-Host "No digital license found."
    }
}
