--CURSOR GLOBAL
/* Los cursores globales son cursores que pueden ser accesados en cualquier parte del programa una vez declarados
Al crear un cursor, su default es ser Global a menos que se indique lo contrario*/
USE GREEN_TEC

BEGIN TRAN
DECLARE UsosCarrosGlobal CURSOR FOR SELECT IdVehiculo
                                    FROM GREEN_TEC.GREEN_TEC.Vehiculo
PRINT 'Crea el Cursor'
OPEN UsosCarrosGlobal;

FETCH FROM UsosCarrosGlobal;
PRINT 'Inicia While'
WHILE @@fetch_status = 0 --Indica que el cambio de cursor fue correcto (es la condicion de parada)
  BEGIN
    UPDATE GREEN_TEC.Vehiculo SET Usos = 1 WHERE CURRENT OF UsosCarrosGlobal
    FETCH NEXT FROM UsosCarrosGlobal
  END
PRINT 'End While'
CLOSE UsosCarrosGlobal
DEALLOCATE UsosCarrosGlobal
PRINT 'Cursor cerrado y deasignado'

COMMIT
