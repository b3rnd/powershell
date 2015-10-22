$URL = "https://business.truphone.com/Authentication/Login"
$ie = New-Object -comobject InternetExplorer.Application -Property @{
    Navigate = $url
    Visible = $false
    Silent = $true
}
do { Start-Sleep -m 100 } while ( $ie.ReadyState -ne 4 )
$ie.Document.getElementById("Username").value = "your_username"
$ie.Document.getElementById("Password").value = "your_password"

do { Start-Sleep -m 2000 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("loginSubmit").click()

do { Start-Sleep -m 2000 } while ( $ie.ReadyState -ne 4 )

$ie.Document.getElementById("loginSubmit").click()

do { Start-Sleep -m 2000 } while ( $ie.ReadyState -ne 4 )

$body = $ie.Document.body | Out-String

$array = $body.Split("`n")

foreach ($line in $array)
{
	if ($line.contains("text:dataUsedWithFormat -->"))
	{
		$j = 7
		for($i = 58; $i -le 70; $i++)
		{
			if($line.Substring(58,7) -eq "<")
			{
				$j = $i - 57
				break
			}
		}
		
		$usage = $line.Substring(58,$j)
		
		$EmailFrom = "x@y.z" #Summary Email Sender Address
		$EmailTo = "x@y.z" #Summary Email Receiver
		$EmailSubject = "Truphone Datenverbrauch: " + $usage #Summary Email Subject
		$SMTPServer = "x.x.x.x" #Mail Server Address
		
		Send-MailMessage -SmtpServer $SMTPServer -From $EmailFrom -To $EmailTo -Subject $EmailSubject -Body $usage
		
		break
	}
}

$ie.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ie) | out-null
Remove-Variable ie
