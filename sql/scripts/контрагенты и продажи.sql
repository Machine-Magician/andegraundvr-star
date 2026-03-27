SELECT distinct nomenklatura._Description as [Номенклатура],
                DATEADD(year, -2000, [Дата]) as [Дата],
                [Количество],
                [Цена],
                [Сумма],
                [НДС],
				kontrag._Description as [Контрагент],
                organ._Description as [Организация],
				SSO._description as [город]
            FROM [ВитринаДанных].[dbo].[ПродажиПервичные] as vypuskProduktNakoplenie
            inner join [onec-9].upp_2012.dbo._Reference154 as nomenklatura
                on nomenklatura._Idrref=vypuskProduktNakoplenie.[НоменклатураИД]
            left join [onec-9].upp_2012.dbo._Reference124 as kontrag
                on kontrag._Idrref=vypuskProduktNakoplenie.[КонтрагентИД]
            left join [onec-9].upp_2012.dbo._Reference164 as organ
                on organ._Idrref=vypuskProduktNakoplenie.[ОрганизацияИД]
           left join [onec-9].upp_2012.dbo._InfoRg19780 as zna4svoy
                on zna4svoy._fld19781_RRRef=vypuskProduktNakoplenie.[ОрганизацияИД]
		   left join [onec-9].upp_2012.dbo._InfoRg19780 as obect
				on obect._fld19781_rrref=kontrag._idrref
			left join [onec-9].upp_2012.dbo._Chrc1140 as svoystvoOB
				on svoystvoOB._idrref=obect._fld19782rref
			left join [onec-9].upp_2012.dbo._reference97 as SSO
				on SSO._idrref=obect._fld19783_rrref
		   

            WHERE  DATEADD(year, -2000, [Дата]) > '2025-01-01'
			and svoystvoOB._description like '%Населенный пункт%'
			ORDER BY [сумма] DESC

	--	SELECT top 1000 *	FROM [ВитринаДанных].[dbo].[ПродажиПервичные] 
	--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._InfoRg19780
	--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._Chrc1140
	--where _description like '%Населенный пункт%'

	--SELECT top 1000 * from  [onec-9].[upp_2012].[dbo]._Inforg60821
	--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference124
	--SELECT top 1000 *	FROM [onec-9].upp_2012.dbo._reference97

	--SELECT count(_fld19781_rrref)	FROM [onec-9].upp_2012.dbo._InfoRg19780
	--SELECT count(_idrref)	FROM [onec-9].upp_2012.dbo._Chrc1140
	--SELECT count(_idrref)	FROM [onec-9].upp_2012.dbo._reference97