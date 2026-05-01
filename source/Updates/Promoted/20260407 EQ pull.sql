SELECT        FiscalMonth, WSCO___company, WSDOCO_salesorder_number, WSDCTO_order_type, WS$OSC_order_source_code, WSAN8__billto, WSSHAN_shipto, WSDGL__gl_date, WSSOQS_quantity_shipped, 
                         WSTRDJ_order_date, WSVR01_reference, WSVR02_reference_2, WSKCO__document_company, WSDOC__document_number, WSDCT__document_type, WSROUT_ship_method, WSENTB_entered_by, 
                         WSTKBY_order_taken_by, WSORD__equipment_order, WSORDT_order_type, WSCAG__cagess_code, WS$ESS_equipment_specialist_code, WS$CCS_cadcam_specialist_code, WS$NM1__name_1, WS$NM3_researched_by, 
                         WS$NM4_completed_by, WS$NM5__name_5, WS$L01_level_code_01, WSAC10_division_code, source_cd, transaction_amt, gp_ext_amt, fsc_salesperson_key_id, fsc_comm_plan_id, ess_salesperson_key_id, 
                         ess_comm_plan_id, ess_code
FROM            comm.transaction_F555115 AS t
WHERE        (FiscalMonth = 202512) AND (WSDCTO_order_type <> 'AA') AND (WS$OSC_order_source_code IN ('A', 'L'))

--

SELECT        t.FiscalMonth, t.WSSHAN_shipto, BRS_FSC_Rollup.Branch, c.Province, t.WSORD__equipment_order, t.WSDOCO_salesorder_number, t.WSDCTO_order_type, t.WS$OSC_order_source_code, t.WSAN8__billto, 
                         t.WSDGL__gl_date, t.WSTRDJ_order_date, t.WSVR01_reference, t.WSVR02_reference_2, t.WSKCO__document_company, t.WSDOC__document_number, t.WSDCT__document_type, t.WSROUT_ship_method, 
                         t.WSENTB_entered_by, t.WSTKBY_order_taken_by, t.WSORDT_order_type, t.WSCAG__cagess_code, t.WS$ESS_equipment_specialist_code, t.WS$CCS_cadcam_specialist_code, t.WS$NM1__name_1, 
                         t.WS$NM3_researched_by, t.WS$NM4_completed_by, t.WS$NM5__name_5, t.WS$L01_level_code_01, t.WSAC10_division_code, t.source_cd, t.fsc_salesperson_key_id, t.fsc_comm_plan_id, t.ess_salesperson_key_id, 
                         t.ess_comm_plan_id, t.ess_code, SUM(t.transaction_amt) AS sales_amt, SUM(t.gp_ext_amt) AS gp_comm_amt
FROM            comm.transaction_F555115 AS t INNER JOIN
                         BRS_Customer AS c ON t.WSSHAN_shipto = c.ShipTo INNER JOIN
                         BRS_FSC_Rollup ON c.TerritoryCd = BRS_FSC_Rollup.TerritoryCd
WHERE        (t.FiscalMonth BETWEEN 202501 AND 202512) AND (t.WSDCTO_order_type <> 'AA') AND (t.WS$OSC_order_source_code IN ('A', 'L'))
GROUP BY t.FiscalMonth, t.WSDOCO_salesorder_number, t.WSDCTO_order_type, t.WS$OSC_order_source_code, t.WSAN8__billto, t.WSSHAN_shipto, t.WSDGL__gl_date, t.WSTRDJ_order_date, t.WSVR01_reference, 
                         t.WSVR02_reference_2, t.WSKCO__document_company, t.WSDOC__document_number, t.WSDCT__document_type, t.WSROUT_ship_method, t.WSENTB_entered_by, t.WSTKBY_order_taken_by, t.WSORD__equipment_order, 
                         t.WSORDT_order_type, t.WSCAG__cagess_code, t.WS$ESS_equipment_specialist_code, t.WS$CCS_cadcam_specialist_code, t.WS$NM1__name_1, t.WS$NM3_researched_by, t.WS$NM4_completed_by, t.WS$NM5__name_5, 
                         t.WS$L01_level_code_01, t.WSAC10_division_code, t.source_cd, t.fsc_salesperson_key_id, t.fsc_comm_plan_id, t.ess_salesperson_key_id, t.ess_comm_plan_id, t.ess_code, c.Province, BRS_FSC_Rollup.Branch