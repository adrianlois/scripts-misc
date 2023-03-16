Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster | Format-List
Get-ADDomain | Select-Object InfrastructureMaster, RIDMaster, PDCEmulator | Format-List