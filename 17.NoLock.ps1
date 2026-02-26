<#
    .DESCRIPTION
	Alternatives to prevent computer session lockout every 3 minutes.
#>

# NoLock (the best option): move the mouse pointer by 1 screen pixel (0x0001 = MOUSEEVENTF_MOVE)
function NoLock {
    Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Mouse {
    [DllImport("user32.dll")]
    public static extern void mouse_event(int dwFlags, int dx, int dy, int dwData, int dwExtraInfo);
}
"@
    Write-Host "..."
    for (;;) {
        [Mouse]::mouse_event(0x0001, 1, 0, 0, 0)
        Start-Sleep -Seconds 180
    }
}

# NoLock: toggle the Scroll Lock key state
function NoLock {
    Write-Host "..."
    for (;;) {
        [System.Windows.Forms.SendKeys]::SendWait("{SCROLLLOCK}")
        Start-Sleep -Milliseconds 100
        [System.Windows.Forms.SendKeys]::SendWait("{SCROLLLOCK}")
        Start-Sleep -Seconds 180
    }
}

# NoLock: send a CTRL keystroke (alternatives: "^"=CTRL, "%"=ALT, "+"=SHIFT)
function NoLock {
	Write-Host "..."
	for (;;) {
		[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
		[System.Windows.Forms.SendKeys]::SendWait("^")
		Start-Sleep 180
	}
}