# Install Missive For All Users
A PowerShell script to install Missive Email Client for all users on Windows 10 or 11. Useful for organizations or enterprise environments to quickly roll out Missive for all machines in their inventory.

## About Missive
[Missive](https://www.missiveapp.com) is a great email client that manages to tie together a collaborative inbox experience with the chat like functionality of Slack.

![image](https://user-images.githubusercontent.com/2350960/209822715-f82c068e-c682-43b6-906a-68520f1b48b1.png)

## Why is this script important?
On Microsoft Windows 10 & 11, the Missive desktop app installs as a local application for the current user only, not for all users. This means in an enterprise or multi-user environment multiple users using the same machine will require Missive to be installed per user (not per machine). This can be frustrating to keep the latest version installed and available to all users, especially when they first login.

The script performs the following:
* Checks if Missive is already installed on the system
* Downloads the latest version of Missive directly from the official source
* Installs Missive silently using the `/S` argument
* Forces Missive to install to a local path accessible to all users using the `/D="Install Path"` argument (installs to `C:\Missive\` by default)
* Creates shortcuts in the public Start Menu and Desktop
* Cleans up any temporary files upon completion or failure

## How to install/run this script?

To run this script on your system, you have a couple of options:

### Option 1 - Run Command from PowerShell
* Open up an elevated terminal/PowerShell on your machine (must be running as administrator)
* Run the following code:
```powershell
irm "https://raw.githubusercontent.com/Graphixa/AllUserInstaller-Missive/main/Install-MissiveAllUsers.ps1" | iex
```

### Option 2 - Download .ps1 file from Github
* Download the "Install-MissiveAllUsers.ps1" script from [this repository](https://github.com/Graphixa/AllUserInstaller-Missive/)
* Locate the downloaded script, right-click the PowerShell script and run as administrator (there may be UAC prompts confirming the script is unknown)
* If you aren't able to run the PowerShell script, try option 3 below

### Option 3 - Copy the Raw Code into your own PowerShell Script
* Create a text document (.txt) on your system
* Copy the raw code from ["Install-MissiveAllUsers.ps1"](https://raw.githubusercontent.com/Graphixa/AllUserInstaller-Missive/main/Install-MissiveAllUsers.ps1)
* Paste into your own text file and rename to "Install-MissiveAllUsers.ps1"
* Right-click the file and run as administrator, accepting any UAC prompts


## Parameters
The script accepts a single optional parameter:
* `-InstallPath`: Specifies the installation path for Missive. Defaults to `C:\Missive\`
  
> [!IMPORTANT]  
> Just make sure that all users on the system have access to the specified path or they won't be able to update the app when a new version is released

Example:
```powershell
irm "https://raw.githubusercontent.com/Graphixa/AllUserInstaller-Missive/main/Install-MissiveAllUsers.ps1" -InstallPath "D:\Missive" | iex
```


## Requirements
* Windows 10 or 11
* PowerShell 5.1 or later
* Administrative privileges
* Internet connection

Feel free to fork this repository and improve this script!

