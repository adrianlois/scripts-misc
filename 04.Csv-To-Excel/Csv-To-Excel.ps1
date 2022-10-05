# https://www.powershellgallery.com/packages/ImportExcel/7.5.0
# Install-Module -Name ImportExcel

Function Csv-To-Excel {
    param (
        [Parameter(Mandatory=$True)]
        [string]$CsvPath,
        [Parameter(Mandatory=$True)]
        [string]$XlsxFile
    )

    $CsvFiles = (Get-ChildItem -Path $CsvPath -Filter "*.csv").Name

    ForEach ($CsvFile in $CsvFiles) {

	$WorkSheetname = $CsvFile.Substring(0,$CsvFile.Length -4)

        Import-Csv -Path "$CsvPath\$CsvFile" | Export-Excel -Path "$XlsxFile" -WorkSheetname "$WorkSheetname" `
        -NoNumberConversion IPv4Address	-AutoSize -BoldTopRow -AutoFilter -ConditionalText $(
            New-ConditionalText True -BackgroundColor LightGreen -ConditionalTextColor DarkGreen
            New-ConditionalText False -BackgroundColor Yellow -ConditionalTextColor Red
        )
    }
}

Csv-To-Excel -CsvPath "C:\path_impot\csv_files" -XlsxFile "C:\path_export\output.xlsx"
