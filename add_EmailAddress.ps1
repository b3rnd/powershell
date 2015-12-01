$MailDomain = "@your.domain"

#local Mailboxes
$Mailboxes = Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox')}
Foreach ($Mailbox in $Mailboxes)
{
	$Email = $Mailbox 
	$Addr = $Mailbox.UserPrincipalName | Out-String
	$Addr = $Addr.ToLower()
	$Addr = $Addr.Substring(0,$Addr.IndexOf("@")) + $MailDomain
	$Email.EmailAddresses +=("smtp:" + $Addr)
	#$Email.EmailAddresses
	Set-Mailbox –Identity $Email.Alias -EmailAddresses $Email.EmailAddresses
}

#cloud Mailboxes - Office365 Hybrid ...
$rMailboxes = Get-RemoteMailbox -ResultSize unlimited
Foreach ($rMailbox in $rMailboxes)
{
	$Email = $rMailbox 
	$Addr = $rMailbox.UserPrincipalName | Out-String
	$Addr = $Addr.ToLower()
	$Addr = $Addr.Substring(0,$Addr.IndexOf("@")) + $MailDomain
	$Email.EmailAddresses +=("smtp:" + $Addr)
	#$Email.EmailAddresses
	Set-RemoteMailbox –Identity $Email.Alias -EmailAddresses $Email.EmailAddresses
}
