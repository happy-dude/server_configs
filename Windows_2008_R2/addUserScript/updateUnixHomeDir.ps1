Import-Module ActiveDirectory

$UserList = get-aduser -filter *

foreach($u in $UserList) {
	$unixHome="/homeShares/"+$u.SamAccountName
	Set-ADuser -Identity $u.SamAccountName -Replace @{ unixHomeDirectory=$unixHome;}
}