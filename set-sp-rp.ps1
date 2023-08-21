#Parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$SiteUrl,
    [Parameter(Mandatory=$true)]
    [string]$ListName,
    [Parameter(Mandatory=$true)]
    [string]$DestinationLibrary,
    [Parameter(Mandatory=$false)]
    [bool]$RemoveSharingFileAccess = $false
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
