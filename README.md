# SharePoint Report Scripts

This repository contains two PowerShell scripts for generating a report and removing expired shared file links in a SharePoint Site. 

The initial script was inspired and referenced from this [SharePoint Diary article](https://www.sharepointdiary.com/2020/11/generate-shared-links-permission-report-in-sharepoint-online.html).

## get-sp-rp.ps1

This script generates a report for a SharePoint Site for shared links in a Document library. 

### Parameters

- `SiteUrl`: The URL of your SharePoint site.
- `SL`: The name of the list you want to get the shared links from.
- `InputFile`: (Optional) A file containing a list of files with an expiration date. If provided, the script will only process these files instead of running against all the documents in the document library. The ReportOutput can be used as InputFile.
- `ReportOutput`: (Optional) The name of your desired output report file. Defaults to "report.csv". This is the file where the report will be saved. The report includes the following fields:
  - `Name`: The name of the file.
  - `RelativeURL`: The relative URL of the file in the SharePoint site.
  - `FileType`: The type of the file (e.g., .docx, .xlsx, .pdf, etc.).
  - `ShareLink`: The shared link of the file.
  - `ShareLinkAccess`: The type of access provided by the shared link (e.g., Edit, Review, ViewOnly).
  - `ShareLinkType`: The kind of sharing link (e.g., anonymous access, organization access).
  - `AllowsAnonymousAccess`: A boolean value indicating whether the shared link allows anonymous access.
  - `IsActive`: A boolean value indicating whether the shared link is active.
  - `ExpirationDate`: The expiration date of the shared link.

### Usage

```powershell
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -SL "Source Document Library"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -SL "Source Document Library" -InputFile "myinputfile.txt"
.\get-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -SL "Source Document Library" -InputFile "myinputfile.txt" -ReportOutput "myreport.csv"
```

## set-sp-rp.ps1

This script removes expiration date from the shared file links in a SharePoint Site by moving the file into a new Destination library and then back into the Source Library. 

### Parameters

- `SiteUrl`: The URL of your SharePoint site.
- `SL`: The name of the list you want to remove the shared links from.
- `DL`: The name of your destination document library.
- `RemoveSharingFileAccess`: (Optional) A boolean value indicating whether to remove sharing file access. Defaults to false.

### Usage

```powershell
.\set-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -SL "Source Document Library" -DL "Destination Document Library"
.\set-sp-rp.ps1 -SiteUrl "https://yoursharepointsite.com" -SL "Source Document Library" -DL "Destination Document Library" -RemoveSharingFileAccess $true
```

## Requirements

These scripts require PowerShell version 7 and the SharePoint PnP module. Please ensure these are installed and available on your system before running the scripts.


