<#
    .DESCRIPTION
	This function for PowerShell acts as an equivalent of the Linux top command.
	Displays the first 40 CPU consuming processes in descending order.
#>

function top {
	while (1) { 
		Get-Process | Sort -Descending cpu | Select-Object -First 40; Start-Sleep -Seconds 2; Clear-Host; 
		Write-Host "Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName"; 
		Write-Host "-------  ------    -----      ----- -----   ------     -- -----------"
	}
}