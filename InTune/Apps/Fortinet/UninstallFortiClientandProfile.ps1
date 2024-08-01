# Restart Process using PowerShell 64-bit 
If ($ENV:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    Try {
        &"$ENV:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File $PSCOMMANDPATH
    }
    Catch {
        Throw "Failed to start $PSCOMMANDPATH"
    }
    Exit
}
# Stop FortiClient Process
Stop-Process -Name FortiClient -ErrorAction SilentlyContinue
# Uninstall FortiClient
Start-Process Msiexec.exe -wait -ArgumentList /'x {FF46D152-9845-4ACE-8258-DBA7E3BE9785} REBOOT=ReallySuppress /qn'
# Remove FortiClient VPN Profiles
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\Castheon" -force -ErrorAction SilentlyContinue