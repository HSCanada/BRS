-- create a duplicate patch of the comm work.  see fg.order_update_proc
UPDATE    
	BRS_Transaction
SET              
	FreeGoodsEstInd = 0
FROM         
	BRS_Transaction
		
	INNER JOIN BRS_Item AS i 
	ON BRS_Transaction.Item = i.Item

WHERE     
	(i.Label = 'P') AND 
	(BRS_Transaction.FreeGoodsEstInd = 1) AND
	[FiscalMonth] >= 201901 AND
	(1 = 1)

