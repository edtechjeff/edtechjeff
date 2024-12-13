# Used to test if the connection to AD is False or True
Test-ComputerSecureChannel -Credential (Get-Credential) -Verbose

# Used to Repair Connection to ID or Network ID
Test-ComputerSecureChannel -Credential (Get-Credential) -Verbose -Repair