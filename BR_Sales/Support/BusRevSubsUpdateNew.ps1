# BusRevSubsUpdate:  save Substitution files
# 14 Nov 20, tmc, init
# 26 Jan 26, tmc, update for CCI
Param(
    [Parameter( Mandatory=$True, ValueFromPipeline=$True) ] 
    $pipelineInput
)

Begin {

    if($env:BRS_MODE -eq "PROD") {
        Write-Host "PROD"

        $File_in       = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\Substitution_CCI_Data_20260116.xlsm'
        $file_out_path = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\Publish\'
    } 
    else {
        Write-Host "DEV"

        $File_in = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\Substitution_CCI_Data_20260116.xlsm'
        $file_out_path = 'S:\BR\RegularReports\Weekly\Business_Reviews_PAT\Publish_dev\'
    }

    # Part 1 - Open template file and load data
    $x1 = New-Object -ComObject "Excel.Application"
    $x1.Visible = $false
    #$x1.Visible = $true

    # there is an automacro that run on open.  put customer logic here
    # filter and logging happens on open
    $wb = $x1.workbooks.Open($file_in)

    # pull new new data into template excel
    #TC run here or later?
    $wb.refreshAll()

    # Save individulized version by updating Branch_default on "Working" tab (2)
    # param is the working tab
    $param = $wb.Worksheets.Item(2)
}

PROCESS {
            
    ForEach ($rec in $pipelineInput) {

        # store dates for post pipeline to sql save state
        $param_shipto = $rec
        #$pr_finish = $rec.bx_install_date

        # Part 2 - Filter custom data (in loop)
        # set from pipline
        $param.Cells.Item(1,2) = $param_shipto
        
        $x1.Run('ThisWorkbook.setDefaultFilter')
        $param_AccountName = $param.Cells.Item(3,2).Text
        $param_fsc = $param.Cells.Item(4,2).Text
        $param_branch = $param.Cells.Item(5,2).Text

        # TC added 
        $wb.refreshAll()


        # Part 3 - Save Branch version to staging Area (avoid locks)
        $file_out = 'BusReviewSubsCCI'+'_'+$param_branch+'_'+$param_fsc+'_'+$param_AccountName+'_'+$param_shipto+'.pdf'

        Remove-Item –path ($file_out_path+$file_out) -ErrorAction Ignore

        # get first worksheet
        $ws = $wb.Worksheets.Item(1)

        $ws.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, $file_out_path+$file_out) 
        #$wb.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, $file_out_path+$file_out) 

    
        # return new group for post processing
        [PSCustomObject]@{
            SHIPTO = $param_shipto
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
    Remove-Variable wb,ws,x1
    # Remove-Variable wb,x1
}



