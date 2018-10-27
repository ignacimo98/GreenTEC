USE GREEN_TEC
GO

DECLARE @fileData XML

-- Se importa el contenido del archivo a la variable @ filedata
SELECT @fileData = BulkColumn
FROM OpenRowSet(BULK 'Especie.xml', SINGLE_BLOB) x;

-- Inserción en masa en la tabla Especie
INSERT INTO GREEN_TEC.Especie (NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo)
SELECT xData.value('NombreVulgar[1]', 'VARCHAR(45)')     NombreVulgar,
       xData.value('NombreCientifico[1]', 'VARCHAR(45)') NombreCientifico,
       xData.value('IdCaracteristica[1]', 'INT')         IdCaracteristica,
       xData.value('IdTipoEspecie[1]', 'INT')            IdTipoEspecie,
       xData.value('IdPeriodo[1]', 'INT')                IdPeriodo
FROM @fileData.nodes('/data/row') AS x (xData) -- path en el xml