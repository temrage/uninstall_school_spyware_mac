<p align="center">
  <img src="https://i.imgur.com/ec0RaHP.png" width="20%" alt="UNINSTALL_SCHOOL_SPYWARE-logo">
</p>

# 🛡️ **Uninstall School Spyware**
![License](https://img.shields.io/github/license/temrage/uninstall_school_spyware_mac?style=flat&logo=opensourceinitiative&logoColor=white&color=0080ff)
![Last Commit](https://img.shields.io/github/last-commit/temrage/uninstall_school_spyware_mac?style=flat&logo=git&logoColor=white&color=0080ff)

---

## 🚨 Overview

This guide is for **Mac OS** users who wish to remove school-installed spyware, such as **Securly** and **MDM** (Mobile Device Management).

---

## Steps

### 1. **Stop Using Chrome with Your School's Profile**
   - **Stop using Chrome** with your school profile. Instead, use **Brave** or **Firefox**, and create a dedicated school profile for school use only.
   - **Why?** The school's Chrome profile forces the **Securly** extension to load, sending all your browsing history to Google and the school.
   - **Important:** If you skip this step, the school can still track you at the browser level.

### 2. **Removing Securly**

   #### Open Network Settings
   - Go to **System Preferences > Network**.

   #### Edit Connection Settings
   - Select your active connection (e.g., **Wi-Fi** or **Ethernet**).
   - Click on the **Details** or **Advanced** button.

   #### Modify Proxy Settings
   - In the pop-up window, go to the **Proxies** tab.
   - Find the proxy that is enabled (such as **HTTP**, **HTTPS**, or **SOCKS**).
   - Remove any URLs or IP addresses listed in the proxy configuration file.
   - Disable the proxy toggle by unchecking it.

   #### Save Changes
   - Click **OK** and then **Apply** to save your changes.

   #### Remove Securly Certificate
   - Open **Launchpad > Other > Keychain Access**.
   - Select **System** in the Keychain Access sidebar.
   - Look for a certificate named “`.securly.com`.”
   - Right-click on the certificate and click the minus button to remove it.

### 3. **Removing MDM (Mobile Device Management)**

   #### Open Profiles
   - Go to **System Preferences > Profiles**.
   - Find and select the **MDM profile** listed here, then click **Remove**.

   #### Delete MDM Agent Files
   - Open **Finder**.
   - In the menu bar, click **Go > Computer**.
   - Open your main drive (usually called **Macintosh HD**).
   - Go to the folder `/Library/ManageEngine`.

   #### Move to Trash
   - Right-click on the `UEMS_Agent` folder and select **Move to Trash**.
   - Right-click on the Trash icon in your dock and select **Empty Trash**.

   #### Restart Your Mac
   - In the menu bar, click the **Apple logo** and select **Restart** (not **Shut Down**).
   - Turn your Mac back on to complete the process.
> ❗ **Troubleshooting Tips**  
> - If you get an HTTPS error (such as "Your connection is not private"), follow the instructions on the [SSL Inspection repo](https://github.com/temrage/school_ssl_inspection) to resolve the issue. 
