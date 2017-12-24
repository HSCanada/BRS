Option Compare Database
Option Explicit

'

Private cConfig As Collection
    

' hard code this for now.  external file .env would be ideal
Public Sub config_init()
    Debug.Print "BR_Decouple.config_init"
    Set cConfig = New Collection
    
       
    'dev
    cConfig.Add "DEV CommissionAdmin v2.00", "APP_NAME"
    cConfig.Add "ODBC;DRIVER=SQL Server;SERVER=CAHSIONNLSQL2;DATABASE=DEV_BRsales", "CONNECTIONSTRING"
    cConfig.Add "S:\Business Reporting\zDev\BRS\CommBE\Publish\", "PATH_PUBLISH"
    cConfig.Add "S:\Business Reporting\zDev\BRS\CommBE\Publish\CommBE_log.txt", "FILEPATH_LOG"
    

End Sub


Public Function config(sParam As Variant) As String
    Debug.Print "BR_Decouple.config(sParam=" & sParam & ")"
    Debug.Assert Not cConfig Is Nothing
    config = cConfig(sParam)
End Function



Sub test()
'    config_init
    
    Debug.Print config("CONNECTIONSTRING")
    
End Sub