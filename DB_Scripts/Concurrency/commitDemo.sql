-- Set our starting point of the transaction, useful for commits and rollbacks
BEGIN TRANSACTION commitDemo;
GO

	-- Lets modify data by running this block and
	-- then try to select it from another query
	-- blocks select
	UPDATE GREEN_TEC.GREEN_TEC.ParqueNacional
	SET ParqueNacional.Nombre = 'Parque Nacional Raul Madrigal'
	WHERE ParqueNacional.IdParqueNacional = 1
	WAITFOR DELAY '00:00:30'
	GO

COMMIT TRANSACTION commitDemo;