
if object_id (N'tempdb..#остаткиНаСкладах') is not null drop table #остаткиНаСкладах;

select nomenklatura._description as Номенклатура,
nomenklatura._code as Код,
VidNom._description as [Вид номеклатуры],
СписокТоварыНаСкладах._fld24845 as Количество,
edIzm._description as [Единица измерения],
ka4estvo._description as Качество,
sklad._description as Склад,
nomenklaturaCKT._description as скт,
nomenklaturaCKT2._description as скт2,
nomenklaturaCKT3._description as скт3,
datefromparts(year(_period)-2000, month(_period), 1) as Дата


into #остаткиНаСкладах
from [onec-9].[upp_2012].[dbo]._AccumRg24839 as СписокТоварыНаСкладах
inner join [onec-9].upp_2012.dbo._Reference154 as nomenklatura
    on nomenklatura._Idrref = СписокТоварыНаСкладах._fld24841rref
left join [onec-9].upp_2012.dbo._Reference107 as ka4estvo
    on ka4estvo._Idrref = СписокТоварыНаСкладах._fld24842rref
left join [onec-9].upp_2012.dbo._Reference218 as sklad
    on sklad._Idrref = СписокТоварыНаСкладах._fld24840rref
left join [onec-9].upp_2012.dbo._Reference91 as edIzm
    on edIzm._Idrref = nomenklatura._fld2730rref
left join [onec-9].upp_2012.dbo._Reference51 as VidNom
    on VidNom._Idrref = nomenklatura._fld2729Rref
left join [onec-9].upp_2012.dbo._Reference154 as nomenklaturaCKT
    on nomenklaturaCKT._Idrref = nomenklatura._parentidrref
left join [onec-9].upp_2012.dbo._Reference154 as nomenklaturaCKT2
    on nomenklaturaCKT2._Idrref = nomenklaturaCKT._parentidrref
left join [onec-9].upp_2012.dbo._Reference154 as nomenklaturaCKT3
    on nomenklaturaCKT3._Idrref = nomenklaturaCKT2._parentidrref


where datefromparts(year(_period)-2000, month(_period), 1) > '2025-01-01'
--where ka4estvo._description like '%брак%'

--SELECT top 1000 * from #остаткиНаСкладах


--SELECT top 1000 * from  [onec-9].[upp_2012].[dbo]._AccumRg24839
--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference107  -- качество
--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference218 -- склад
--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference124 -- контрагент
--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference154 -- номенклатура
--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference91 -- единицы изм
--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference51 -- виды нмоенклатуры



--- вкладка брак сегодня Отчеты -> Запасы -> Товары на складах. Настройка Зюзяев "Для Зюзяева Брак".
if object_id (N'tempdb..#остаткиНаСкладахБрак') is not null drop table #остаткиНаСкладахБрак;
select  
Номенклатура,
Код,
sum(Количество) as КоличествоСуммарно,
[Единица измерения],
Качество,
Склад,
скт3,
Дата
into #остаткиНаСкладахБрак
from #остаткиНаСкладах





where Качество like '%брак%'
and (Склад like '%Склад неликвидов вспомогательных материалов СПК%' or
Склад like '%Склад неликвидов вспомогательных материалов МПК%' or
Склад like '%Склад неликвидов вспомогательных материалов База%')
and скт3 like '%СКТ%'


group by 
Номенклатура,
Код,
[Единица измерения],
Качество,
Склад,
скт3,
Дата

--SELECT top 1000 * from #остаткиНаСкладахБрак
--where (Номенклатура like '%Щепа ольховая%' or скт like '%Щепа ольховая%' or скт2 like '%Щепа ольховая%' or скт3 like '%Щепа ольховая%')


--- вкладка брак на складах Отчеты -> Запасы -> Товары на складах. Настройка Зюзяев "Для Зюзяева 1". Блок "Брак"

if object_id (N'tempdb..#остаткиНаСкладахБрак1') is not null drop table #остаткиНаСкладахБрак1;
select  
Номенклатура,
Код,
sum(Количество) as КоличествоСуммарно,
[Единица измерения],
Качество,
Склад,
скт3,
Дата
into #остаткиНаСкладахБрак1
from #остаткиНаСкладах





where Качество like '%брак%'
and (Склад not like '%Склад неликвидов СПК (утилизация)%' or
Склад not like '%Склад неликвидов вспомогательных материалов СПК%' or
Склад not like '%Склад неликвидов вспомогательных материалов База%' or
Склад not like '%Склад неликвидов МПК (утилизация)%' or
Склад not like '%Склад неликвидов вспомогательных материалов МПК%' or
Склад not like '%Склад неликвидов База (утилизация)%' or
Склад not like '%Лаборатория МПК%' or
Склад not like '%Лаборатория СПК%'
)
and скт3 like '%СКТ%'
and (Номенклатура like '%Сырная масса монолит полиэтилен 20кг, п/ф%' or
Номенклатура like '%Вегастар 36-36, п/ф%' or
Номенклатура like '%Олеин, п/ф%' or
Номенклатура like '%Oilblend 1503-33 TF ЭК, п/ф%'
)

group by 
Номенклатура,
Код,
[Единица измерения],
Качество,
Склад,
скт3,
Дата

--SELECT top 1000 * from #остаткиНаСкладахБрак1


