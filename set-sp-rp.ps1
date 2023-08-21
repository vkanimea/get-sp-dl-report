#Parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$SiteUrl,
    [Parameter(Mandatory=$true)]
    [string]$SL,
    [Parameter(Mandatory=$true)]
    [string]$DL,
    [Parameter(Mandatory=$false)]
    [bool]$RemoveSharingFileAccess = $false,
    [Parameter(Mandatory=$false)]
    [string]$InputFile,
    [Parameter(Mandatory=$false)]
    [string]$ReportOutput = "report.csv"
)

# Function to remove sharing file access
function RemoveSharingFileAccess($Item) {
    if ($Item.FileSystemObjectType -eq "File") {
        if ($Item.FieldValues["FileRef"] -ne $null -and $Item.FieldValues["FileRef"] -ne "") {
            $fileUrl = $Item.FieldValues["FileRef"]
            $fileName = $Item.FieldValues["FileLeafRef"]
            $destinationUrl = "$SiteUrl/$DestinationLibrary/$fileName"
            Copy-PnPFile -SourceUrl $fileUrl -TargetUrl $destinationUrl -Force
            Copy-PnPFile -SourceUrl $destinationUrl -TargetUrl $fileUrl -Force
        }
    }
}

# Rest of the code that calls RemoveSharingFileAccess and handles exceptions
#Parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$SiteUrl,
    [Parameter(Mandatory=$true)]
    [string]$SL,
    [Parameter(Mandatory=$true)]
    [string]$DL,
    [Parameter(Mandatory=$false)]
    [bool]$RemoveSharingFileAccess = $false,
    [Parameter(Mandatory=$false)]
    [string]$InputFile,
    [Parameter(Mandatory=$false)]
    [string]$ReportOutput = "report.csv"
)
    
try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -Interactive
    $Ctx = Get-PnPContext
    $Results = @()
    $global:counter = 0
          
    if ($InputFile) {
        # If an input file is provided, read the file and process only those items
        $ListItems = Import-Csv $InputFile | ForEach-Object {
            $file = Get-PnPFile -Url $_.RelativeURL -AsListItem
            Get-PnPListItem -List $file.ListItemAllFields.ParentList -Id $file.ListItemAllFields.Id -Fields "FileLeafRef", "FileRef", "File_x0020_Type"
        }
    } else {
        # If no input file is provided, fetch all items
        $ListItems = Get-PnPListItem -List $ListName -PageSize 2000 -Fields "FileLeafRef", "FileRef", "File_x0020_Type"
    }
    $ItemCount = $ListItems.Count
} catch [System.Net.WebException] {
    Write-Host "Network error: $_. Exception details: $($_.Exception)" | Out-File $LogFile -Append
    exit 1
} catch [System.Management.Automation.CommandNotFoundException] {
    Write-Host "Command not found: $_. Exception details: $($_.Exception)" | Out-File $LogFile -Append
    exit 1
} catch {
    Write-Host "An unknown error occurred: $_. Exception details: $($_.Exception)" | Out-File $LogFile -Append
    exit 1
}

   
# Function to collect data
function CollectData($Item, $ShareLink, $AccessType) {
    return New-Object PSObject -property $([ordered]@{
        Name  = $Item.FieldValues["FileLeafRef"]           
        RelativeURL = $Item.FieldValues["FileRef"]
        FileType = $Item.FieldValues["File_x0020_Type"]
        ShareLink  = $ShareLink.Url
        ShareLinkAccess  =  $AccessType
        ShareLinkType  = $ShareLink.LinkKind
        AllowsAnonymousAccess  = $ShareLink.AllowsAnonymousAccess
        IsActive  = $ShareLink.IsActive
        ExpirationDate = $ShareLink.Expiration
    })
}

# Removed the RemoveSharingFileAccess function

# Function to write progress
function WriteProgress($Item) {
    Write-Progress -PercentComplete ($global:Counter / ($ItemCount) * 100) -Activity "Getting Shared Links from '$($Item.FieldValues["FileRef"])'" -Status "Processing Items $global:Counter to $($ItemCount)";
}

#Iterate through each list item
try {
    ForEach($Item in $ListItems)
    {
        WriteProgress $Item
     
        #Check if the Item has unique permissions
        $HasUniquePermissions = Get-PnPProperty -ClientObject $Item -Property "HasUniqueRoleAssignments"
        If($HasUniquePermissions)
        {       
            #Get Shared Links
            $SharingInfo = [Microsoft.SharePoint.Client.ObjectSharingInformation]::GetObjectSharingInformation($Ctx, $Item, $false, $false, $false, $true, $true, $true, $true)
            $ctx.Load($SharingInfo)
            $ctx.ExecuteQuery()
                 
            #Iterate through each sharing link
            ForEach($ShareLink in $SharingInfo.SharingLinks)
            {
                If($ShareLink.Url)
                {           
                    #Determine the access type of the sharing link
                    If($ShareLink.IsEditLink)
                    {
                        $AccessType="Edit"
                    }
                    ElseIf($shareLink.IsReviewLink)
                    {
                        $AccessType="Review"
                    }
                    Else
                    {
                        $AccessType="ViewOnly"
                    }
                         
                    # Removed the call to RemoveSharingFileAccess function

                    #Call to RemoveSharingFileAccess function
                    if($RemoveSharingFileAccess) {
                        RemoveSharingFileAccess $Item
                    }

                    #Collect the data
                    $Results += CollectData $Item $ShareLink $AccessType
                }
            }
        }
        WriteProgress $Item
        $global:counter++
    }
    $Results | Export-CSV $ReportOutput -NoTypeInformation
    Write-host -f Green "Sharing Links Report Generated Successfully!"
} catch [System.Management.Automation.RuntimeException] {
    Write-Host "Runtime error while processing the items: $_" | Out-File $LogFile -Append
    exit 1
} catch {
    Write-Host "An unknown error occurred while processing the items: $_" | Out-File $LogFile -Append
    exit 1
}
