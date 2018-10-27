--CURSOR LOCAL
/* Los cursores locales son cursores NO que pueden ser accesados de cualquier parte
Estos solo pueden ser accesados desde su batch respectivo*/

USE GREEN_TEC
PRINT 'Crea el Cursor local'
DECLARE UsosCarroLocal CURSOR LOCAL FOR SELECT IdVehiculo
                                        FROM GREEN_TEC.GREEN_TEC.Vehiculo
OPEN UsosCarroLocal

FETCH NEXT FROM UsosCarroLocal
PRINT 'Inicia While'
WHILE @@fetch_status = 0 --Indica que el cambio de cursor fue correcto (es la condicion de parada)
  BEGIN
    UPDATE GREEN_TEC.Vehiculo SET Usos = 1 WHERE CURRENT OF UsosCarroLocal
    FETCH NEXT FROM UsosCarroLocal
  END
PRINT 'End While'
CLOSE UsosCarroLocal
DEALLOCATE UsosCarroLocal
PRINT 'Cursor cerrado y deasignado'
