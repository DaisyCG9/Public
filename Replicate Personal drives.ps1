#Moves smb shares and folders from one drive to another

Start-Transcript -path C:\output.txt -append

$folders = Get-ChildItem -Path D:\PrivateData -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName

$shares = Get-SmbShare | Where-Object {$_.Path -like "D:\PrivateData*"}
$i = 0
Foreach($folder in $folders.Fullname)
{
    $newpath = "E:" + $folder.Substring(14)
    Write-Output($newpath)
    Write-Output($folder)
    cp $folder $newpath -Recurse
}

Foreach($share in $shares)
    {
        #$shares.Path[$i] = 0
        $userspec = $share.Path.Substring(14)
        Write-output($userspec)
        Write-Output($shares.Path[$i])
        Write-Output($share.name)
        Remove-SmbShare -Name $share.name -Force
        New-SmbShare -Name $share.name -Path $shares.Path[$i] -Force
        $i++
    }

Stop-Transcript