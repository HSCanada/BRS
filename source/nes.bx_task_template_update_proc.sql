SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [nes].bx_task_template_update_proc
	@bx_task_id int , 
	@bx_title nvarchar(100),
	@bx_description nvarchar(1000),
	@bx_checklist nvarchar(2000)

	
AS

/*****************************************************************************
**	File: 
**	Name: [nes].bx_task_template_update_proc
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
**	Date: 15 Apr 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/



BEGIN
	SET NOCOUNT ON;

	UPDATE       
		[nes].[bx_task_template]
	SET                
		 [bx_title]   = @bx_title
		,[bx_description] = @bx_description
		,[bx_checklist] = @bx_checklist
	WHERE
		bx_task_id = @bx_task_id

END


GO




