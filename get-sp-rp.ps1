#Parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$SiteUrl,
    [Parameter(Mandatory=$true)]
    [string]$ReportOutput,
    [Parameter(Mandatory=$true)]
    [string]$ListName,
    [Parameter(Mandatory=$false)]
    [string]$LogFile = "log.txt"
)
    
try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -UseWebLogin
    $Ctx = Get-PnPContext
    $Results = @()
    $global:counter = 0
      
    #Get all list items in batches
    #Only fetch the fields we need to improve performance
    $ListItems = Get-PnPListItem -List $ListName -PageSize 2000 -Fields "FileLeafRef", "FileRef", "File_x0020_Type"
    $ItemCount = $ListItems.Count
} catch [System.Net.WebException] {
    Write-Host "Network error: $_" | Out-File $LogFile -Append
    exit 1
} catch [System.Management.Automation.CommandNotFoundException] {
    Write-Host "Command not found: $_" | Out-File $LogFile -Append
    exit 1
} catch {
    Write-Host "An unknown error occurred: $_" | Out-File $LogFile -Append
    exit 1
}

#Iterate through each list item
try {
    ForEach($Item in $ListItems)
    {
        #Processing code goes here...
    }
} catch [System.Management.Automation.RuntimeException] {
    Write-Host "Runtime error while processing the items: $_" | Out-File $LogFile -Append
    exit 1
} catch {
    Write-Host "An unknown error occurred while processing the items: $_" | Out-File $LogFile -Append
    exit 1
}
   
#Iterate through each list item
ForEach($Item in $ListItems)
{
    Write-Progress -PercentComplete ($global:Counter / ($ItemCount) * 100) -Activity "Getting Shared Links from '$($Item.FieldValues["FileRef"])'" -Status "Processing Items $global:Counter to $($ItemCount)";
 
    #Check if the Item has unique permissions
    $HasUniquePermissions = Get-PnPProperty -ClientObject $Item -Property "HasUniqueRoleAssignments"
    If($HasUniquePermissions)
    {       
        #Get Shared Links
        $SharingInfo = [Microsoft.SharePoint.Client.ObjectSharingInformation]::GetObjectSharingInformation($Ctx, $Item, $false, $false, $false, $true, $true, $true, $true)
        $ctx.Load($SharingInfo)
        $ctx.ExecuteQuery()
         
        ForEach($ShareLink in $SharingInfo.SharingLinks)
        {
            If($ShareLink.Url)
            {           
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
                 
                #Check if the item is a file or a folder
                if ($Item.FileSystemObjectType -eq "File") {
                    #Clear the sharing link for a file
                    Remove-PnPFileSharingLink -Url $Item.FieldValues["FileRef"]
                } elseif ($Item.FileSystemObjectType -eq "Folder") {
                    #Clear the sharing link for a folder
                    Remove-PnPFolderSharingLink -Url $Item.FieldValues["FileRef"]
                }

                #Collect the data
                $Results += New-Object PSObject -property $([ordered]@{
                Name  = $Item.FieldValues["FileLeafRef"]           
                RelativeURL = $Item.FieldValues["FileRef"]
                FileType = $Item.FieldValues["File_x0020_Type"]
                ShareLink  = $ShareLink.Url
                ShareLinkAccess  =  $AccessType
                ShareLinkType  = $ShareLink.LinkKind
                AllowsAnonymousAccess  = $ShareLink.AllowsAnonymousAccess
                IsActive  = $ShareLink.IsActive
                })
            }
        }
    }
    Write-Progress -PercentComplete ($global:Counter / ($ItemCount) * 100) -Activity "Getting Shared Links from '$($Item.FieldValues["FileRef"])'" -Status "Processing Items $global:Counter to $($ItemCount)";
    $global:counter++
}
$Results | Export-CSV $ReportOutput -NoTypeInformation
Write-host -f Green "Sharing Links Report Generated Successfully!"
