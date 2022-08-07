/****** Script for SelectTopNRows command from SSMS  ******/
-- 77 78 79 80 81 100 101
--CODIGO COMBUSTIBLE O04
--ACTUAL

SELECT TOP (1000) [location]
      ,[shift_date]
      ,[shift_ident]
      ,[num_loads]
      ,[wait_min]
      ,[queue_min]
      ,[dump_min]
  FROM [dbo].[HAULER_TIME_AT_DUMPS]
  ORDER BY shift_date 


  SELECT TOP (1000) [START_TIMESTAMP]
      ,[SHIFT_DATE]
      ,[SHIFT_IDENT]
      ,[EQUIP_IDENT]
      ,[STATUS_CODE]
      ,[SUB_STATUS_CODE]
      ,[END_TIMESTAMP]
      ,[STATUS_DESC]
      ,[SUB_STATUS_DESC]
      ,[HAULER_IDENT]
  FROM [dbo].[LOADER_TIME_PROFILE]






declare @PI_VALUE  float
declare @PI_TAGNAME varchar(50)
declare @PI_TIMESTAMP Datetime
declare @PI_HORASOP  float
declare @PI_TONMOV  float

 
set @PI_TAGNAME  = 'VE1_1123:SH_PROD_SHIFT_ACTUAL.JIG'
set @PI_TIMESTAMP = (select DATEADD(hh, 0, getDate()))
               if (DATEPART(HH, GETDATE()) between  8 and 19) 
                   select @PI_HORASOP =  isnull(sum(operativo),0) 
                  from jView_tiempos_equipos
                  where [name] in ('FL231','FL230') and Fecha = CONVERT(char(10), GETDATE(), 101) 
                  and shift_id = 523


              if (DATEPART(HH, GETDATE()) between  20 and 23)
                   select @PI_HORASOP =  isnull(sum(operativo),0) 
                  from jView_tiempos_equipos
                  where [name] in ('FL231','FL230') and Fecha = CONVERT(char(10), GETDATE(), 101) 
                  and shift_id = 524



               if (DATEPART(HH, GETDATE())  between  0 and 7)  
                  select @PI_HORASOP =  isnull(sum(operativo),0) 
                  from jView_tiempos_equipos
                  where [name] in ('FL231','FL230') and Fecha = CONVERT(char(10), GETDATE()-1, 101) 
                  and shift_id = 524


              if (DATEPART(HH, GETDATE()) between  8 and 19) 
                  select @PI_TONMOV =  isnull(sum(material_tonnage),0) FROM dbo.by_detail_loads bd
                                    WHERE time = CONVERT(char(10), GETDATE(), 101) and shift = 'A'
                                    AND shovel  in ('FL231','FL230')
                                    AND bd.deleted_at is null
              if (DATEPART(HH, GETDATE()) between  20 and 23)
                  select @PI_TONMOV =  isnull(sum(material_tonnage),0) FROM dbo.by_detail_loads bd
                                    WHERE time = CONVERT(char(10), GETDATE(), 101)  and shift = 'B'
                                    AND shovel  in ('FL231','FL230')
                                    AND bd.deleted_at is null

               if (DATEPART(HH, GETDATE())  between  0 and 7)
                  select @PI_TONMOV =  isnull(sum(material_tonnage),0) FROM dbo.by_detail_loads bd
                                    WHERE time = CONVERT(char(10), GETDATE()-1, 101)  and shift = 'B'
                                    AND shovel  in ('FL231','FL230')
                                    AND bd.deleted_at is null                             



  select  isnull(@PI_TONMOV / nullif((@PI_HORASOP),0),0)  as PI_VALUE;