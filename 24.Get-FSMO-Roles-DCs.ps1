# Info: https://www.zonasystem.com/2018/12/transferir-roles-fsmo-windows-server-y-purgado-de-servicios-del-dominio.html

Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster | Format-List
Get-ADDomain | Select-Object InfrastructureMaster, RIDMaster, PDCEmulator | Format-List