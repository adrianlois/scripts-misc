# Create a reference baseline file for Firewall rules
Function Set-BaselineFirewallRules {
	[CmdletBinding()]
    Param (
        [String]$BaselineRulesPath
    )

    # 1. Export baseline reference rules for comparison
    Get-NetFirewallRule | Select-Object DisplayName, Enabled, Action, Direction, Profile  | `
	Export-Csv -Path $BaselineRulesPath -NoTypeInformation -Encoding UTF8
	
	<# 2. Other path complete but very expensive in performance
		Get-NetFirewallRule | Select-Object DisplayName, Enabled, Action, Direction, Profile, `
			@{Name='LocalPorts'; Expression={ (Get-NetFirewallPortFilter -AssociatedNetFirewallRule $_).LocalPort -join ", " }}, `
			@{Name='RemotePorts'; Expression={ (Get-NetFirewallPortFilter -AssociatedNetFirewallRule $_).RemotePort -join ", " }}, `
			@{Name='LocalAddresses'; Expression={ (Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $_).LocalAddress -join ", " }}, `
			@{Name='RemoteAddresses'; Expression={ (Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $_).RemoteAddress -join ", " }}, `
			@{Name='Program'; Expression={ (Get-NetFirewallApplicationFilter -AssociatedNetFirewallRule $_).Program -join ", " }}, `
			@{Name='Service'; Expression={ (Get-NetFirewallServiceFilter -AssociatedNetFirewallRule $_).Service -join ", " }} | `
		Export-Csv -Path $CurrentRulesPath -NoTypeInformation -Encoding UTF8
	#>
	<# 3. Other path complete but very expensive in performance
		$firewallRules = Get-NetFirewallRule | ForEach-Object -Parallel {
			$portFilter = Get-NetFirewallPortFilter -AssociatedNetFirewallRule $_
			$addressFilter = Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $_
			$programFilter = Get-NetFirewallApplicationFilter -AssociatedNetFirewallRule $_
			$serviceFilter = Get-NetFirewallServiceFilter -AssociatedNetFirewallRule $_

			[PSCustomObject]@{
				DisplayName     = $_.DisplayName
				Enabled         = $_.Enabled
				Action          = $_.Action
				Direction       = $_.Direction
				Profile         = $_.Profile
				LocalPorts      = ($portFilter.LocalPort -join ", ")
				RemotePorts     = ($portFilter.RemotePort -join ", ")
				LocalAddresses  = ($addressFilter.LocalAddress -join ", ")
				RemoteAddresses = ($addressFilter.RemoteAddress -join ", ")
				Program         = ($programFilter.Program -join ", ")
				Service         = ($serviceFilter.Service -join ", ")
			}
		} -ThrottleLimit 10
		$firewallRules | Export-Csv -Path $CurrentRulesPath -NoTypeInformation -Encoding UTF8
	#>
}

# Compare exported files of Firewall rules
Function Compare-FirewallRules {
    [CmdletBinding()]
    Param (
        [String]$BaselineRulesPath,
        [String]$CurrentRulesPath,
        [String]$ChangesRulesPath
    )

    $currentDate = $(Get-Date -Format 'dd/MM/yyyy - HH:mm')

    # Check and delete if a previous change file exists
    if (Test-Path -Path $ChangesRulesPath) {
        Remove-Item -Path $ChangesRulesPath -Force
    }

    # Check if there is an updated rules file from the last run, rename it as Baseline file and delete the outdated Baseline.    if (Test-Path -Path $CurrentRulesPath) {
    if (Test-Path -Path $CurrentRulesPath) {
        Remove-Item -Path $BaselineRulesPath -Force
		Rename-Item -Path $CurrentRulesPath -NewName $BaselineRulesPath
	}

    # Export current rules for comparison
    Get-NetFirewallRule | Select-Object DisplayName, Enabled, Action, Direction, Profile | `
	Export-Csv -Path $CurrentRulesPath -NoTypeInformation -Encoding UTF8

    # Load the two CSV files
    $baselineRules = Import-Csv -Path $BaselineRulesPath
    $currentRules = Import-Csv -Path $CurrentRulesPath

    # Compare the two CSV files and get the differences based on all properties
    $changes = Compare-Object -ReferenceObject $baselineRules -DifferenceObject $currentRules -Property DisplayName, Enabled, Action, Direction, Profile

    # Filter the lines that have changed
    $changedLines = $changes | Where-Object { $_.SideIndicator -ne "==" }

    # Initialize output variables for the message and file
    $Script:Message = ""
    $Script:FilePath = ""

    # If there are changes, process them and save them in the changes file
    if ($changedLines) {
        $changesFormatted = $changedLines | ForEach-Object {
            $side = if ($_.SideIndicator -eq "=>") { "[+]Added:" } else { "[-]Removed:" }
            "$side $($_.DisplayName), $($_.Enabled), $($_.Action), $($_.Direction), $($_.Profile)"
        }

        # Save the differences to the file
        $changesFormatted | Out-File -FilePath $ChangesRulesPath

        # Set message and file if changes exist
        $Script:Message = "$currentDate `n `u{274C} Changes have been found in the firewall rules."
        $Script:FilePath = $ChangesRulesPath
    } else {
        # Set message if there are no changes
        $Script:Message = "$currentDate `n `u{2705} No changes were found in the firewall rules."
        # Delete the current rules temporary file if no changes have been found
        Remove-Item -Path $CurrentRulesPath -Force
    }
}

# Send messages and files to a Telegram chatbot
Function Send-TelegramBotMessageAndFile {
    [CmdletBinding()]
    Param (
        [String]$BotToken,
        [String]$ChatID
    )

    # Send a message if $Script:Message has content
    if ($Script:Message) {
        $InvokeRestMethodSplat = @{
            Uri = 'https://api.telegram.org/bot{0}/sendMessage' -f $BotToken
            Form = @{
                chat_id = $ChatID
                text = $Script:Message
            }
            Method = 'Post'
            ErrorAction = 'Stop'
        }
        Invoke-RestMethod @InvokeRestMethodSplat
    }

    # Send a file if $Script:FilePath exists and is valid
    if ($Script:FilePath -and (Test-Path $Script:FilePath)) {
        $InvokeRestMethodSplat = @{
            Uri = 'https://api.telegram.org/bot{0}/sendDocument' -f $BotToken
            Form = @{
                chat_id = $ChatID
                document = [System.IO.FileInfo]$Script:FilePath
                # document = Get-Item -LiteralPath $Script:FilePath  # Alternative with System.IO.FileInfo
            }
            Method = 'Post'
            ErrorAction = 'Stop'
        }
        Invoke-RestMethod @InvokeRestMethodSplat
    }
}

Compare-FirewallRules -BaselineRulesPath "C:\PATH\FWRules_Baseline.csv" `
                      -CurrentRulesPath "C:\PATH\FWRules_Current.csv" `
					  -ChangesRulesPath "C:\PATH\FWRules_Changes.txt"
Send-TelegramBotMessageAndFile -BotToken "XXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" -ChatID "XXXXXXXXX"
# Set-BaselineFirewallRules -BaselineRulesPath "C:\PATH\FWRules_Baseline.csv"