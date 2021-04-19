# BusRevSubsUpdate:  save Substitution files
# 14 Nov 20, tmc, init
Param(
    [Parameter( Mandatory=$True, ValueFromPipeline=$True) ] 
    $pipelineInput
)

Begin {

    if($env:BRS_MODE -eq "PROD") {
        $param_calmonth = 202012
        $File_in = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\BusinessReviewSubstituation_Data-20201114.xlsm'
        $file_out_path = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\Publish\'
    } 
    else {
        $param_calmonth = 202012
        $File_in = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\BusinessReviewSubstituation_Data-20201114.xlsm'
        $file_out_path = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\Publish\'
    }

    # Part 1 - Open template file and load data
    $x1 = New-Object -ComObject "Excel.Application"
    #$x1.Visible = $false
    $x1.Visible = $true

    # there is an automacro that run on open.  put customer logic here
    # filter and logging happens on open
    $wb = $x1.workbooks.Open($file_in)
    # pull new new data into template excel
    $wb.refreshAll()
    # Save individulized version by updating Branch_default on "Working" tab (2)
    $param = $wb.Worksheets.Item(2)
}

PROCESS {
            
    ForEach ($rec in $pipelineInput) {

        # store dates for post pipeline to sql save state
        $param_billto = $rec
        #$pr_finish = $rec.bx_install_date

        # Part 2 - Filter custom data (in loop)
        # set from pipline
        $param.Cells.Item(1,2) = $param_billto
        $param.Cells.Item(2,2) = $param_calmonth
        $x1.Run('ThisWorkbook.setDefaultFilter')
        $param_AccountName = $param.Cells.Item(3,2).Text
        $param_fsc = $param.Cells.Item(4,2).Text
        $param_branch = $param.Cells.Item(5,2).Text


        # Part 3 - Save Branch version to staging Area (avoid locks)
        $file_out = 'BusReviewSubs'+'_'+$param_branch+'_'+$param_fsc+'_'+$param_AccountName+'_'+$param_billto+'.pdf'
        #$file_out = 'BusinessReviewSubstituation_Data-out.xlsx'
        Remove-Item –path ($file_out_path+$file_out) -ErrorAction Ignore
        #$wb.SaveAs($file_out)
        $wb.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, $file_out_path+$file_out) 
        #$wb.SaveAs($file_out_path+$file_out, 51)
        #$file_out = 'S:\Pro-Repair\Corporate\update\ProRepair-All.xlsm'
        #Copy-Item $file_out -destination S:\Pro-Repair\Corporate

    
        # return new group for post processing
        [PSCustomObject]@{
            BILLTO = $param_billto
            CALMONTH = $param_calmonth
            ACCOUNTNAME = $param_AccountName
            FSC = $param_fsc
            BRANCH = $param_branch
        }
    }
}
END {
    # Part 4 - Cleanup
    $wb.Close($false)
    $x1.Quit()
    Remove-Variable wb,x1
}



