

#Text file must be manipulated first to contain only the name and email of each user.
#This can be accomplished by pasting all the names/emails into notepad, find and replace ; with , then save as csv.
#Open this csv with excel, copy/paste with transpose option then copy/paste into notepad and save as .txt
#Run the below on the .txt

$Users = Get-Content 'C:\Users\FAVO\Desktop\users.txt'

$Users  -replace " <.*", "," | Out-File C:\Users\FAVO\Desktop\usersreadytoadd.csv

#Type "name," to the beginning of the file and save
#Copy/paste csv onto server
#Then run the below on the exchange server

$usersreadytoadd = Import-Csv 'C:\Users\FAVO\Desktop\usersreadytoadd.csv'

foreach ($User in $usersreadytoadd)
{
    Add-DistributionGroupMember -Identity "username@domain.com" -Member "$($User.name)"
}
