$eventRdp = Get-WinEvent -ProviderName "Microsoft-Windows-RemoteDesktopServices-RdpCoreTS" | Where-Object {$_.Id -eq "131"} | Format-List | Select -First 3 | Out-String
$uriSlack = "<Webhook URI>"
$menssage = ConvertTo-Json @{ 
    text = $eventRdp
}
try {
    Invoke-RestMethod -uri $uriSlack -Method Post -body $menssage -ContentType 'application/json' | Out-Null
} catch {
    Write-Warning "Notification to Slack went wrong."
}