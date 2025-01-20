# Intune Windows Defender Application Control

## Useful Links
* https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/appcontrol-wizard-create-base-policy
* https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/example-appcontrol-base-policies

# Warning, depending on what you are setting this could block out the device to the point where you might have to reset the device. BE CAREFUL

## Before you being
* Test group for deployment
* Test machine for deployment
* Add machine to test deployment group
* Download and install the App Control Wizard https://webapp-wdac-wizard.azurewebsites.net/
* Test Application (Putty will be example for this POC)


## Create Base Policy
Launch the App Control Wizard and click on Policy Creator
![alt text](../Assets/WDAC/Image1.png)

Click next and leave the defaults
![alt text](../Assets/WDAC/image2.png)

Here you have 3 options. My professional opinion is it goes from left to right most restrictive to least restrictive. I have worked with the different settings and I do feel like the Allow Microsoft Mode is a good place to start and go from there depending on your applications. These policies do have already built in allows that can make things easier.  Also in this link [here](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/example-appcontrol-base-policies) are even more 

