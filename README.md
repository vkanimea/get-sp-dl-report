# get-sp-rp
Generate a report for a SharePoint Site for shared links in a Document library. Parameters are SiteUrl, ListName, DestinationLibrary, ReportOutput, RemoveSharingFileAccess, and InputFile. Uses PnP Modules for SharePoint. 

ReportOutput is a CSV file with the following fields:
- `Name`: The name of the file or item.
- `RelativeURL`: The URL of the file or item, relative to some base URL.
- `FileType`: The type of the file or item (e.g., .txt, .docx, .xlsx, etc.).
- `ShareLink`: A link to share the file or item.
- `ShareLinkAccess`: The access level of the share link (e.g., view only, edit, etc.).
- `ShareLinkType`: The type of share link (e.g., anyone with the link, people in your organization, etc.).
- `AllowsAnonymousAccess`: Whether the share link allows anonymous access.
- `IsActive`: Whether the file or item is active.
- `ExpirationDate`: The date when the share link expires.

## Requirements
This script requires PowerShell version 7 and the SharePoint PnP module. Please ensure these are installed and available on your system before running the script.

## Usage
```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -RemoveSharingFileAccess $true
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -RemoveSharingFileAccess $true -InputFile "myinputfile.txt"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -ListName "Your List Name" -DestinationLibrary "Your Destination Library" -RemoveSharingFileAccess $true -InputFile "myinputfile.txt" -ReportOutput "myreport.csv"
```
Replace `"https://yoursharepointsite.com"` with the URL of your SharePoint site, `"Your List Name"` with the name of the list you want to get the shared links from, and `"Your Destination Library"` with the name of your destination library. Replace `"myreport.csv"` and `"myinputfile.txt"` with your desired output report file and input file respectively.

The `-InputFile` parameter allows you to speed up the processing of the script the second time you run it, as it will only process the list of files with an expiration date instead of running against all the documents in the document library. This can be a significant time-saving factor if the document library contains many documents.

**Note:** The `-DestinationLibrary` parameter must be used with the `-RemoveSharingFileAccess` parameter.


