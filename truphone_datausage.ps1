$URL = "https://business.truphone.com/Authentication/Login"
$ie = New-Object -comobject InternetExplorer.Application -Property @{
    Navigate = $url
    Visible = $false
    Silent = $true
}

do { Start-Sleep -m 100 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("Username").value = "your_username"
$ie.Document.getElementById("Password").value = "your_password"

do { Start-Sleep -m 500 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("loginSubmit").click()

do { Start-Sleep -m 5000 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("loginSubmit").click()

do { Start-Sleep -m 5000 } while ( $ie.ReadyState -ne 4 )

$body = "dataUsage: " + $ie.Document.getElementById("dataUsage").outertext.trim() + "`n"
$array = $ie.Document.getElementById("freeMinutes").outertext.Split("`r`n")
$body = $body + "freeMinutes: "

foreach ($line in $array) {
	$body = $body + $line
}

$body = $body + "`n"
$array1 = $ie.Document.getElementById("inbundleMinutes").outertext.Split("`r`n")
$body = $body + "inbundleMinutes: "

foreach ($line in $array1) {
	$body = $body + $line
}

$body = $body + "`n"
$body = $body + "textsSent: "+ $ie.Document.getElementById("textsSent").outertext.trim() + "`n"

$EmailFrom = "x@y.z" #Summary Email Sender Address
$EmailTo = "x@y.z" #Summary Email Receiver
$EmailSubject = "Truphone Status" #Summary Email Subject
$SMTPServer = "x.x.x.x" #Mail Server Address

Send-MailMessage -SmtpServer $SMTPServer -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body $body.trim()

$ie.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ie) | out-null
Remove-Variable ie
