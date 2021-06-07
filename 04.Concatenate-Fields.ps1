$date = $(Get-Date -f MM-dd-yyyy)
$file = "name_file_" + $date + ".csv"
# another way to concatenate fields
# $file = [System.String]::Concat("name_file_","$fecha",".csv")
$file