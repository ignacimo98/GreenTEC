USE GREEN_TEC
GO

DECLARE @fileData XML

-- Se importa el contenido del archivo a la variable @ filedata
SELECT @fileData = BulkColumn FROM OpenRowSet(BULK 'Organismo.xml',SINGLE_BLOB ) x;

-- Inserción en masa en la tabla CaracteristicaEspecie
INSERT INTO GREEN_TEC.Organismo
	(Nombre)
SELECT
	xData.value('Nombre[1]', 'VARCHAR(45)') Nombre
FROM @fileData.nodes('/data/row') AS x(xData) -- path en el xml