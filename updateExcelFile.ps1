$file = 'X:\path\to\excel\file.xls'
$xl = New-Object -ComObject "Excel.Application"
$xl.Visible = $false
$wb = $xl.workbooks.Open($file)
$wb.RefreshAll()
$conn = $wb.Connections
while($conn | ForEach-Object {if($_.OLEDBConnection.Refreshing){$true}}){
    Start-Sleep -Seconds 1
}
$wb.Save()
$wb.Close()
$xl.Quit()
Remove-Variable wb,xl
