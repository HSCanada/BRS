SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [nes].bx_group_update_proc
	@Shipto int , 
	@GroupId int , 
	@SetDate Date ,
	@InstallDate Date,
	@bx_cps_code char(5),
	@bx_ess_code char(5),
	@bx_dts_code char(5),
	@bx_fsc_code char(5)
	
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
**	21 Mar 19	tmc		added eq terr for deferred rights
*******************************************************************************/



BEGIN
	SET NOCOUNT ON;

	UPDATE       
		BRS_Customer
	SET                
		bx_setup_date = @SetDate
		,bx_install_date = @InstallDate
		,bx_group_id = @GroupId
		,[bx_invite_ind] =  ISNULL([bx_invite_ind],0) + 1
		,bx_cps_code = @bx_cps_code
		,bx_ess_code = @bx_ess_code
		,bx_dts_code = @bx_dts_code
		,bx_fsc_code = @bx_fsc_code

	WHERE
		ShipTo = @Shipto

END


GO


--Exec [nes].bx_group_update_proc 0, 0, '2019-03-07'
-- EXEC [nes].[bx_group_update_proc] @Shipto = 1671260, @GroupId = 315, @SetDate = '31/03/2019'
-- 


