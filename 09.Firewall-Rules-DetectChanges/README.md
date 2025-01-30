# Firewall Rules - Detect Changes

This script monitors changes in Windows firewall rules by comparing two files and generating a file with the detected changes. First, you need to export the baseline rules (FWRules_Baseline.csv) using the `Set-BaselineFirewallRules`. This baseline file serves as a reference for comparing the current rules (FWRules_Current.csv), which are checked during the script's scheduled daily execution.

`Compare-FirewallRules` compares the two files, identifying new or removed rules. If changes are detected, it creates a file (FWRules_Changes.txt) and sends both the file and a notification to a Telegram chatbot using the `Send-TelegramBotMessageAndFile`. If no changes are found, the script sends a message to the chatbot indicating that no changes were detected.

### Set-BaselineFirewallRules
Create the initial reference baseline file with the accepted and known rules "FWRules_Baseline.csv".
```ps
Set-BaselineFirewallRules -BaselineRulesPath "C:\PATH\FWRules_Baseline.csv"
```

### Compare-FirewallRules
Generates "FWRules_Current.csv", compares it with the baseline, and creates "FWRules_Changes.txt" if changes are detected. If the changes are legitimate, the file should be renamed to the new baseline file (FWRules_Baseline.csv); otherwise, the current rules file (FWRules_Current.csv) will be deleted, and a message will be written stating that "no changes were found".
```ps
Compare-FirewallRules -BaselineRulesPath "C:\PATH\FWRules_Baseline.csv" `
                      -CurrentRulesPath "C:\PATH\FWRules_Current.csv" `
					  -ChangesRulesPath "C:\PATH\FWRules_Changes.txt"
```

### Send-TelegramBotMessageAndFile
Send a message to the Telegram chatbot notifying of the existence or not of changes, in case it detects them it will also send as attachment the changes file “FWRules_Changes.txt”.
```ps
Send-TelegramBotMessageAndFile -BotToken "XXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" -ChatID "XXXXXXXXX"
```

### FW-Rules-DetectChanges-Trigger.bat
The script file to be called by a scheduled task is named "FW-Rules-DetectChanges.ps1".