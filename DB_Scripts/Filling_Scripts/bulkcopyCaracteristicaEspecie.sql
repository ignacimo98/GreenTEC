USE GREEN_TEC
GO

DECLARE @fileData XML

-- Se importa el contenido del archivo a la variable @ filedata
SELECT @fileData = BulkColumn FROM OpenRowSet(BULK 'CaracteristicaEspecie.xml',SINGLE_BLOB ) x;

-- Inserción en masa en la tabla CaracteristicaEspecie
INSERT INTO GREEN_TEC.CaracteristicaEspecie
	(Nombre, Valor)
SELECT
	xData.value('Nombre[1]', 'VARCHAR(45)') Nombre,
	xData.value('Valor[1]', 'VARCHAR(45)') Valor
FROM @fileData.nodes('/data/row') AS x(xData) -- path en el xml