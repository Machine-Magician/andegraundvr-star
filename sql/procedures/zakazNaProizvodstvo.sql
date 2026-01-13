USE [upp_2012]
GO
/****** Object:  StoredProcedure [dbo].[Своевременность выдачи КЗ (KPI)]   Script Date: 21.11.2025 13:33:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

ALTER PROCEDURE [dbo].[Своевременность выдачи КЗ (KPI)]
as
BEGIN


---- первый шаг заказ на производство (для Луневой)
if object_id (N'tempdb..#заказНаПроизвосдтво') is not null drop table #заказНаПроизвосдтво;
SET LANGUAGE Russian;

select 

	datefromparts(year(_Date_time)-2000, month(_Date_time), 1) as [Дата план]
	,_Date_time as [Дата для вычислений]
	,DATENAME(month, _Date_time) AS [месяц]
	,Podrazdelen._description as Подразделения
	,Polzovatel._description as Ответственный
	,_fld6529 as Комментарий
	,_number as Номер
	,versii._fld50972 as [Версии Комментарии]
	,_fld51892 as Маркировка
	,_fld56037 as Допработы
	,versii._fld50971 as [Время подачи]
	,DATEDIFF(second, versii._fld50971, _Date_time) / 3600 AS [Разница в часах]
	,CASE 
        WHEN DATEDIFF(SECOND, versii._fld50971, _Date_time) / 3600.0 <= 24 THEN 1
        ELSE 0
    END as [Своевременно],
    CASE 
        WHEN DATEDIFF(SECOND, versii._fld50971, _Date_time) / 3600.0 > 24 THEN 1
        ELSE 0
    END as [Не своевременно]

into #заказНаПроизвосдтво
from [onec-9].upp_2012.dbo._Document347 as zakazNaproizvodstvo
inner join [onec-9].upp_2012.dbo._Document347_VT50969 as versii
	on versii._Document347_Idrref=zakazNaproizvodstvo._Idrref
inner join [onec-9].upp_2012.dbo._Reference186 as Polzovatel
	on Polzovatel._Idrref=zakazNaproizvodstvo._fld6532rref
left join [onec-9].upp_2012.dbo._Reference182 as Podrazdelen
	on  Podrazdelen._IDRRef = zakazNaproizvodstvo._fld6533rref


where (Podrazdelen._description not like '%экспериментальн%')
--where vetis._code <> 000000003
and Podrazdelen._description not like '%промышленны%'
and _fld56037 = 0x01
and _fld51892 = 0x00






--select  * from #заказНаПроизвосдтво
--where Маркировка = 0x00
---select * from [onec-9].upp_2012.dbo._Document347
--select * from [onec-9].upp_2012.dbo._Document347_VT50969
--select * from [onec-9].upp_2012.dbo._Reference186 --пользователи
--select * from [onec-9].upp_2012.dbo._Reference182 --подразделения


--- шаг 2 посчет процентов


if object_id (N'tempdb..#ПодсчетПроцентов') is not null drop table #ПодсчетПроцентов;
SELECT 
    [Дата план],
    [Дата для вычислений],
    [месяц],
    Подразделения,
    Ответственный,
    --Комментарий,
    Номер,
    [Версии Комментарии],
    Маркировка,
    Допработы,
    [Время подачи],
    [Разница в часах],
    [Своевременно],
    [Не своевременно],
	-- Проценты
    SUM([Своевременно]) OVER(PARTITION BY Ответственный, [Дата план]) + SUM([Не своевременно]) OVER(PARTITION BY Ответственный, [Дата план]) AS СуммаОчковРаботника
	,CASE 
        WHEN COUNT(*) OVER(PARTITION BY [Дата план], Ответственный) > 0 
        THEN ROUND(100.0 * SUM([Своевременно]) OVER(PARTITION BY [Дата план], Ответственный) / 
             COUNT(*) OVER(PARTITION BY [Дата план], Ответственный), 0)
        ELSE 0 
    END as [Процент своевременных],
    -- Процент несвоевременных записей
    CASE 
        WHEN COUNT(*) OVER(PARTITION BY [Дата план], Ответственный) > 0 
        THEN ROUND(100.0 * SUM([Не своевременно]) OVER(PARTITION BY [Дата план], Ответственный) / 
             COUNT(*) OVER(PARTITION BY [Дата план], Ответственный), 0)
        ELSE 0 
    END as [Процент не своевременных]

into #ПодсчетПроцентов
from #заказНаПроизвосдтво

group by [Дата план],
    [Дата для вычислений],
    [месяц],
    Подразделения,
    Ответственный,
    --Комментарий,
    Номер,
    [Версии Комментарии],
    Маркировка,
    Допработы,
    [Время подачи],
    [Разница в часах],
    [Своевременно],
    [Не своевременно]

--select  

--    Ответственный,
--	[месяц],
--    [Своевременно],
--    [Не своевременно],
--	СуммаОчковРаботника,
--	[Процент своевременных],
--	[Процент не своевременных]
--	 from #ПодсчетПроцентов
--where [Дата план] > '2025-01-01'


-----шаг итоговый создание таблицы в базе данных
--- создание таблицы впервые
--SELECT 
--    Ответственный,
--    [месяц],
--    [Своевременно],
--    [Не своевременно],
--    СуммаОчковРаботника,
--    [Процент своевременных],
--    [Процент не своевременных]


--INTO [Мониторинг].[dbo].[Своевременность выдачи КЗ (KPI)] from #ПодсчетПроцентов
--WHERE [Дата план] > '2025-01-01'


-- перезапись таблицы в ходе работы процедуры
delete  from [Мониторинг].[dbo].[Своевременность выдачи КЗ (KPI)];
insert into [Мониторинг].[dbo].[Своевременность выдачи КЗ (KPI)]
select  
    Ответственный,
    [месяц],
    [Своевременно],
    [Не своевременно],
    СуммаОчковРаботника,
    [Процент своевременных],
    [Процент не своевременных]

from #ПодсчетПроцентов
WHERE [Дата план] > '2025-01-01'



end


-- select * from [Мониторинг].[dbo].[Своевременность выдачи КЗ (KPI)] 

