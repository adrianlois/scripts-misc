## Get ACL for Files and Folders
```ps
Get-Acl -Path "\\shared\test" | Select-Object -Expand Access | Format-Table IdentityReference,FileSystemRights,AccessControlType
```
Other path:
```ps
(Get-Acl -Path "\\shared\test").Access | Select-Object IdentityReference,FileSystemRights,AccessControlType
```

## Copy File and Folder Permissions
```ps
Get-Acl \\shared\test | Set-Acl \\shared\test2
```

## Set File and Folder Permissions
```ps
$acl = Get-Acl -Path \\shared\test
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("ENTERPRISE\UserTest","FullControl","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl -Path \\shared\test
```

## Remove User Permissions
```ps
$acl = Get-Acl -Path \\shared\test
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("ENTERPRISE\UserTest","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl -Path \\shared\test
```

## Disable or Enable Permissions Inheritance
**SetAccessRuleProtection**
- The first parameter is responsible for blocking inheritance from the parent folder. It has two states: "$true" and "$false".
- The second parameter determines whether the current inherited permissions are retained or removed. It has the same two states: "$true" and "$false".
```ps
$acl = Get-Acl -Path \\shared\test
$acl.SetAccessRuleProtection($True,$False)
$acl | Set-Acl -Path \\shared\test
```

## Change File and Folder Ownership
```ps
$acl = Get-Acl -Path \\shared\test
$object = New-Object System.Security.Principal.Ntaccount("ENTERPRISE\UserTest")
$acl.SetOwner($object)
$acl | Set-Acl -Path \\shared\test
```

## Get all ACE permissions available in PS
```ps
[system.Enum]::GetNames([System.Security.AccessControl.FileSystemRights])
```

| Access Right                   | Access Right's Name in Powershell |
|--------------------------------|-----------------------------------|
| Full Control                   | FullControl                       |
| Traverse Folder / Execute File | ExecuteFile                       |
| List Folder / Read Data        | ReadData                          |
| Read Aributes                  | ReadAttributes                    |
| Read Extended Attributes       | ReadExtendedAttributes            |
| Create Files / Write Data      | CreateFiles                       |
| Create Folders / Append Data   | AppendData                        |
| Write Attributes               | WriteAttributes                   |
| Write Extended Attributes      | WriteExtendedAttributes           |
| Delete Subfolders and Files    | DeletesubdirectoriesAndFiles      |
| Delete                         | Delete                            |
| Read Permissions               | ReadPermissions                   |

| Access Rights Set | Rights Included in the Set     | Name of the Set in Powershell |
|-------------------|--------------------------------|-------------------------------|
| Read              | List Folder / Read Data        | Read                          |
|                   | Read Attributes                |                               |
|                   | Read Extended Attributes       |                               |
|                   | Read Permissions               |                               |
| Write             | Create Files / Write Data      | Write                         |
|                   | Create Folders / Append Data   |                               |
|                   | Write Attributes               |                               |
|                   | Write Extended Attributes      |                               |
| Read and Execute  | Traverse folder / Execute File | ReadAndExecute                |
|                   | ReadAndExecute                 |                               |
|                   | List Folder / Read Data        |                               |
|                   | Read Attributes                |                               |
|                   | Read Extended Attributes       |                               |
|                   | Read Permissions               |                               |
| Modify            | Traverse folder / Execute File | Modify                        |
|                   | List Folder / Read Data        |                               |
|                   | Read Attributes                |                               |
|                   | Read Extended Attributes       |                               |
|                   | Create Files / Write Data      |                               |
|                   | Create Folders / Append Data   |                               |
|                   | Write Attributes               |                               |
|                   | Write Extended Attributes      |                               |
|                   | Delete                         |                               |
|                   | Read Permissions               |                               |

### Basic Permissions:

- **Full Control**: Users can modify, add, move and delete files and directories, as well as their associated properties. In addition, users can change permissions settings for all files and subdirectories.
- **Modify**: Users can view and modify files and file properties, including deleting and adding files to a directory or file properties to a file.
- **Read & Execute**: Users can run executable files, including script
- **Read**: Users can view files, file properties and directories.
- **Write**: Users can write to a file and add files to directories.

### Advanced Permissions:

- **Traverse Folder/Execute File**: Users can navigate through folders to reach other files or folders, even if they have no permissions for these files or folders. Users can also run executable files. The Traverse Folder permission takes effect only when the group or user doesn't have the "Bypass Traverse Checking" right in the Group Policy snap-in.

- **List Folder/Read Data**: Users can view a list of files and subfolders within the folder as well as the content of the files.

- **Read Attributes**: Users can view the attributes of a file or folder, such as whether it is read-only or hidden.

- **Write Attributes**: Users can change the attributes of a file or folder.

- **Read Extended Attributes**: Users can view the extended attributes of a file or folder, such as permissions and creation and modification times.

- **Write Extended Attributes**: Users can change the extended attributes of a file or folder.

- **Create Files/Write Data**: The "Create Files" permission allows users to create files within the folder. (This permission applies to folders only.) The "Write Data" permission allows users to make changes to the file and overwrite existing content. (This permission applies to files only.)

- **Create Folders/Append Data**: The "Create Folders" permission allows users to create folders within a folder. (This permission applies to folders only.) The "Append Data" permission allows users to make changes to the end of the file, but they can't change, delete or overwrite existing data. (This permission applies to files only.)

- **Delete**: Users can delete the file or folder. (If users don't have the "Delete" permission on a file or folder, they can still delete it if they have the "Delete Subfolders And Files" permission on the parent folder.)

- **Read Permissions**: Users can read the permissions of a file or folder, such as "Full Control", "Read", and "Write".

- **Change Permissions**: Users can change the permissions of a file or folder.

- **Take Ownership**: Users can take ownership of the file or folder. The owner of a file or folder can always change permissions on it, regardless of any existing permissions that protect the file or folder.

- **Synchronize**: Users can use the object for synchronization. This enables a thread to wait until the object is in the signaled state. This right is not presented in ACL Editor. You can read more about it here.