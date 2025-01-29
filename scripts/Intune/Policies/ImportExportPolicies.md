# Import and Export Policies (Conditional Access and Intune)

---
## Export-intune-all.ps1
This PowerShell script will export all polices out of Intune which include
- Compliance policies
- Configuration policies
- Endpoint Security policies
- Managed app policies

In order for this to work you will need to create an application registration and give it the following permissions
- DeviceManagementApps.ReadWrite.All
- DeviceManagementConfiguration.ReadWrite.All
- DeviceManagementServiceConfig.ReadWrite.All

After you create the application you will need to go into secrets and create one and copy the secret password

You will need to know the following information when you run the script
- Client ID
- Client Secret
- Tenant ID
- Output location

When you run the script it will output 
![alt text](Assets/Image1.png)