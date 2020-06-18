-- BX QA prep, tmc, 17 Jun 20


-- design
UPDATE
	[DEV_BRSales].[nes].[bx_role_branch]
SET  
   [SamAccountName] = 'JLi'

WHERE 
	SamAccountName <>'' AND
	role_key = 2

-- coord
UPDATE
	[DEV_BRSales].[nes].[bx_role_branch]
SET  
   [SamAccountName] = 'TCrowley'

WHERE 
	SamAccountName <>'' AND
	role_key = 3

-- install
UPDATE
	[DEV_BRSales].[nes].[bx_role_branch]
SET  
   [SamAccountName] = 'Gary.Winslow'

WHERE 
	SamAccountName <>'' AND
	role_key = 4

-- other = na
UPDATE
	[DEV_BRSales].[nes].[bx_role_branch]
SET  
   [SamAccountName] = '',
   bx_active_ind =0

WHERE 
	SamAccountName <>'' AND
	role_key > 4

--

UPDATE
	[dbo].[BRS_FSC_Rollup]
SET
   [SamAccountName] = 'TCrowley'

WHERE 
	SamAccountName <>'' 


