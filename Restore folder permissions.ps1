#cd to drive/folder you would like to add permissions for

$foldernames = Get-ChildItem -Name

Foreach ($name in $foldernames) {
    $acl = Get-Acl "..\$name"
    $first,$last = $name -split " "
    $name = "$last $first"
    $user = Get-ADUser -Filter "Name -eq '$name'" -Properties SamAccountName

    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("CARMEUSE\$($user.SamAccountName)","Modify","Allow")
    
    $acl.SetAccessRule($AccessRule)

    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("CARMEUSE\IT Help Desk","FullControl","Allow")
    
    $acl.SetAccessRule($AccessRule)

    $first,$last = $name -split " "
    $name = "$last $first"
    $acl | Set-Acl "..\$name"
}