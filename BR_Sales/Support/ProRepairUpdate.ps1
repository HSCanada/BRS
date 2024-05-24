# ProRepair:  Daily Refresh & file distribution.  
# 13 Nov 18, tmc, enable refresh after filter set
# 16 Nov 18, tmc, added Calgary, Edmonton, Ottawa to set
# 12 Dec 18, tmc, added FSC, EST to detail
# 14 Mar 22, tmc, moved template to daily folder
# 23 Apr 24, tmc, rolled out v2.0 for 2024

#$File_in = 'S:\BR\Projects\service_automation\working\ProRepair-20201023.xlsm'

# This is the template.  Can be anything

$File_in = 'S:\BR\RegularReports\Daily\Prorepair_Pipeline_KPI\template\ProRepair-20240523-prod.xlsm'
#$File_in = 'S:\BR\RegularReports\Daily\Prorepair_Pipeline_KPI\template\ProRepair-20181212.xlsm'

# Part 1 - Pull data into 1 template

$x1 = New-Object -ComObject "Excel.Application"
#$x1.Visible = $false
$x1.Visible = $true

# this will set a filter
# $Data.Cells.Item(1,2) = 'AAAAA'

# there is an automacro that run on open.  put customer logic here
# filter and logging happens on open
$wb = $x1.workbooks.Open($file_in)

# pull new new data into template excel
$wb.refreshAll()

# Save individulized version by updating Branch_default on "Working" tab (4)
$Data= $wb.Worksheets.Item(4)

# remove connection for reporting
$wb.Connections.Item(1).Delete()


# Part 2 - Save Branch version to staging Area (avoid locks)

# This should be in loop


# Update SS
# AAAAA	All
$file_out = 'S:\Pro-Repair\Corporate\update\ProRepair-All.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'AAAAA'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

# MNTRL	Montreal
$file_out = 'S:\Pro-Repair\Montreal\update\ProRepair-Montreal.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'MNTRL'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

# QUEBC	Quebec
$file_out = 'S:\Pro-Repair\Quebec\update\ProRepair-Quebec.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'QUEBC'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

# TORNT	Toronto
$file_out = 'S:\Pro-Repair\Toronto\update\ProRepair-Toronto.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'TORNT'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

# VACVR	Vancouver
$file_out = 'S:\Pro-Repair\Vancouver\update\ProRepair-Vancouver.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'VACVR'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

#CALGY	Calgary
$file_out = 'S:\Pro-Repair\Calgary\update\ProRepair-Calgary.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'CALGY'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

#EDMON	Edmonton
$file_out = 'S:\Pro-Repair\Edmonton\update\ProRepair-Edmonton.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'EDMON'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)

#OTTWA	Ottawa
$file_out = 'S:\Pro-Repair\Ottawa\update\ProRepair-Ottawa.xlsm'
Remove-Item –path ($file_out) -ErrorAction Ignore
$Data.Cells.Item(1,2) = 'OTTWA'
$x1.Run('ThisWorkbook.setDefaultFilter')
$wb.SaveAs($file_out)


$wb.Close()
$x1.Quit()

Remove-Variable wb,x1


# Part 3 - Copy Stage areas to Production (locks may happen)

# This should be in loop

# AAAAA	All
$file_out = 'S:\Pro-Repair\Corporate\update\ProRepair-All.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Corporate

# temp pause, added tmc, 21 Apr 21
Read-Host 'pause...'
# temp pause, end

# MNTRL	Montreal
$file_out = 'S:\Pro-Repair\Montreal\update\ProRepair-Montreal.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Montreal

# QUEBC	Quebec
$file_out = 'S:\Pro-Repair\Quebec\update\ProRepair-Quebec.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Quebec

# TORNT	Toronto
$file_out = 'S:\Pro-Repair\Toronto\update\ProRepair-Toronto.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Toronto

# VACVR	Vancouver
$file_out = 'S:\Pro-Repair\Vancouver\update\ProRepair-Vancouver.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Vancouver

#CALGY	Calgary
$file_out = 'S:\Pro-Repair\Calgary\update\ProRepair-Calgary.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Calgary

#EDMON	Edmonton
$file_out = 'S:\Pro-Repair\Edmonton\update\ProRepair-Edmonton.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Edmonton

#OTTWA	Ottawa
$file_out = 'S:\Pro-Repair\Ottawa\update\ProRepair-Ottawa.xlsm'
Copy-Item $file_out -destination S:\Pro-Repair\Ottawa

