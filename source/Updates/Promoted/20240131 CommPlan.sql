-- Comm Plan 2024, tmc, 31 Jan 24


-- add new EPS code..
INSERT INTO [comm].[group]
           ([comm_group_cd]
           ,[comm_group_desc]
           ,[booking_rt]
		   )
     VALUES

           ('EPSEDO'
           ,'EDGE_ENDO Support'
           ,1
		   )

		   
GO


INSERT INTO [comm].[group]
           ([comm_group_cd]
           ,[comm_group_desc]
           ,[booking_rt]
		   )
     VALUES

           ('EPSHPQ'
           ,'Handpiece Head Quarters'
           ,1
		   )
GO


-- 

--add new rate

SELECT [comm_plan_id]
      ,'EPSEDO' AS [item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_rt]
      ,[active_ind]
      ,'tc 2024 plan' AS [note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
  FROM [comm].[plan_group_rate]
  where item_comm_group_cd = 'EPSEDG'
GO


INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        comm_plan_id, 'EPSEDO' AS item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'tc 2024 plan' AS note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE        (item_comm_group_cd = 'EPSEDG')
GO

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        comm_plan_id, 'EPSHPQ' AS item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'tc 2024 plan' AS note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE        (item_comm_group_cd = 'EPSBAI')
GO

select distinct  [item_comm_group_cd], disp_comm_group_cd from comm.plan_group_rate order by 1


select comm_group_eps_cd,  count(*) from BRS_Item
group by comm_group_eps_cd


-- update eps item codes from legacy

select comm_group_eps_cd,  count(*) from BRS_Item
group by comm_group_eps_cd


-- move legacy to prod
select comm_group_eps_cd,  comm_group_legacy_cd, Est12MoSales from BRS_Item where comm_group_eps_cd <>  comm_group_legacy_cd order by 3 desc

UPDATE       BRS_Item
SET                comm_group_eps_cd = comm_group_legacy_cd 
WHERE        (comm_group_eps_cd <> comm_group_legacy_cd)
GO

-- fix prod
select item, ItemDescription, comm_group_eps_cd, label, MajorProductClass, Supplier, Est12MoSales from BRS_Item 
where 
comm_group_eps_cd = 'EPSEDG' and 

Supplier <> 'USENDO' and
((majorproductclass ='007' and label = 'p') OR
(majorproductclass ='087' )) and
(1=1)
order by MajorProductClass
GO


UPDATE       BRS_Item
SET                comm_group_eps_cd = 'EPSEDO'
WHERE        (comm_group_eps_cd = 'EPSEDG') AND (Supplier <> 'USENDO') AND (MajorProductClass = '007') AND (Label = 'p') AND (1 = 1) OR
                         (comm_group_eps_cd = 'EPSEDG') AND (Supplier <> 'USENDO') AND (MajorProductClass = '087') AND (1 = 1)
GO


-- clear legacy

UPDATE       BRS_Item
SET                 comm_group_legacy_cd = ''
WHERE        (comm_group_legacy_cd <> '')


-- Thusday

-- ISR history


UPDATE       BRS_ItemHistory
SET                HIST_comm_group_eps_cd = BRS_Item.comm_group_eps_cd
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item ON BRS_ItemHistory.Item = BRS_Item.Item AND BRS_ItemHistory.HIST_comm_group_eps_cd <> BRS_Item.comm_group_eps_cd
WHERE        (BRS_ItemHistory.FiscalMonth >= 202301)

--FSC next? 

--- xxx

-- FTA setup rates?

-- test 2023


