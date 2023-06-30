<#
    .DESCRIPTION
    Recursively search a directory for a file extension 
    and display the absolute path of its locations in the output.
#>

function Search-ExtensionFiles {
    param (
        [Parameter(Mandatory=$True)]
        [string]$PathSearch,
        [Parameter(Mandatory=$True)]
        [string]$ExtFile
    )
    
    #$ExtFile = "java"
    #$PathSearch = "%USERPROFILE%\Desktop\Project"
    (Get-ChildItem -Path $PathSearch -Include *.$ExtFile -Recurse).DirectoryName | Select-Object -Unique
}

Search-ExtensionFiles -ExtFile "java" -PathSearch "%USERPROFILE%\Desktop\Project"