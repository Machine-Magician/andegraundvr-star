USE [СлужебнаяДляОтчетов]
GO
/****** Object:  StoredProcedure [dbo].[АКБ план первичный]    Script Date: 16.01.2026 11:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

create PROCEDURE [dbo].[АКБ план первичный]
as
BEGIN


if object_id (N'tempdb..#АКБ_план_первичный_0') is not null drop table #АКБ_план_первичный_0;

select 

новоеПоле._fld1780rref as [Территория продаж]
,новоеПоле._fld1781rref as [Канал сбыта]
,новоеПоле._fld1782rref as [Группа SKU]
,новоеПоле._fld1783 as [АКБ план]

into #АКБ_план_первичный_0
from [ONEC-9].counterpart.dbo._document1544_vt1778 as новоеПоле




--select distinct * from #АКБ_план_первичный_0








--select * from [ONEC-9].counterpart.dbo._document1544
--select * from serv5.hrm_dev.dbo._Document49318 ---ФактТабель
--select * from serv5.hrm_dev.dbo._Document49318_VT49332 --данныеОвремени
--select * from serv5.hrm_dev.dbo._Document49318_VT49500 -- ПокПеремчасти
--select * from serv5.hrm_dev.dbo._Document49318_VT49502 -- ДляПодразделений
--select * from serv5.hrm_dev.dbo._Document49318_VT49498 -- Переработки
--where _fld49578rref = 0x80EC00155D037F0711EEFCA423DC9D73
--select * from serv5.hrm_dev.dbo._Reference302 -- организации
--select * from serv5.hrm_dev.dbo._Reference390 -- ПодразделенияОрганизации 1
--select * from serv5.hrm_dev.dbo._Reference525 -- сотрудники
--select * from serv5.hrm_dev.dbo._Reference148 ---справочник должности
--select * from serv5.hrm_dev.dbo._Reference56513 ---сотрудники доп персонал
--select * from serv5.hrm_dev.dbo._Reference397 ---Справочник.ПоказателиРасчетаЗарплаты
--select * from serv5.hrm_dev.dbo._Reference49534 ---KPI
--select * from serv5.hrm_dev.dbo._InfoRg50219 -- РегистрСведений.ВРА_ПоказателиПеременнойЧасти
--where datefromparts(year(_Period)-2000, month(_Period), 1) like '%2025-01-01%'
--where _fld50221_rrref = 0x85D200155D007AB511E4CD45F188DC5D
--and _fld50221_rrref = 
--and _Period > '4026-01-01'
--order by _period desc


-----шаг 2 создание итоговый создание таблицы в базе данных



delete  from [СлужебнаяДляОтчетов].[dbo].[АКБ_план_первичный];
insert into [СлужебнаяДляОтчетов].[dbo].[АКБ_план_первичный]
select distinct * from #АКБ_план_первичный_0





--drop table [СлужебнаяДляОтчетов].[dbo].[АКБ_план_первичный]
----Временно закомментируйте DELETE и INSERT и раскомментируйте эту строку:
--SELECT * 
--INTO [СлужебнаяДляОтчетов].[dbo].[АКБ_план_первичный]
--FROM #АКБ_план_первичный_0


--CREATE TABLE [СлужебнаяДляОтчетов].[dbo].[АКБ_план_первичный] (
--[Территория продаж] NVARCHAR(255)
--,[Канал сбыта] NVARCHAR(10)
--,[Группа SKU] NVARCHAR(255)
--,[АКБ план] DECIMAL(18,5)  

--);

end
