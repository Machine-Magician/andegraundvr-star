---- первый шаг заказ на производство (для Луневой)
if object_id (N'tempdb..#заказНаПроизвосдтво') is not null drop table #заказНаПроизвосдтво;
select 

	datefromparts(year(_Date_time)-2000, month(_Date_time), 1) as [Дата план]
	,Podrazdelen._description as Подразделения
	,Polzovatel._description as Ответсвенный
	,_fld6529 as Комментарий
	,_number as Номер
	,versii._fld50972 as [Версии Комментарии]
	,_fld51892 as Маркировка
	,_fld56037 as Допработы
	----,PPVT._fld12279_rrref as [Наименование ГП]
	--,KontrAgents._description as [контрагент]
	--, GP._Fld2719 as артикул
	--, GP._Description as [наименование ГП план]
	--, vetis._code as [контролируется в Меркурии код]
	--, vetis._Description as [контролируется в Меркурии]
	--, svoistvaObyektov._Description as [значение свойств]
	--, svoistvaObyektov1._Description as [группа аналитики]
	--, GP._idrref as [ИД ГП по плану]
	--,PPVT._fld12283 as [количество план]
	--,_Fld12271 as [сумма документа план]
	--,PPVT._Fld12284 as [цена план]
	----,PPVT._Fld12285 as [сумма мбПланпродаж]
	----,PPVT._Fld12287 as [сумма с НДС]
	--,Mercury._Fld55328 as [расход по Меркурию]
	--,sum(PPVT._Fld12283) over (partition by GP._Description) as сумм_кг_План_по_ГП
	--,CASE
	--	when (GP._Description like '%72,5%') THEN (sum(PPVT._Fld12283) over (partition by GP._Description))/1000*Mercury._Fld55328		
	--end as [Плановый расход 72]
	--,CASE
	--	when (GP._Description like '%82,5%') THEN (sum(PPVT._Fld12283) over (partition by GP._Description))/1000*Mercury._Fld55328
	--end as [Плановый расход 82]
into #заказНаПроизвосдтво
from [onec-9].upp_2012.dbo._Document347 as zakazNaproizvodstvo
inner join [onec-9].upp_2012.dbo._Document347_VT50969 as versii
	on versii._Document347_Idrref=zakazNaproizvodstvo._Idrref
inner join [onec-9].upp_2012.dbo._Reference186 as Polzovatel
	on Polzovatel._Idrref=zakazNaproizvodstvo._fld6532rref
left join [onec-9].upp_2012.dbo._Reference182 as Podrazdelen
	on  Podrazdelen._IDRRef = zakazNaproizvodstvo._fld6533rref
--inner join [onec-9].upp_2012.dbo._InfoRg55325 as Mercury --- не план выпуска ГП, а план сырья
--	on  Mercury._Fld55326RRef = GP._IDRRef
--left join [onec-9].upp_2012.dbo._Reference49113 as vetis
--	on  vetis._idrref = GP._fld49888rref
--left join [onec-9].upp_2012.dbo._inforg19780 as svoistvo
--	on  svoistvo._fld19781_rrref = GP._idrref
--left join [onec-9].upp_2012.dbo._Reference97 as svoistvaObyektov
--	on  svoistvaObyektov._idrref = svoistvo._fld19783_rrref
--left join [onec-9].upp_2012.dbo._chrc1140 as svoistvaObyektov1
--	on  svoistvaObyektov1._idrref = svoistvo._fld19782rref

--where (GP._Description like '%82,5%' or GP._Description like '%72,5%')
--where vetis._code <> 000000003
--and svoistvaObyektov1._Description = 'группа аналитики'
--and (svoistvaObyektov._Description like '%82,5%' or svoistvaObyektov._Description like '%72,5%')
--and KontrAgents._description not like '%@%'
--	--- добавляем условие вывода за прошлый месяц
--and datefromparts(year(planProd._Date_time)-2000, month(planProd._Date_time), 1) = 
--    CASE 
--        WHEN MONTH(GETDATE()) = 1 
--            THEN DATEFROMPARTS(YEAR(GETDATE())-1, 12, 1)
--        ELSE DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE())-1, 1)
--    END

--select top 10000 * from #заказНаПроизвосдтво
---select * from [onec-9].upp_2012.dbo._Document347
--select * from [onec-9].upp_2012.dbo._Document347_VT50969
--select * from [onec-9].upp_2012.dbo._Reference186 --пользователи
--select * from [onec-9].upp_2012.dbo._Reference182 --подразделения



--order by дата desc
--where наименование like '%82%'
--select  count(distinct[Ответсвенный]) from #заказНаПроизвосдтво


---select * from [onec-9].upp_2012.dbo._Reference154
---select * from [onec-9].upp_2012.dbo._Reference49113
---select * from [onec-9].upp_2012.dbo._inforg19780
---select * from [onec-9].upp_2012.dbo._chrc1140
---select * from [onec-9].upp_2012.dbo._chrc1137
---select * from [onec-9].upp_2012.dbo._Reference97
---select * from [onec-9].upp_2012.dbo._Document493_VT12277

