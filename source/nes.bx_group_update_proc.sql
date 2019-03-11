SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [nes].bx_group_update_proc
	@Shipto int , 
	@GroupId int , 
	@SetDate Date
AS

/******************************************************************************
**	File: 
**	Name: [nes].bx_group_update_proc
**	Desc: 
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	
**
**	Auth: tmc
**	Date: 07 Mar 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/



BEGIN
	SET NOCOUNT ON;

	UPDATE       
		BRS_Customer
	SET                
		bx_setup_date = @SetDate
		, bx_group_id = @GroupId
		, [bx_invite_ind] =  ISNULL([bx_invite_ind],0) + 1
	WHERE
		ShipTo = @Shipto

END


GO


--Exec [nes].bx_group_update_proc 0, 0, '2019-03-07'
-- EXEC [nes].[bx_group_update_proc] @Shipto = 1671260, @GroupId = 315, @SetDate = '31/03/2019'
-- 


