REM @ECHO OFF




REM ***************************************************************************
REM **	File: ItemExtract.bat
REM **	Name: Item Extract
REM **	Desc: Move Item files from A system to S drive stage area
REM **
REM **              
REM **	Return values: Errorcode = 0 for Success, 1 for fail
REM **
REM **	Called by:   End User
REM **             
REM **	Parameters:
REM **	Input					Output
REM **	----------				-----------
REM **	None
REM **
REM **	Auth: tmc
REM **	Date: 25 Aug 09
REM ***************************************************************************
REM **	Change History
REM ***************************************************************************
REM **	Date:	Author:		Description:
REM **	-----	----------	--------------------------------------------
REM **    
REM ***************************************************************************

REM ***************************************************************************
REM **	Initialize Settings
REM ***************************************************************************


setlocal

Set ProcessName=ItemExtract
Set LockFile="S:\Shared_Everyone\Business Reporting\Shared\Item Extract\%ProcessName%.SEM"

Set FilesMask=ITEM*.CSV
Set PreloadPath="S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Preload"
Set DestPath="S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Data"


REM ***************************************************************************
REM **  Set PO Source  
REM ***************************************************************************

REM DEBUG
REM Set SourcePath="C:\temp\Inbox"

REM PRODUCTION
Set SourcePath="X:\Inbox"


REM ***************************************************************************
REM **  Lock Batch file
REM ***************************************************************************

If Exist %LockFile% Goto EXIT_FAILURE
REM Create Lockfile
Echo %ProcessName% > %LockFile%

::ECHO **  Lock Batch file
::PAUSE

REM ***************************************************************************
REM **  Pre-Process 
REM ***************************************************************************

REM Skip if Source files do not Exist
If Not Exist %SourcePath%\%FilesMask% Goto EXIT_SUCCESS

DEL %PreloadPath%\%FilesMask% /Q

REM Move Source files to PreLoad. 
ECHO SOURCE:   	%SourcePath%\%FilesMask%
ECHO DEST:	%PreloadPath%
Move /Y %SourcePath%\%FilesMask% %PreloadPath%


REM If problem with move, exit with failure.  
If Not Exist %PreloadPath%\%FilesMask% Goto EXIT_FAILURE

::ECHO **  Pre-Process 
::PAUSE

REM ***************************************************************************
REM **  Process
REM ***************************************************************************

REM Call E3POLoad for each PO header in preload.  
REM Files will be Moved to Archive upon successful load
REM Files will be Moved to Exception upon load error.

DEL %DestPath%\%FilesMask% /Q
Move /Y %PreloadPath%\%FilesMask% %DestPath%

::ECHO **  Process
::PAUSE


REM ***************************************************************************
REM **  Post-Process
REM ***************************************************************************

REM If Preload Files still Exist, then an unexpected error occured.  

If Exist %PreloadPath%\%FilesMask% Goto EXIT_FAILURE

::ECHO **  Post-Process
::PAUSE

 del  "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Export\ItemDump.xlsx"


"C:\Program Files\Microsoft Office\root\Office16\MSACCESS.EXE" "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\ItemExtract.accdb" /excl /X Import-Export



Goto EXIT_SUCCESS



REM ***************************************************************************
REM **  Exit Success
REM ***************************************************************************

:EXIT_SUCCESS
If Exist %LockFile% Del %LockFile%

ECHO **  Exit Success
PAUSE

Exit 0


REM ***************************************************************************
REM **  Exit Failure
REM ***************************************************************************

:EXIT_FAILURE
::If Exist %LockFile% Del %LockFile%

ECHO **  Exit Failure
PAUSE

Exit 1

