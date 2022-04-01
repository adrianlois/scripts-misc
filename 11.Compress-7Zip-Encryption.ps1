<# 
.DESCRIPTION
1. Install module 7zip4PowerShell
Install-Module -Name 7zip4PowerShell -Verbose

2. Create a file with the encrypted password
"MyPassword" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\PATH\Passwd7zKdbx"
"MyPassword" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\PATH\Passwd7zKeyx"
"MyPassword" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\PATH\PasswdBak7z"
#>

function Compress-7Zip-Encryption {
    param (
        [Parameter(Mandatory=$True)]
        [string]$PathKdbx,
        [Parameter(Mandatory=$True)]
        [string]$File7zKdbx,
        [Parameter(Mandatory=$True)]
        [string]$PathKeyx,
        [Parameter(Mandatory=$True)]
        [string]$File7zKeyx,
        [Parameter(Mandatory=$True)]
        [string]$PathBak7z,
        [Parameter(Mandatory=$True)]
        [string]$DestinationBak7z
	)

	$Passwd7zKdbx = Get-Content -Path "C:\PATH\Passwd7zKdbx" | ConvertTo-SecureString
	$Passwd7zKeyx = Get-Content -Path "C:\PATH\Passwd7zKeyx" | ConvertTo-SecureString
	$PasswdBak7z = Get-Content -Path "C:\PATH\PasswdBak7z" | ConvertTo-SecureString
	$PathTemp = "C:\PATH\Temp"

	Compress-7zip -Path $PathKdbx -ArchiveFileName $File7zKdbx -Format SevenZip -CompressionLevel Normal -CompressionMethod Deflate -SecurePassword $Passwd7zKdbx -EncryptFilenames
	Compress-7zip -Path $PathKeyx -ArchiveFileName $File7zKeyx -Format SevenZip -CompressionLevel Normal -CompressionMethod Deflate -SecurePassword $Passwd7zKeyx -EncryptFilenames
	Compress-7zip -Path $PathTemp -ArchiveFileName $PathBak7z -Format SevenZip -CompressionLevel Normal -CompressionMethod Deflate -SecurePassword $PasswdBak7z -EncryptFilenames
	Move-Item -Path $PathBak7z -Destination $DestinationBak7z -Force
	Remove-Item "$PathTemp\*.7z" -Force
}

Compress-7Zip-Encryption -PathKdbx "C:\PATH\db.kdbx" -File7zKdbx "C:\PATH\Temp\BakdbKdbx.7z" `
             -PathKeyx "C:\PATH\dbkey.keyx" -File7zKeyx "C:\PATH\Temp\BakdbKeyx.7z" `
             -PathBak7z "C:\PATH\Backup.7z" -DestinationBak7z "C:\PATH\Backup"
