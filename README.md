# get-sp-rp
Generate a report for a SharePoint Site for shared links in a Document library. Parameters are SiteUrl, ListName, DestinationLibrary, ReportOutput, LogFile, RemoveSharingFileAccess, and UsePreviousOutput. Uses PnP Modules for SharePoint. ReportOutput: csv file output : Name, RelativeURL, FileType, ShareLink, ShareLinkAccess, ShareLinkType, AllowsAnonymousAccess, IsActive, Expiration.

## Requirements
This script requires PowerShell version 7 and the SharePoint PnP module. Please ensure these are installed and available on your system before running the script.

## Usage
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -RemoveSharingFileAccess $true
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -ReportOutput "myreport.csv"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -LogFile "mylog.txt"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -UsePreviousOutput $true
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -InputFile "myinputfile.txt"
```
Replace `"https://yoursharepointsite.com"` with the URL of your SharePoint site, `"Your List Name"` with the name of the list you want to get the shared links from, and `"Your Destination Library"` with the name of your destination library. Replace `"myreport.csv"`, `"mylog.txt"`, and `"myinputfile.txt"` with your desired output report file, log file, and input file respectively.

Please note that you need to have the SharePoint PnP PowerShell module installed and you need to have access to the SharePoint site.

**Note:** The `-DestinationLibrary` parameter must be used with the `-RemoveSharingFileAccess` parameter.


