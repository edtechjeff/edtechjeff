# Intune Windows Defender Application Control

## Useful Links
* https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/appcontrol-wizard-create-base-policy
* https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/example-appcontrol-base-policies

# Warning, depending on what you are setting this could block out the device to the point where you might have to reset the device. BE CAREFUL

## Before you being
* Test group for deployment
* Test machine for deployment
* Reference machine for policy creation
* Add machine to test deployment group
* Download and install the App Control Wizard https://webapp-wdac-wizard.azurewebsites.net/
* Test Application (Putty will be example for this POC)

## Create Base Policy on reference machine
Launch the App Control Wizard and click on Policy Creator
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/Image1.png)

Click next and leave the defaults
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image2.png)

Here you have 3 options. My professional opinion is it goes from left to right most restrictive to least restrictive. I have worked with the different settings and I do feel like the Allow Microsoft Mode is a good place to start and go from there depending on your applications. These policies do have already built in allows that can make things easier.  Also in this link [here](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/app-control-for-business/design/example-appcontrol-base-policies) are some Microsoft pre-built policies to also try out. But for me I am going to build my own. Select the option you would like give the policy a location and name you would like to name it and click next.
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image3.png)

Here you will need to slide over Managed installer and also turn audit mode off. I would suggest Audit mode the first time just to cover yourself. Click Next
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image4.png)

Here you will see all the rules and also where you can add additional rules
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image5.png)

Click on Add Custom

![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image6.png)

For this example we are going to do a Rule Type of Publisher. In the links provided it details about the different types. I am going to open it up a little bit and only need the Issuing CA and Publisher to match. Click Next 
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image7.png)

Here is the result of what you just did, Click Next it will start to build the policy
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image8.png)

Final screen you can now close the wizard
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image9.png)

## Intune Policies
Switch into Intune console and go into Endpoint Security > App Control for Business
First thing you need to do is create an Managed Installer Policy. 
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image10.png)

This policy there is no configuration, click on Add and go through the prompts. Let if finish and when you are done it should be ready. Click on App Control for Business tab
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image11.png)

Click on Create Policy, give it a name and click next
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image12.png)

Expand out App Control for Business, leave the one drop down box set to Enter xml Data and then click on select file. 
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image13.png)

Browse to the policy you created and once you do the screen will look like this. Click Next, 
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image14.png)

Click next on Scope tags and assign to your group you want to apply this policy to and click next and then create

## Check your device
Currently I have the policy setup to block 
![image](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Assets/WDAC/image0.png)
