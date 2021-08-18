# missive-downloader

## About the script
[Missive](www.missiveapp.com) is a great email client that manages to tie together a collaborative inbox experience with the chat like functionality of Slack.

## Why is this script important?
Missive on Windows specifically installs as a local application and won't install for all users, which means in a business or multi-user environment this can be frustrating to keep the latest version installed and available to users when they first login.

* This powershell script will first check if Windows has Missive installed and if not it will download a .JSON file that contains the latest version information and current download links for [Missive](www.missiveapp.com)

* Following initial checks and download, the script will continue to install Missive silently for the current user.

* Upon completion of the installation, the script will clean up any downloaded temporary files.s
