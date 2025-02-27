# Intune and Entra ID Clean-up Scripts

## In this folder you will find some scripts that will help to clean up dead or unused devices in Entra and in AutoPilot or both
## Some are just outputs to the screen and others will do an export to a CSV

# Mapping it all out

- Graph
- In AutoPilot the AzureActiveDirectoryDeviceId field = DeviceID field in Entra ID
- These fields are used in the combined scripts to tie the two queries together
    - AutoPilot
        - DeviceID = AzureActiveDirectoryDeviceId
        - When deleting from AutoPilot use the ID field    
    - Entra ID
        - DeviceID = DeviceID
        - When deleting from Entra ID use the ID field
        - ID Field = Object ID in Entra ID console