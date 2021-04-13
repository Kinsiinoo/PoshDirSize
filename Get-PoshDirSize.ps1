# Variables
$PoshDSPath = ''
$DirTotalSize = $null
$FileTotalSize = $null
$PoshDSTotal = $null

[System.Collections.Generic.List[Object]]$FileList = @()
[System.Collections.Generic.List[Object]]$DirList = @()

# Functions
Function ConvertTo-FileSize {
    Param ([uint64]$Size)
    If ($Size -gt 1TB) {[string]::Format("{0,12:N1} TB", $Size / 1TB)}
    ElseIf ($Size -gt 1GB) {[string]::Format("{0,12:N1} GB", $Size / 1GB)}
    ElseIf ($Size -gt 1MB) {[string]::Format("{0,12:N1} MB", $Size / 1MB)}
    ElseIf ($Size -gt 1KB) {[string]::Format("{0,12:N1} kB", $Size / 1KB)}
    ElseIf ($Size -gt 0) {[string]::Format("{0,12:N1} B", $Size)}
    Else {"Size not readable or null!"}
}

function Add-ToFileList {
    param(
        [Parameter(Mandatory=$true)][System.IO.FileInfo]$file_item
    )

    $FullPath         = $null        
    $FileObject       = $null
    $FileSizeReadable = $null
    $FileSize         = $null
    $FileName         = $null

    $FullPath = $file_item.FullName
    $FileName = $file_item.BaseName

    $FileSizeReadable   = (ConvertTo-FileSize $file_item.Length)
    $FileSize           = $file_item.Length

    $FileObject = [PSCustomObject]@{
        PSTypeName    = 'PS.File.List.Result'
        FileName      = $FileName
        SizeReadable  = $FileSizeReadable  
        SizeInBytes   = $FileSize
        FullPath      = $FullPath
    }

    $FileList.Add($FileObject)
}

function Add-ToDirList {
    param(
        [Parameter(Mandatory=$true)][System.IO.DirectoryInfo]$folder_item,
        [Parameter(Mandatory=$true)][Double]$folder_item_bytes,
        [Parameter(Mandatory=$true)][String]$folder_item_size
    )

    $FullPath           = $null        
    $FolderObject       = $null
    $FolderSizeReadable = $null
    $FolderSize         = $null
    $FolderName         = $null

    $FullPath   = $folder_item.FullName
    $FolderName = $folder_item.BaseName

    $FolderSizeReadable   = $folder_item_size
    $FolderSize           = $folder_item_bytes

    $FolderObject = [PSCustomObject]@{
        PSTypeName       = 'PS.File.List.Result'
        FolderName       = $FolderName
        SizeReadable     = $FolderSizeReadable
        SizeInBytes      = $FolderSize
        FullPath         = $FullPath
    }

    $DirList.Add($FolderObject)
}
