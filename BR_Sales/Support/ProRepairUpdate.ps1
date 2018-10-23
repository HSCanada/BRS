# updated 23 Oct 18, tmc

$File_in = 'S:\BR\Projects\service_automation\working\ProRepair-20181023.xlsm'

$file_out = 'S:\Pro-Repair\Corporate\ProRepair-All.xlsm'


Remove-Item –path ($file_out) -ErrorAction Ignore

$x1 = New-Object -ComObject "Excel.Application"
#$x1.Visible = $false
$x1.Visible = $true

$wb = $x1.workbooks.Open($file_in)

$wb.refreshAll()
$wb.SaveAs($file_out)

$wb.Close()
$x1.Quit()

Remove-Variable wb,x1