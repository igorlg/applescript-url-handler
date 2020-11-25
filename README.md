# Mac URL Handler

Small AppleScript (saved as an Application) to handle custom URL schemes and open the appropriate native App.
Created as a hack, based on daily pains :)

Comments, ideas, issues are welcome!

# Pre-requisites

This URL Handler script is intended to **augument** apps like [Choosy](https://choosyosx.com) or [Finicky](https://github.com/johnste/finicky), to handle URL-to-Native-App actions they don't support.

Please use one of these as the Default Browser in your Mac OS, and configure **them** to use _UrlToAppHandler_ to manage certain URLs.

# Usage

How to install this script? Simple:

1. Open [src/UrlToAppHandler.applescript](src/UrlToAppHandler.applescript) with "Script Editor"
2. Export the script as type "Application":
![Script Editor - Export as Application](doc/export-app.png)
3. Set `Applications/UrlToAppHandler.app` as the preferred browser in [Choosy](https://choosyosx.com) or [Finicky](https://github.com/johnste/finicky) for the URL schemes you wish it to handle.
