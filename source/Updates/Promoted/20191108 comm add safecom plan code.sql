
-- add safecom plan code, tmc, 8 Nov 19

INSERT INTO [comm].[group]
           ([comm_group_cd]
           ,[comm_group_desc]
           ,[source_cd]
           ,[active_ind]
		   )
     VALUES
           ('SAFCOM'
           ,'Safecom Hi-Tech'
           ,'JDE'
           ,1
           )
GO


UPDATE
[dbo].[BRS_Item]
SET [custom_comm_group1_cd] = 'SAFCOM'
WHERE
[Item] In ('5837912','5831069','5831451','5834943','5837545','5833107','5834937','5844099','9398060','9399459','9393267','9392430')