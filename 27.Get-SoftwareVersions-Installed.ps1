# The fastest and most effective way to get a list of installed software and its versions on a computer on x86 and x64 architectures. In one line.

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | ? {![string]::IsNullOrWhiteSpace($_.DisplayName) } | Select-Object DisplayName, DisplayVersion

# Another alternative that is not as effective
Get-WmiObject -Class Win32_Product | Select-Object Name, Version