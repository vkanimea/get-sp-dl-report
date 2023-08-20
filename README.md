# get-sp-rp
Generate a report for a SharePoint Site for shared links in a Document library. Parameters are SiteUrl, ListName, DestinationLibrary, ReportOutput, LogFile, RemoveSharingFileAccess, and UsePreviousOutput. Uses PnP Modules for SharePoint. ReportOutput: csv file output : Name, RelativeURL, FileType, ShareLink, ShareLinkAccess, ShareLinkType, AllowsAnonymousAccess, IsActive, Expiration.

## Requirements
This script requires PowerShell version 7 and the SharePoint PnP module. Please ensure these are installed and available on your system before running the script.

## Usage
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name"
```
Replace `"https://yoursharepointsite.com"` with the URL of your SharePoint site and `"Your List Name"` with the name of the list you want to get the shared links from.

If you want to remove sharing file access and specify a destination library, you can do so with the `-RemoveSharingFileAccess` and `-DestinationLibrary` parameters:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -RemoveSharingFileAccess $true -DestinationLibrary "Your Destination Library"
```
Replace `"Your Destination Library"` with the name of your destination library.

By default, the script logs to a default file and outputs a report to a default location. If you want to change these defaults, you can do so with the `-LogFile` and `-ReportOutput` parameters.

If you want to use the previous output, you can do so with the `-UsePreviousOutput` and `-InputFile` parameters:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -UsePreviousOutput $true -InputFile "Your Input File"
```
Replace `"Your Input File"` with the path to your input file.
Please note that you need to have the SharePoint PnP PowerShell module installed and you need to have access to the SharePoint site.


