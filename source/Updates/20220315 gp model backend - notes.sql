/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ICMOWO_work_order_number]
      ,[ICMORD_ets_order_number]
      ,[ICMTYP2_header_detail]
      ,[ICMMSG_comments]
      ,[ICMTYP1_record_type]
      ,[ID]
  FROM [DEV_BRSales].[nes].[order_note_D1ICMTPF]
  where
  ([ICMTYP2_header_detail] = 'H') AND
--  ([ICMMSG_comments] like '%pst rebate program%' ) AND
--    ([ICMMSG_comments] like '%distre%' ) AND 
    ([ICMMSG_comments] like '%disc%' ) AND 
--    ([ICMMSG_comments] like '%compet%' ) AND 
--    ([ICMMSG_comments] like '%Warranty%' ) AND
--    ([ICMMSG_comments] like '%garant%' ) AND NOT
--    ([ICMMSG_comments] like '%garantie%' ) AND


--  ([ICMMSG_comments] like '%reba%' ) AND NOT
  (1=1)