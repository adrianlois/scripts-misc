<# 
Troubleshooting - Trust Relationship Between This Workstation And The Primary Domain Failed

Sometimes computers attached to the domain, due to inactivity or simply not maintaining a regular network connection with the domain, 
lose the trust relationship when AD object password synchronization fails. This causes the computers to be unable to communicate 
with the domain or access its resources.
#>

# This can be done graphically in dsa.msc. Right-click on the computer object and reset account.
# Or you can also do it from a remote console. After this action you need to delete and rejoin the remote client computer to the domain.
dsmod computer "CN=hostname1,CN=Computers,DC=domain,DC=local" -reset

# If we need to do this without having to remove and rejoin the remote client machine to the domain. We run this directly from the remote machine.
Reset-ComputerMachinePassword