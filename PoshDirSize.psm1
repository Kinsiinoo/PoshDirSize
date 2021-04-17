function Get-PoshDirSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,
        HelpMessage="Enter the path to the folder you want to check.")]
        [String]$PoshDSPath,
        [Parameter(Position=1)]
        [ValidateSet("Fast", "Slow")]
        [String]$PoshDSMode = "Fast"
    )

    # Variables
    $PoshDSOutPath = "C:\Temp\PoshDirSize\"
    $PoshDSTotal = $null
    $PoshDSRunTime = (Get-Date).ToString('yyyy-MM-dd-HH-mm-ss')

    [System.Collections.Generic.List[Object]]$FileList = @()
    [System.Collections.Generic.List[Object]]$DirList = @()

    # SW start
    $PoshDSSW = [Diagnostics.Stopwatch]::StartNew()

    Write-Verbose "Getting files and folders..."
    $File_Items = Get-ChildItem ([Management.Automation.WildcardPattern]::Escape($PoshDSPath)) -File -Recurse
    $Dir_Items = Get-ChildItem ([Management.Automation.WildcardPattern]::Escape($PoshDSPath)) -Directory -Recurse

    # Functions
    Function ConvertTo-FileSize {
        Param ([uint64]$Size)
        If ($Size -gt 1TB) {[string]::Format("{0,9:N2} TB", $Size / 1TB)}
        ElseIf ($Size -gt 1GB) {[string]::Format("{0,9:N2} GB", $Size / 1GB)}
        ElseIf ($Size -gt 1MB) {[string]::Format("{0,9:N2} MB", $Size / 1MB)}
        ElseIf ($Size -gt 1KB) {[string]::Format("{0,9:N2} KB", $Size / 1KB)}
        ElseIf ($Size -gt 0) {[string]::Format("{0,9:N2} B", $Size)}
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

    switch ($PoshDSMode) {
        "Fast" {
            Write-Verbose "Mode: Fast"
            # Dir_Item -> DirList
            foreach($Dir_Item in $Dir_Items){
                $Dir_ChildItems = Get-ChildItem ([Management.Automation.WildcardPattern]::Escape($Dir_Item.FullName)) -Recurse
                $Dir_Bytes = ($Dir_ChildItems | Measure-Object -Property Length -sum).Sum
                $Dir_Size = (ConvertTo-FileSize $Dir_Bytes)
                Add-ToDirList $Dir_Item $Dir_Bytes $Dir_Size
            }

            # File_Item -> FileList
            foreach($File_Item in $File_Items){
                $PoshDSTotal += $File_Item.Length
                Add-ToFileList $File_Item
            }
        }
        "Slow" {
            Write-Verbose "Mode: Slow"
            # Dir_Item -> DirList
            $Dir_Items | ForEach-Object {
                $Dir_ChildItems = Get-ChildItem ([Management.Automation.WildcardPattern]::Escape($_.FullName)) -Recurse
                $Dir_Bytes = ($Dir_ChildItems | Measure-Object -Property Length -sum).Sum
                $Dir_Size = (ConvertTo-FileSize $Dir_Bytes)
                Add-ToDirList $_ $Dir_Bytes $Dir_Size
            }

            # File_Item -> FileList
            $File_Items | ForEach-Object {
                $PoshDSTotal += $_.Length
                Add-ToFileList $_
            }
        }
    }

    # Test Path and Create folder if it is not exist
    If(!(Test-Path -Path $PoshDSOutPath)){
        New-Item -ItemType Directory -Force -Path $PoshDSOutPath
    }

    # DirList output to console and .log
    Write-Verbose "Outputting DirList to console and .log file..."
    $DirList | Sort-Object -Property SizeInBytes -Descending | Select-Object -Property FolderName, SizeReadable, SizeInBytes | Format-Table -AutoSize
    $DirList | Sort-Object -Property SizeInBytes -Descending | Out-File -FilePath "$($PoshDSOutPath)\PoshDirSize_$($PoshDSRunTime).log" -Encoding utf8 -Append -Width 1000

    # FileList output to console and .log
    Write-Verbose "Outputting FileList to console and .log file..."
    $FileList | Sort-Object -Property SizeInBytes -Descending | Select-Object -Property FileName, SizeReadable, SizeInBytes | Format-Table -AutoSize
    $FileList | Sort-Object -Property SizeInBytes -Descending | Out-File -FilePath "$($PoshDSOutPath)\PoshDirSize_$($PoshDSRunTime).log" -Encoding utf8 -Append -Width 1000

    # SW stop
    $PoshDSSW.Stop()

    # Path, Mode, Grand Total, Elapsed time output to console and .log
    Write-Verbose "Outputting Path, Mode, Grand Total, Elapsed time to console and .log file..."
    Write-Host "`nPath: " -NoNewline -ForegroundColor Cyan
    ([Management.Automation.WildcardPattern]::Escape($PoshDSPath))

    Write-Host "Mode: " -NoNewline -ForegroundColor Cyan
    $PoshDSMode

    Write-Host "Grand Total: " -NoNewline -ForegroundColor Yellow
    ConvertTo-FileSize $PoshDSTotal

    Write-Host "Elapsed time: " -NoNewline -ForegroundColor Magenta
    Write-Host "$($PoshDSSW.Elapsed.Hours):$($PoshDSSW.Elapsed.Minutes):$($PoshDSSW.Elapsed.Seconds).$($PoshDSSW.Elapsed.Milliseconds)"

    "Path: $(([Management.Automation.WildcardPattern]::Escape($PoshDSPath)))`nMode: $($PoshDSMode)`nGrand Total: $(ConvertTo-FileSize $PoshDSTotal)`nElapsed time: $($PoshDSSW.Elapsed.Hours):$($PoshDSSW.Elapsed.Minutes):$($PoshDSSW.Elapsed.Seconds).$($PoshDSSW.Elapsed.Milliseconds)" | Out-File -FilePath "$($PoshDSOutPath)\PoshDirSize_$($PoshDSRunTime).log" -Encoding utf8 -Append -Width 1000
    Write-Verbose "Completed!"
}
