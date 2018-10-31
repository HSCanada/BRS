# ProRepair:  Daily Refresh & file distribution.  
# updated 31 Oct 18, tmc

$File_in = 'S:\BR\Projects\service_automation\working\ProRepair-20181031.xlsm'


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
$file_out = 'S:\Pro-Repair\Corporate\update\ProRepair-All.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'AAAAA'
$wb.SaveAs($file_out)

# MNTRL	Montreal
$file_out = 'S:\Pro-Repair\Montreal\update\ProRepair-Montreal.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'MNTRL'
$wb.SaveAs($file_out)

# QUEBC	Quebec
$file_out = 'S:\Pro-Repair\Quebec\update\ProRepair-Quebec.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'QUEBC'
$wb.SaveAs($file_out)

# TORNT	Toronto
$file_out = 'S:\Pro-Repair\Toronto\update\ProRepair-Toronto.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'TORNT'
$wb.SaveAs($file_out)

# VACVR	Vancouver
$file_out = 'S:\Pro-Repair\Vancouver\update\ProRepair-Vancouver.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'VACVR'
$wb.SaveAs($file_out)

$wb.Close()
$x1.Quit()

Remove-Variable wb,x1