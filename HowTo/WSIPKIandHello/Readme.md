1️⃣ Prerequisites
✅ Microsoft Entra ID P1 or P2 (CBA requires at least Entra ID P1)
✅ Intune for certificate deployment
✅ Public Key Infrastructure (PKI) or a cloud-based CA (to issue certificates)
✅ Windows 10/11 devices joined to Entra ID

2️⃣ Enable Entra ID CBA
- Go to Microsoft Entra Admin Center
- Navigate to Microsoft Entra ID
- Go to Protection > Authentication Methods
- Select Certificate-Based Authentication
- Enable CBA for all users or a specific group
- Choose Issuer-based Rules and define allowed certificate authorities

3️⃣ Deploy Certificates via Intune
- Since you're cloud-only, you'll use Intune SCEP (Simple Certificate Enrollment Protocol) or PKCS to issue and manage certificates.

# Option 1: Use a Cloud CA (Recommended)
- Third-party solutions like Microsoft Cloud PKI, Entrust, or DigiCert allow cloud certificate issuance.
- No on-prem servers needed.
# Option 2: Use Intune SCEP with a PKI
- If you have a PKI in Azure or a hybrid cloud CA, use Intune to deploy certificates.
- Requires configuring an Intune SCEP certificate connector on a Windows VM.

4️⃣ Configure Windows Hello for Business (WHfB)
- Go to Intune Admin Center

- Navigate to Devices > Windows > Configuration Profiles
- Click Create profile → Windows 10 and later
- Select Identity Protection
- Enable Windows Hello for Business
- Select Certificate-based authentication
- Deploy the policy to your users

5️⃣ Test the Setup
- Enroll a test user into WHfB.
- Ensure the issued certificate is stored in the device’s user certificate store.
- Try signing in using PIN or biometrics and verify CBA authentication in Entra Sign-in Logs.
# Next Steps
- Do you want help setting up Intune certificate deployment, or do you already have a cloud-based CA ready?


# How to setup the microsoft PKI
## Setting Up Microsoft Cloud PKI for Windows Hello for Business (WHfB) with CBA
## Microsoft Cloud PKI is a cloud-based certificate authority that integrates with Intune to issue and manage certificates without an on-premises PKI. Here's how to set it up for Windows Hello for Business (WHfB) with Certificate-Based Authentication (CBA).

1️⃣ Prerequisites
✅ Microsoft Entra ID P1 or P2 (for CBA)
✅ Microsoft Intune (to deploy certificates)
✅ Windows 10/11 devices joined to Entra ID

2️⃣ Enable Microsoft Cloud PKI in Intune
- Go to Microsoft Intune Admin Center

- Navigate to Microsoft Intune
- Go to Tenant Administration > Cloud PKI (Preview)
- Click Create a Root CA
- Provide a name (e.g., "MyOrg Cloud Root CA")
- Click Create
- Create an Issuing CA

- Click Create an Issuing CA
- Link it to the Root CA
- Click Create

3️⃣ Configure Intune Certificate Profiles
- You’ll create two certificate profiles in Intune:

- Root CA Profile (delivers the root certificate to devices)
- SCEP Certificate Profile (issues user certificates for authentication)
- Step 1: Deploy the Root CA Profile
- Go to Intune Admin Center
- Devices > Configuration Profiles
- Click Create Profile
- Platform: Windows 10 and later
- Profile Type: Trusted Certificate
- Select the Root CA from Cloud PKI
- Assign to users/devices
# Step 2: Configure the SCEP Profile for User Certificates
- Go to Intune Admin Center
- Devices > Configuration Profiles
- Click Create Profile
- Platform: Windows 10 and later
- Profile Type: SCEP Certificate
- Configure the SCEP settings:
- Certificate Type: User
- Subject Name Format: CN={{UserPrincipalName}}
- Certification Authority: Select Cloud PKI Issuing CA
- Extended Key Usage (EKU): Client Authentication (1.3.6.1.5.5.7.3.2)
- Assign to users/devices

4️⃣ Enable Certificate-Based Authentication (CBA) in Entra ID
- Go to Microsoft Entra Admin Center
- Protection > Authentication Methods > Certificate-Based Authentication
- Enable CBA
- Configure Issuer-Based Rules
- Add the Root CA from Cloud PKI
- Choose authentication policies (e.g., allow all users or specific groups)

5️⃣ Configure Windows Hello for Business (WHfB) with CBA
- Go to Intune Admin Center
- Devices > Configuration Profiles
- Click Create Profile
- Platform: Windows 10 and later
- Profile Type: Identity Protection
- Enable Windows Hello for Business
- Set authentication to CBA
- Assign to users/devices

6️⃣ Test and Verify
- Enroll a test user into WHfB
- Ensure the certificate is issued and stored in the user's certificate store
- Check Entra Sign-in Logs for CBA authentication events
- Sign in using PIN or biometrics and confirm CBA authentication