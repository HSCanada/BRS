
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [comm].[config]
AS

/******************************************************************************
**	File: 
**	Name: Customer
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 28 Mar 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT [id]
      ,[SalesDate]
      ,[FiscalMonth]
      ,[PriorFiscalMonth]
      ,[comm_LastWeekly]
      ,[comm_output_path_txt]
      ,[comm_log_filepath_txt]
  FROM [dbo].[BRS_Config]
  where id = 0
  	
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * from comm.config


