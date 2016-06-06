$fwds = get-mailbox | Where-Object { $_.ForwardingAddress -ne $null } | select Name, ForwardingAddress

foreach ($fwd in $fwds) {$fwd | add-member -membertype noteproperty -name "ContactAddress" -value (get-contact $fwd.ForwardingAddress).WindowsEmailAddress}

$efwds = get-remotemailbox | Where-Object { $_.ForwardingAddress -ne $null } | select Name, ForwardingAddress

foreach ($fwd in $efwds) {$fwd | add-member -membertype noteproperty -name "ContactAddress" -value (get-contact $fwd.ForwardingAddress).WindowsEmailAddress}

$fwds
$efwds
