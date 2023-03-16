# Info: https://www.zonasystem.com/2018/12/transferir-roles-fsmo-windows-server-y-purgado-de-servicios-del-dominio.html

Get-ADDomain | Select-Object InfrastructureMaster, RIDMaster, PDCEmulator | Format-List
Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster | Format-List