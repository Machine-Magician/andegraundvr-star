select СотрудникиДляПодразд._description
,ДляПодразделений._fld49591rref
,ОВнер._description as Служба
,ФактТабель._fld49321rref
,Родитель._description as Отдел
,подразделениеОрганизаций._Parentidrref
,подразделениеОрганизаций._description as Участок
,Родитель._Parentidrref
,ид_вес._fld50221_rrref

        
from serv5.hrm_dev.dbo._Document49318_VT49502 as ДляПодразделений

inner join serv5.hrm_dev.dbo._Reference525 as СотрудникиДляПодразд
	on СотрудникиДляПодразд._idrref = ДляПодразделений._fld49591rref
inner join serv5.hrm_dev.dbo._Document49318 as ФактТабель
	on ДляПодразделений._document49318_idrref = ФактТабель._IDRref
left join serv5.hrm_dev.dbo._Reference390 as подразделениеОрганизаций
	on подразделениеОрганизаций._idrref = ФактТабель._fld49321rref

left join serv5.hrm_dev.dbo._Reference390 as Родитель
	on Родитель._idrref = подразделениеОрганизаций._Parentidrref
left join serv5.hrm_dev.dbo._Reference390 as Овнер
	on Овнер._idrref = Родитель._Parentidrref
left join serv5.hrm_dev.dbo._InfoRg50219 as ид_вес
on ид_вес._fld50221_rrref = ДляПодразделений._fld49592_rrref


	where СотрудникиДляПодразд._description = 'Брюханова Нина Андреевна'

	and подразделениеОрганизаций._Parentidrref = 0xAC3300155D007A3711E412567BCCBCD5
	or ФактТабель._fld49321rref = 0xAC3300155D007A3711E412567BCCBCD5 -- подразделение
	or Родитель._Parentidrref = 0xAC3300155D007A3711E412567BCCBCD5
	or подразделениеОрганизаций._fld42565 = 0xAC3300155D007A3711E412567BCCBCD5
	or подразделениеОрганизаций._fld42566rref = 0xAC3300155D007A3711E412567BCCBCD5