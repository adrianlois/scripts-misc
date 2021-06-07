$date = $(Get-Date -f MM-dd-yyyy)
$file = "name_file_" + $date + ".csv"
# otro forma para concatenar campos
# $file = [System.String]::Concat("name_file_","$fecha",".csv")
$file