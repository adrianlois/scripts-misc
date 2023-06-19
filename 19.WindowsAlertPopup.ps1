$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Operation completed",0,"Warning",0x0)
# Up to 7 types of windows can be used, indicating: 0x0, 0x1, 0x2, 0x3, 0x04, 0x5, 0x6, 0x7