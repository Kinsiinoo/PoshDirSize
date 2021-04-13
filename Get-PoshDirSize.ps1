# Variables
$PoshDSPath = ''
$DirTotalSize = $null
$FileTotalSize = $null
$PoshDSTotal = $null

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
