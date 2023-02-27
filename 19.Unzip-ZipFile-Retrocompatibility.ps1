# If we use versions lower than PowerShell 5, we must use the assembly type "System.IO.Compression.FileSystem".
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = "C:\temp\file.zip"
$zipfile = [System.IO.Compression.ZipFile]::OpenRead($zip)

#View the contents of the zip file
$zipfile.Entries

# Unzip the zip file to a local directory
$unzipPath = "C:\temp\unzip"
[System.IO.Compression.ZipFile]::ExtractToDirectory($zip, $unzipPath)