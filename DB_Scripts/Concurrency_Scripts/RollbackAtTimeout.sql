USE GREEN_TEC

--Se configura el tiempo de timeout
SET LOCK_TIMEOUT 2000;

-- EXEC sp_configure 'remote query timeout', 1 ;
-- GO
-- RECONFIGURE ;
-- GO

PRINT 'Inicia TRY'
BEGIN TRY
  BEGIN TRAN
  WAITFOR DELAY '00:00:02'
  INSERT INTO GREEN_TEC.Especie(NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo)
  VALUES ('Conejo de Pradera','Oryctolagus cuniculus ',3,1,8)
  COMMIT
  PRINT 'Transaction committed'
END TRY
BEGIN CATCH
  PRINT 'Entra en el CATCH'
  IF(@@TRANCOUNT > 0)
	BEGIN
		ROLLBACK
    PRINT 'Transaction rolled back'
	END;
  PRINT 'Ejecuta el Throw'
  THROW;
END CATCH
PRINT 'Sale del CATCH'
