EXEC sp_configure 'remote query timeout', 5 ;
GO
RECONFIGURE ;
GO

BEGIN TRANSACTION timeoutRollback;
GO

	BEGIN TRY
		SELECT
        ParqueNacional.Nombre
		FROM GREEN_TEC.GREEN_TEC.ParqueNacional
		WHERE ParqueNacional.IdParqueNacional = 1
		WAITFOR DELAY '00:00:10'
		COMMIT TRANSACTION timeoutRollback;

	END TRY

	BEGIN CATCH
		 ROLLBACK TRANSACTION timeoutRollback;
	END CATCH