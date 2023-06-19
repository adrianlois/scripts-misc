# Get NTP Server configured
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters > REG_SZ: NtpServer

#Net time command has been deprecated. You must use w32tm
# PDC - Principal Domain controller (This synchronizes with Microsoft Online NTP Server)
w32tm /config /manualpeerlist:time.windows.com

# Any Domain Controller other than the PDC (This synchronizes other domain controllers with the PDC)
w32tm /config /syncfromflags:domhier

# Configured the above, we apply synchronization
w32tm /resync