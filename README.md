# get-sp-rp
Generate a report for a SharePoint Site for shared links in a Document library. Parameters are SiteUrl, ReportOutput, ListName, DestinationLibrary, LogFile, RemoveSharingFileAccess, and UsePreviousOutput. Uses PnP Modules for SharePoint. ReportOutput: csv file output : Name, RelativeURL, FileType, ShareLink, ShareLinkAccess, ShareLinkType, AllowsAnonymousAccess, IsActive, Expiration.

## Usage
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -DestinationLibrary "Your Destination Library"
```
Replace `"https://yoursharepointsite.com"` with the URL of your SharePoint site, `"C:\path\to\your\report.csv"` with the path where you want the report to be saved, `"Your List Name"` with the name of the list you want to get the shared links from, and `"Your Destination Library"` with the name of your destination library.

If you want to specify a log file, you can do so with the `-LogFile` parameter:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -LogFile "C:\path\to\your\log.txt"
```
If you want to remove sharing file access, you can do so with the `-RemoveSharingFileAccess` parameter:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -RemoveSharingFileAccess $false
```
If you want to use the previous output, you can do so with the `-UsePreviousOutput` parameter:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -UsePreviousOutput $true
```
Please note that you need to have the SharePoint PnP PowerShell module installed and you need to have access to the SharePoint site.


