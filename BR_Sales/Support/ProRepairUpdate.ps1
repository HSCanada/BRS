$File_path = 'S:\BR\Projects\service_automation\working\'

$file_in  = 'ProRepair-Template.xlsm'
$file_out = 'ProRepair-Corporate.xlsm'


Remove-Item –path ($File_path + $file_out)

$x1 = New-Object -ComObject "Excel.Application"
$x1.Visible = $false
$wb = $x1.workbooks.Open($File_path + $file_in)

$wb.refreshAll()
$wb.SaveAs($File_path + $file_out)

$wb.Close()
$x1.Quit()

Remove-Variable wb,x1