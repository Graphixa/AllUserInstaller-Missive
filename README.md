# All User Installer for MissiveApp

## About the script (Updated)
[Missive](www.missiveapp.com) is a great email client that manages to tie together a collaborative inbox experience with the chat like functionality of Slack.

## Why is this script important?
Missive on Windows specifically installs as a local application and won't install for all users, which means in an enterprise or multi-user environment this can be frustrating to keep the latest version installed and available to users when they first login.

* This powershell script will first check if Windows has Missive installed and if not it will download a .JSON file that contains the latest version information and current download links for [Missive](www.missiveapp.com)

* Following initial checks and download, the script will continue to install Missive silently for the current user.

* Upon completion of the installation, the script will clean up any downloaded temporary files

## How to isntall this script?

### Option 1 - Windows Startup Folder

Windows can't run powershell scripts from the Startup folder, so we need a batch script to run at startup to call in the powershell script

To install this script on your system, start by:

* Creating a new folder in the root directory of "C:\" and call it "temp" - It should look like this "C:\temp" 
* Next copy the installmissive.ps1 (powershell) script into this newly created folder at "C:\temp" 
* Lastly copy the startup.bat file to the  startup folder for all users at "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" - You'll need to edit this batch script if your system drive letter is not the default C:\ or you want to keep the powershell script in a different location on the drive
* At the next login, Windows will run the batch script which will call in the installmissive.ps1 powershell script


### Option 2 - Group Policy

Alternatively you can add the script through the Windows Group Policy Management Console (GPMC) or another group policy manager. I have tried this with limited success and option 1 tends to be more reliable, so long as no one moves or deletes the powershell script from the disk.
