$URL = "https://business.truphone.com/Authentication/Login"
$ie = New-Object -comobject InternetExplorer.Application -Property @{
    Navigate = $url
    Visible = $false
    Silent = $true
}
do { Start-Sleep -m 100 } while ( $ie.ReadyState -ne 4 )
$ie.Document.getElementById("Username").value = "your_username"
$ie.Document.getElementById("Password").value = "your_password"

do { Start-Sleep -m 5000 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("loginSubmit").click()

do { Start-Sleep -m 5000 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("loginSubmit").click()

do { Start-Sleep -m 5000 } while ( $ie.ReadyState -ne 4 )

$body = "dataUsage: " + $ie.Document.getElementById("dataUsage").outertext.trim() + "`n" + "`n" + "`n"
$body = $body + "freeMinutes: "+ $ie.Document.getElementById("freeMinutes").outertext.trim() + "`n" + "`n" + "`n"
$body = $body + "inbundleMinutes: "+ $ie.Document.getElementById("inbundleMinutes").outertext.trim() + "`n" + "`n" + "`n"
$body = $body + "textsSent: "+ $ie.Document.getElementById("textsSent").outertext.trim() + "`n" + "`n" + "`n"

$EmailFrom = "x@y.z" #Summary Email Sender Address
$EmailTo = "x@y.z" #Summary Email Receiver
$EmailSubject = "Truphone Status" #Summary Email Subject
$SMTPServer = "x.x.x.x" #Mail Server Address

$body
Send-MailMessage -SmtpServer $SMTPServer -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body $body

$ie.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ie) | out-null
Remove-Variable ie
