Function Show-Menu {
    Clear-Host
    Write-Host "--- Menu ---"
    Write-Host "1. Search"
    Write-Host "2. Create"
    Write-Host "3. Delete"
    Write-Host "4. Exit"
}
 
Show-Menu
 
while(($input = Read-Host -Prompt "Select an option") -ne "4") {

    switch($input) {
            1 {
                Clear-Host
                Write-Host "--------------";
                Write-Host "Search account";
                Write-Host "--------------";
                pause;
                break
            }
            2 {
                Clear-Host
                Write-Host "--------------";
                Write-Host "Create account";
                Write-Host "--------------";
                pause; 
                break
            }
            3 {
                Clear-Host
                Write-Host "--------------";
                Write-Host "Remove account";
                Write-Host "--------------"; 
                pause;
                break
                }
            4 { "Exit" ; break }
            
            default { Write-Host -ForegroundColor red -BackgroundColor white "Invalid option. Please select another option" ; pause }

        }

    Show-Menu
}