# Windows PowerShell Profiles
<table>
	<tbody>
		<tr>
			<td><strong>Profile Type</strong></td>
			<td><strong>Profile Path</strong></td>
		</tr>
		<tr>
			<td rowspan="2">Current user</td>
			<td>$PROFILE.CurrentUserCurrentHost o $PROFILE</td>
		</tr>
		<tr>
			<td><em>C:\Users\USERNAME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1</em></td>
		</tr>
		<tr>
			<td rowspan="2">All users</td>
			<td>$PROFILE.AllUsersCurrentHost</td>
		</tr>
		<tr>
			<td><em>C:\Windows\System32\WindowsPowerShell\v1.0\Microsoft.PowerShell_profile.ps1</em></td>
		</tr>
		<tr>
			<td rowspan="2">Current user, All hosts</td>
			<td>$PROFILE.CurrentUserAllHosts</td>
		</tr>
		<tr>
			<td><em>C:\Users\USERNAME\Documents\WindowsPowerShell\profile.ps1</em></td>
		</tr>
		<tr>
			<td rowspan="2">All users, All hosts</td>
			<td>$PROFILE.AllUsersAllHosts</td>
		</tr>
		<tr>
			<td><em>C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1</em></td>
		</tr>
	</tbody>
</table>

https://learn.microsoft.com/en-us/powershell/scripting/windows-powershell/ise/how-to-use-profiles-in-windows-powershell-ise?view=powershell-7.3#selecting-a-profile-to-use-in-the-windows-powershell-ise