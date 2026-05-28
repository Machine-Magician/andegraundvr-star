            SELECT DISTINCT magaziny._fld61087 as _Number,
			magnit._fld61083 as data
            FROM [onec-9].upp_2012.dbo._Document61069 AS magnit

            LEFT JOIN [onec-9].upp_2012.dbo._Document61069_VT61084 AS tabl
                ON tabl._document61069_idrref = magnit._idrref
            LEFT JOIN [onec-9].upp_2012.dbo._Reference61066 AS magaziny
                ON magaziny._Idrref = tabl._fld61086rref

				select * from [onec-9].upp_2012.dbo._Document61069


				SELECT SUSER_NAME()
SELECT HAS_DBACCESS('_Document61069') AS HasAccess;

USE [onec-9].upp_2012.dbo._Document61069;
CREATE USER [vra\user0907] FROM LOGIN [vra\user0907];
EXEC sp_addrolemember 'db_datareader', 'vra\user0907';

UPDATE [onec-9].upp_2012.dbo._Document61069
SET _fld61083 = '4026-02-04 00:00:00.000'
WHERE _fld61083 = '4026-04-01 00:00:00.000'



            SELECT DISTINCT *
            FROM [onec-9].upp_2012.dbo._Document61068 AS magnitFitBack
			LEFT JOIN [onec-9].upp_2012.dbo._Document61068_VT61075 AS tabl
                ON tabl._document61068_idrref = magnitFitBack._idrref