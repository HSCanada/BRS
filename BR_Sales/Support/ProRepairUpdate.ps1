# updated 30 Oct 18, tmc

$File_in = 'S:\BR\Projects\service_automation\working\ProRepair-20181030.xlsm'


#$file_out = 'S:\Pro-Repair\Corporate\ProRepair-All.xlsm'


$x1 = New-Object -ComObject "Excel.Application"
#$x1.Visible = $false
$x1.Visible = $true

# filter and logging happens on open
$wb = $x1.workbooks.Open($file_in)

# pull new new data into template excel
$wb.refreshAll()

# Save individulized version by updating Branch_default on "Working" tab (4)
$Data= $wb.Worksheets.Item(4)

# AAAAA	All
$file_out = 'S:\BR\Projects\service_automation\working\ProRepair-All.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'AAAAA'
$wb.SaveAs($file_out)

# MNTRL	Montreal
$file_out = 'S:\BR\Projects\service_automation\working\ProRepair-Montreal.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'MNTRL'
$wb.SaveAs($file_out)

# QUEBC	Quebec
$file_out = 'S:\BR\Projects\service_automation\working\ProRepair-Quebec.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'QUEBC'
$wb.SaveAs($file_out)

# TORNT	Toronto
$file_out = 'S:\BR\Projects\service_automation\working\ProRepair-Toronto.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'TORNT'
$wb.SaveAs($file_out)

# VACVR	Vancouver
$file_out = 'S:\BR\Projects\service_automation\working\ProRepair-Vancouver.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'VACVR'
$wb.SaveAs($file_out)

$wb.Close()
$x1.Quit()

Remove-Variable wb,x1