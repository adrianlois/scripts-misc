# Option 1 (PS)
Get-WmiObject -Class Win32_PNPEntity | Select-Object -Property PNPDeviceID, Caption, Service | Where-Object {$_.PNPDeviceID -like "USB*"}

# Option 2 (PS)
Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' } | Select-Object Name, Description, HardwareID | Format-List

# Option 1 (CMD)
wmic path win32_pnpentity where "Present='True' AND PNPClass='USB'" get Name,Description,HardwareID

# Option 2 (CMD)
pnputil /enum-devices /connected /class USB