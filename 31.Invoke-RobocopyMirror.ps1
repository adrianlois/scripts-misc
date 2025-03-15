Function Invoke-RobocopyMirror {
    <#
        .DESCRIPTION
        Mirror file copy between a source and destination using Robocopy, a log will be created and only with the necessary parameters.

        .PARAMETER SourcePath
        Indicate the copy source path.

        .PARAMETER RemotePath
        Indicate the destination path where we want to perform the mirroring.

        .PARAMETER LogPath
        Indicate the path where the Robocopy process log will be stored.

        .EXAMPLE
        Invoke-RobocopyMirror -SourcePath "X:\Source\Path" -RemotePath "Y:\Remote\Path" -LogPath "Z:\Log\Path"

        .NOTES
        /MIR -> Create an exact mirror (synchronize changes).
        /R:3 -> Retries in case of failure.
        /W:5 -> Wait 5 seconds between retries.
        /MT:12 -> Use multiple threads (8 by default).
        /LOG:<PATH> -> Save output to a log file.
        /V -> Verbose output.
        /TEE -> Outputs to console and log, not needed when running in background.
        /COPYALL -> Copies all file information (equivalent to /copy:DATSOU).

        .LINK
        https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)][String]$SourcePath,
        [Parameter(Mandatory = $true)][String]$RemotePath,
        [Parameter(Mandatory = $true)][String]$LogPath
    )

    # Check if the path does not end with '\' and add it
    if (-not $LogPath.EndsWith('\')) {
        $LogPath += '\'
    }

    if ((Test-Path -Path $Source) -and (Test-Path -Path $Destination)) {
        $LogPath = $LogPath + "Backup_Robocopy_" + (Get-Date -Format "dd-MM-yyyy") + ".log"
        robocopy $SourcePath $RemotePath /MIR /R:3 /W:5 /MT:12 /LOG:$LogPath /V
    }
}