--Cursores
/*
En este Caso se muestra como mediante el cursor avanza, se bloquea el acceso en los datos a los que ingresa
Se deben ejecutar los dos cursores al mismo tiempo, se puede observar que en el segundo se genera un Deadlock
*/

USE GREEN_TEC
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRAN
WAITFOR DELAY '00:00:05'
  DECLARE UsosCarros CURSOR SCROLL FOR SELECT IdVehiculo FROM GREEN_TEC.GREEN_TEC.Vehiculo

  OPEN UsosCarros;

  FETCH FROM UsosCarros;
  PRINT 'Inicia While'
  WHILE @@fetch_status = 0
    BEGIN
      UPDATE GREEN_TEC.Vehiculo
      SET Usos = 1
      WHERE CURRENT OF UsosCarros
      --WAITFOR DELAY '00:00:05'
      FETCH NEXT FROM UsosCarros
    END
  PRINT 'End While'
  CLOSE UsosCarros
  DEALLOCATE UsosCarros

COMMIT

---------------------------------------------------------------------

USE GREEN_TEC
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRAN

  DECLARE UsosCarros2 CURSOR SCROLL FOR SELECT IdVehiculo FROM GREEN_TEC.Vehiculo

  OPEN UsosCarros2;

  FETCH LAST FROM UsosCarros2;
  PRINT 'Inicia While'
  WHILE @@fetch_status = 0
    BEGIN
      UPDATE GREEN_TEC.Vehiculo
      SET Usos = 0
      WHERE CURRENT OF UsosCarros2
     -- WAITFOR DELAY '00:00:05'
      FETCH PRIOR FROM UsosCarros2
    END
  PRINT 'End While'
  CLOSE UsosCarros2
  DEALLOCATE UsosCarros2

COMMIT

---------------------------------------------------------------------
-- Para probar como se van bloqueando Id por Id cuando el cursor avanza
SELECT * FROM GREEN_TEC.GREEN_TEC.Vehiculo WHERE IdVehiculo = #