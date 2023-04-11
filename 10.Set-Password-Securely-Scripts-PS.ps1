<#
Create a file with the encrypted password:
One way to avoid securely typing a clear text password into a ps1 script is to generate a file containing the AES256 hash corresponding to the encrypted password string.
We generate the encrypted file with the password ("MyPassword")
#>

"MyPassword" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\PATH\PasswdFile"

$passwdFile = "C:\PATH\PasswdFile"
$user = "user@mail.com"
$passwd = Get-Content $passwdFile | ConvertTo-SecureString
$creds = New-Object System.Management.Automation.PSCredential ($user, $passwd)