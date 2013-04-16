#import modules
Import-Module ActiveDirectory

#$adminUser= Read-Host -Prompt "Your Username"
#$TempAdminPass= Read-Host -Prompt "Your Password"-AsSecureString
#$adminPass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($TempAdminPass))

$mailHost="lin-cent6-01.eastco.sa3"
$mailCmd="/addAlias.sh"

$homedirHost="sol-11-01.eastco.sa3"
$homedirCmd="/newUserPermissions.sh"

import-csv eastco_users.csv | foreach-object {
	$uid = Get-Content .\lastUID.txt
	$uid = [int]$uid
	$uid += 1

	#Get username information
	$firstName= $_.firstName
	$middleName = $_.middleName
	$lastName= $_.lastName

	#Get default password

	$department= $_.deptName
	$extension = $_.extension
	$empNumber = $_.empNum
	$pass = "eastCoDefaultPassword!"+$empNumber
	$Temppassword= convertto-securestring $pass -asplaintext -force
	
	##### Create variables #####
	if($Lastname.Length -gt 18) {
		$samOrig=$firstname.Substring(0,1)+$Lastname.Substring(0,18)
	}
	else {
		$samOrig=$firstname.Substring(0,1)+$Lastname
	}

	$count=0
	$sam=$samOrig

	while(Get-ADUser -Filter {SamAccountName -eq $sam}) {
		$count++
		$sam=$samOrig+$count
	}

	$name= $firstname + " " + $Lastname
	$dirpath= "\\smb.eastco.sa3\homes\"+$sam
	$identity="ad.eastco.sa3\"+ $sam
	$princpalname=$sam +"@ad.eastco.sa3"
	$company="EastCo"
	 
	$mailHost="lin-cent6-01.eastco.sa3"
	$mailCmd="/addAlias.sh"
	$mailPost="/postAlias.sh"
	$emailAlias
	if($count > 0) {
		$emailAlias = $firstname + "." + $lastname + $count
	}
	else {
		$emailAlias = $firstname + "." + $lastname
	}
	$emailAddress=$emailAlias+"@eastco.sa3"
	$shell="/bin/bash"
	$unixHome="/homeShares/"+$sam

	$OU="OU=Users,OU="+$department+",OU=EastCo,DC=ad,DC=eastco,DC=sa3"

	##### Setup User#####
	#Create AD Account
	$groupName = $department + "group"
	$gid = get-adgroup -identity $groupName -Properties gidnumber | Select-Object -ExpandProperty gidnumber
	$gid = $gid.tostring()

	New-ADUser -name $name `
		-SamAccountName $sam `
		-GivenName $firstname `
		-Surname $Lastname `
		-OtherName $middleName  `
		-OtherAttributes @{mssfu30nisdomain="ad"; `
			uid=$sam; uidNumber=$uid; loginShell=$shell; `
			unixHomeDirectory=$unixHome} `
		-OfficePhone $extension `
		-employeeNumber $empNumber `
		-Path $OU `
		-userprincipalname $princpalname `
		-homedrive "Z:" `
		-homedirectory $dirpath `
		-Displayname $name `
		-AccountPassword $Temppassword `
		-Enabled $true `
		-ChangePasswordAtLogon $true `
		-Company $company `
		-Department $department `
		-EmailAddress $emailAddress
	Set-ADUser -Identity $sam -Replace @{gidNumber=$gid}


	Add-ADGroupMember $groupName $sam

	$aliasOut = $emailAlias + ": " + $sam
	echo $aliasOut >> .\alias.txt

	##### Create MailBox ####
	#.\plink.exe -pw $adminPass $adminUser@$mailHost $mailCmd $emailAlias $sam $adminPass #2>&1 | Out-Null 
	#.\plink.exe -pw $adminPass $adminUser@$mailHost $mailPost $adminPass #2>&1 | Out-Null 

	###Create Home Directories
	mkdir($dirpath) 2>&1 | Out-Null 
	echo $sam >> .\homeDirs.txt
	#.\plink.exe -pw $adminPass $adminUser@$homedirHost $homedirCmd $sam $adminPass #2>&1 | Out-Null 

	# Write-Host $homedir access rights assigned

	 echo $uid > .\lastUID.txt
	Write-Host $sam "created."
}
#.\plink.exe -batch -pw $adminPass $adminUser@$mailHost $mailPost $adminPass 2>&1 | Out-Null 