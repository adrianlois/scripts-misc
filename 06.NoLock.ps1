# Prevents computer lockup by simulating Ctrl key presses every 3 minutes

function NoLock {
	Write-Host "..."
	for (;;) {
		[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
		[System.Windows.Forms.SendKeys]::SendWait("^")
		Start-Sleep 180
	}
}
