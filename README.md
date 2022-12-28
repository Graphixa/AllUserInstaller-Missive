# Install Missive For All Users
A powershell script to install Missive Email Client for all users on Windows 10 or 11. Useful for organisations or enterprise environments to quickly roll out Missive for all machines in their inventory.

## About Missive
[Missive](www.missiveapp.com) is a great email client that manages to tie together a collaborative inbox experience with the chat like functionality of Slack.

![image](https://user-images.githubusercontent.com/2350960/209822715-f82c068e-c682-43b6-906a-68520f1b48b1.png)


## Why is this script important?
On Microsoft Windows 10 & 11, the Missive desktop app installs as a local application for the current user only, not for all users. This means in an enterprise or multi-user environment multiple users using the same machine will require Missive to be installed per user (not per machine. This can be frustrating to keep the latest version installed and available to all users, especially when they first login.

* This powershell script will first check if Windows has Missive installed and if not it will download a .JSON file that contains the latest version information and current download links for [Missive](www.missiveapp.com)

* Following initial checks, the latest version of Missive for Windows will be downloaded to a temporary folder on the system.

* The script will then install Missive silently using the /S argument and will force Missive to install to a local path accessible to all users using the /D="Install Path" argument. In the case of this script we use a generic 'Missive' folder located directly on the root of the system drive (i.e. C:\Missive\)

* Upon completion of the installation, (or script failure) the script will clean up any downloaded temporary files

## How to run this script?

To run this script on your system, you have a couple of options:

### Option 1 - Download from Github
* Download the "installMissive-AllUsers.ps1" script from here (https://github.com/Graphixa/AllUserInstaller-Missive/)
* Locate the downloaded script and right click the powershell script and run as administrator (there may be UAC prompts confirming the script is unknown).
* If you aren't able to run the powershell script, try option 2 below.

### Option 2 - Copy the Raw Code into Your Own Powershell Script
* Create a text document (.txt) on your system (doesn't matter where).
* Copy the raw code from the "installMissive-AllUsers.ps1" script here (https://github.com/Graphixa/AllUserInstaller-Missive/)
* Paste into your own text file and rename to "installMissive-AllUsers.ps1"
* Right click the file and run as administrator, accepting any UAC prompts.

By all means, feel free to fork this and improve this script!

