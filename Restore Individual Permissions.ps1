Import-Module ActiveDirectory
$folder = Read-Host -Prompt "Enter the name of the folder to modify"
$acl=get-acl d:\"$folder"
$user = Read-Host -Prompt "Enter 1st group to add"
$secadd = Get-ADGroup -Filter "Name -eq '$user'" -Properties SamAccountName
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("CARMEUSE\$($secadd.SamAccountName)","Modify",'ContainerInherit, ObjectInherit','2','Allow')
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl d:\"$folder"