$MailDomain = "@your.domain"

#local Mailboxes
$Mailboxes = Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox')}
Foreach ($Mailbox in $Mailboxes)
{
	$Email = $Mailbox 
	$Addr = $Mailbox.PrimarySmtpAddress.Local | Out-String
	$Addr = $Addr.ToLower()
	$Addr = $Addr + $MailDomain
	$Email.EmailAddresses +=("smtp:" + $Addr)
	Set-Mailbox –Identity $Email.Alias -EmailAddresses $Email.EmailAddresses
}

#cloud Mailboxes - Office365 Hybrid ...
$rMailboxes = Get-RemoteMailbox -ResultSize unlimited
Foreach ($rMailbox in $rMailboxes)
{
	$Email = $rMailbox 
	$Addr = $rMailbox.PrimarySmtpAddress.Local | Out-String
	$Addr = $Addr.ToLower()
	$Addr = $Addr + $MailDomain
	$Email.EmailAddresses +=("smtp:" + $Addr)
	Set-RemoteMailbox –Identity $Email.Alias -EmailAddresses $Email.EmailAddresses
}
