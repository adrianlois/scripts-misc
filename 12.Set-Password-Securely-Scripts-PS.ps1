<#
    Create a file with the encrypted password:
    One way to avoid typing a password in clear text in a ps1 script is to generate a file containing the AES256 hash corresponding to the encrypted password string. 
    This would be a more secure way to parameterize credentials or passwords without the need to display them in clear text and at all points maintain the confidentiality of the password in PowerShell script automation.
#>

# We generate the encrypted file with the password ("MyPassword")
"MyPassword" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "C:\PATH\PasswdFile"

# We set the rest of the variables and with $creds we authenticate in the service we need.
$passwdFile = "C:\PATH\PasswdFile"
$user = "user@mail.com"
$passwd = Get-Content $passwdFile | ConvertTo-SecureString
$creds = New-Object System.Management.Automation.PSCredential ($user, $passwd)
$creds