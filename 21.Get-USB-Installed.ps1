Get-WmiObject -Class Win32_PNPEntity | `
Select-Object -Property PNPDeviceID, Caption, Service | `
Where-Object {$_.PNPDeviceID -like "USB*"}