/*
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '2. [Integration].[F5554240_fg_redeem_Staging] - set order xref'
*/
	-- clear values
	UPDATE 
		Integration.F5554240_fg_redeem_Staging 
			SET [WKLNNO_line_number] = null
			, ID_source_ref = null

	-- link free good transactions to [dbo].[STAGE_BRS_TransactionDW]
	UPDATE 
		Integration.F5554240_fg_redeem_Staging 
	SET 
		[WKLNNO_line_number] = s.LineNumber
		,ID_source_ref = s.id
	--test
	-- SELECT * 
	FROM
		Integration.F5554240_fg_redeem_Staging
		INNER JOIN
			(
			SELECT
				WKDOCO_salesorder_number, [WKDCTO_order_type], WKLITM_item_number, line_id, ID,
				row_number() over(PARTITION BY WKDOCO_salesorder_number, WKLITM_item_number order by ID) rno_dst2
			FROM
				Integration.F5554240_fg_redeem_Staging 
			WHERE
				-- no internal
				([WKAC10_division_code]<>'AZA') AND
				([WKLNTY_line_type] NOT IN ('M2', 'MS')) AND
				-- by definition, no adjustments or NON free goods included (ensure stage and DW match)
				-- test
				--(WKDOCO_salesorder_number in(14492625)) AND (WKLITM_item_number in('3783903')) AND
				--(WKDOCO_salesorder_number in(14498659)) AND (WKLITM_item_number in('5874352')) AND
				(1=1)
			) d
			ON Integration.F5554240_fg_redeem_Staging.ID = d.ID

			INNER JOIN 
			(
			SELECT
				[SalesOrderNumber], [DocType], [item], [LineNumber], ID,
				row_number() over(PARTITION BY [SalesOrderNumber], [item] order by ID) rno_src2
			FROM
				[dbo].[BRS_TransactionDW]
			WHERE 
				EXISTS (SELECT * FROM Integration.F5554240_fg_redeem_Staging WHERE [SalesOrderNumber] = WKDOCO_salesorder_number) AND
				-- no internal
				([SalesDivision]<>'AZA') AND
				-- no adjustments
				(DocType <> 'AA') AND
				-- free goods only (relax qty = 0 for price adj, likely be to be ignored downstream
		--		([ShippedQty] <> 0) AND
				([NetSalesAmt] = 0) AND
				-- test
				--(SalesOrderNumber in(14492625)) AND (item in ('3783903')) AND
				--(SalesOrderNumber in(14498659)) AND (item in ('5874352')) AND
				(1=1)
			) s
			ON d.WKDOCO_salesorder_number = s.[SalesOrderNumber] AND
				d.[WKDCTO_order_type] = s.[DocType] AND
				RTRIM(d.WKLITM_item_number) = RTRIM(s.[item]) AND
				d.rno_dst2 = s.rno_src2 AND
				(1=1)
		WHERE
			-- test
			--(Integration.F5554240_fg_redeem_Staging.WKDOCO_salesorder_number in(14492625)) AND (Integration.F5554240_fg_redeem_Staging.WKLITM_item_number in ('3783903')) AND
			--(Integration.F5554240_fg_redeem_Staging.WKDOCO_salesorder_number in(14498659)) AND (Integration.F5554240_fg_redeem_Staging.WKLITM_item_number in('5874352')) AND
			--(Integration.F5554240_fg_redeem_Staging.ID = 4263) AND
			(1=1)

			/*			
			-- test
			SELECT * FROM Integration.F5554240_fg_redeem_Staging  
			WHERE 
				WKLNNO_line_number is null AND
				([WKAC10_division_code]<>'AZA') AND
				([WKLNTY_line_type] NOT IN ('M2', 'MS')) AND
				(1=1)
			*/

/*
	Set @nErrorCode = @@Error
End

*/
