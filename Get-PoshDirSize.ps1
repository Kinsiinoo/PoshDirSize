# Variables
$PoshDSPath = ''
$DirTotalSize = $null
$FileTotalSize = $null
$PoshDSTotal = $null

[System.Collections.Generic.List[Object]]$FileList = @()

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
        [Parameter(Mandatory=$true)][System.IO.FileInfo]$ds_file_item
    )

    $FullPath         = $null        
    $FileObject       = $null
    $FileSizeReadable = $null
    $FileSize         = $null
    $FileName         = $null

    $FullPath = $ds_file_item.FullName
    $FileName = $ds_file_item.BaseName

    $FileSizeReadable   = (ConvertTo-FileSize $ds_file_item.Length)
    $FileSize           = $ds_file_item.Length

    $FileObject = [PSCustomObject]@{
        PSTypeName    = 'PS.File.List.Result'
        FileName      = $FileName
        SizeReadable  = $FileSizeReadable  
        SizeInBytes   = $FileSize
        FullPath      = $FullPath
    }

    $FileList.Add($FileObject)
}
