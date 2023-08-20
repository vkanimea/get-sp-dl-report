# get-sp-dl-report
Generate a report for a Sharepoint Site for expired sharelinks in a Document library. Parameters are SiteURL, ReportOutput, ListName {Document Library}, FolderName {Optional - Specify a folder}, RemoveSharing {Optional - Control whether to remove sharing}. Uses PnP Modules for Sharepoint. ReportOutput: csv file output : Name, RelativeURL, FileType, ShareLink, ShareLinkAccess, ShareLinkType, AllowsAnonymousAccess, IsActive, Expiration.

## Usage
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name"
```
Replace `"https://yoursharepointsite.com"` with the URL of your SharePoint site, `"C:\path\to\your\report.csv"` with the path where you want the report to be saved, and `"Your List Name"` with the name of the list you want to get the shared links from.

If you want to specify a log file, you can do so with the `-LogFile` parameter:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -LogFile "C:\path\to\your\log.txt"
```
If you want to remove sharing file access, you can do so with the `-RemoveSharingFileAccess` parameter:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -RemoveSharingFileAccess $false
```
If you want to specify a folder name, you can do so with the `-FolderName` parameter:
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ReportOutput "C:\path\to\your\report.csv" -ListName "Your List Name" -FolderName "Your Folder Name"
```
Please note that you need to have the SharePoint PnP PowerShell module installed and you need to have access to the SharePoint site.


