-- Service Pro repair rollup, tmc, 25 Nov 25

SELECT TOP 

      ,[workorder #]
      ,[Call type]

      ,[TCPFLG]
      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData]

select distinct [TCPDT] from [Offline].[dbo].[OL_ServiceData]


SELECT distinct  

      [workorder #]
      ,[Call type]
      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData] where [TCPDT] >= 202510

-- 1.  pull Work



  
