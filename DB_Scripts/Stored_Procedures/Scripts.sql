--Crea un procedimiento transaccional que escribe en cuatro tablas
CREATE PROCEDURE EscrituraTablas
AS
  BEGIN TRAN
  BEGIN TRY
  PRINT 'Insercion 1';
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[Vehiculo] ([Tipo], [Matricula])
  VALUES ('PickUp', 'KBP798');
  PRINT 'Insercion 2';
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[Tour] ([Nombre], [Descripcion])
  VALUES ('Avistamiento de felinos', 'Caminata por los bosques para alimentar y convivir con felinos');
  PRINT 'Insercion 3';
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[ParqueNacional] ([Nombre], [FechaDeclaracion])
  VALUES ('Parque Nacional Marino Ballena', '1980-11-10');
  PRINT 'Insercion 4';
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[Visitante] ([Cedula], [Nombre], [Domicilio], [Profesion])
  VALUES (280489389, 'Jerry Arias', 'Cartago, Costa Rica', 'Estudiante');
  COMMIT TRAN
  PRINT 'Transaccion comitteada'
  END TRY
  BEGIN CATCH
  PRINT 'Error: Rollback'
  ROLLBACK TRAN
  END CATCH

  PRINT 'Transaccion finalizada'
GO

--queries para crear un stored procedure transaccional de nivel dos con rollback

CREATE PROCEDURE InsertarCaracteristicaRollback
AS
  BEGIN TRAN
  BEGIN TRY

  PRINT 'Insertando en CaracteristicaEspecie'
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[CaracteristicaEspecie] ([Nombre], [Valor])
  VALUES (6 / 0, 6); --error
  PRINT 'Insertando en CaracteristicaPersonal'
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[CaracteristicaPersonal] ([Nombre], [Valor])
  VALUES (6 / 0, 6); --error
  COMMIT TRAN
  PRINT 'Transaccion comitteada'

  END TRY
  BEGIN CATCH

  PRINT 'Error: Rollback'
  ROLLBACK TRAN

  END CATCH

  PRINT 'Transaccion finalizada'
GO

CREATE PROCEDURE ObtenerParquesNacionalesRollback
AS
  BEGIN TRAN
  BEGIN TRY
  PRINT 'Obteniendo Parques'
  SELECT [Nombre], [FechaDeclaracion]
  FROM [GREEN_TEC].[GREEN_TEC].[ParqueNacional];

  PRINT 'Obteniendo Comunidades'
  SELECT C.[Nombre]
  FROM [GREEN_TEC].[GREEN_TEC].[ParqueNacional] PN
         INNER JOIN [GREEN_TEC].[GREEN_TEC].[ParqueXComunidad] PC ON PN.[IdParqueNacional] = PC.[IdParqueNacional]
         INNER JOIN [GREEN_TEC].[GREEN_TEC].[Comunidad] C ON PC.[IdComunidad] = C.[IdComunidad]
  GROUP BY C.[IdComunidad], C.[Nombre];

  PRINT 'Iniciando InsertarCaracteristicaRollback'
  EXECUTE InsertarCaracteristicaRollback;
  COMMIT TRAN
  PRINT 'Transaccion comitteada'

  END TRY
  BEGIN CATCH

  PRINT 'Error: Rollback'
  ROLLBACK TRAN

  END CATCH

  PRINT 'Transaccion finalizada'
GO


CREATE PROCEDURE ObtenerOrganismosRollback
AS
  BEGIN TRAN
  BEGIN TRY

  PRINT 'Obteniendo Organismos'
  SELECT [Nombre]
  FROM [GREEN_TEC].[GREEN_TEC].[Organismo];

  PRINT 'Obteniendo Comunidades'
  SELECT [Nombre]
  FROM [GREEN_TEC].[GREEN_TEC].[Comunidad];

  PRINT 'Iniciando ObtenerParquesNacionales'
  EXECUTE ObtenerParquesNacionalesRollback;
  COMMIT TRAN
  PRINT 'Transaccion comitteada'

  END TRY
  BEGIN CATCH

  IF (@@TRANCOUNT > 1)
    BEGIN
      PRINT 'Error: Rollback'
      ROLLBACK TRAN
    END

  END CATCH

  PRINT 'Transaccion finalizada'
GO

--queries para crear un stored procedure transaccional de nivel dos con exito

CREATE PROCEDURE InsertarCaracteristicaExito
AS
  BEGIN TRAN
  BEGIN TRY

  PRINT 'Insertando en CaracteristicaEspecie'
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[CaracteristicaEspecie] ([Nombre], [Valor])
  VALUES ('Color', 'Rojo'); --no error
  PRINT 'Insertando en CaracteristicaPersonal'
  INSERT INTO [GREEN_TEC].[GREEN_TEC].[CaracteristicaPersonal] ([Nombre], [Valor])
  VALUES ('Altura', '1.54'); --no error
  COMMIT TRAN
  PRINT 'Transaccion comitteada'

  END TRY
  BEGIN CATCH

  PRINT 'Error: Rollback'
  ROLLBACK TRAN

  END CATCH
  PRINT 'Transaccion finalizada'

GO

CREATE PROCEDURE ObtenerParquesNacionalesExito
AS
  BEGIN TRAN
  BEGIN TRY
  PRINT 'Obteniendo Parques'
  SELECT [Nombre], [FechaDeclaracion]
  FROM [GREEN_TEC].[GREEN_TEC].[ParqueNacional];

  PRINT 'Obteniendo Comunidades'
  SELECT C.[Nombre]
  FROM [GREEN_TEC].[GREEN_TEC].[ParqueNacional] PN
         INNER JOIN [GREEN_TEC].[GREEN_TEC].[ParqueXComunidad] PC ON PN.[IdParqueNacional] = PC.[IdParqueNacional]
         INNER JOIN [GREEN_TEC].[GREEN_TEC].[Comunidad] C ON PC.[IdComunidad] = C.[IdComunidad]
  GROUP BY C.[IdComunidad], C.[Nombre];

  PRINT 'Iniciando InsertarCaracteristicaRollback'
  EXECUTE InsertarCaracteristicaExito;
  COMMIT TRAN
  PRINT 'Transaccion comitteada'

  END TRY
  BEGIN CATCH

  PRINT 'Error: Rollback'
  ROLLBACK TRAN

  END CATCH

  PRINT 'Transaccion finalizada'
GO


CREATE PROCEDURE ObtenerOrganismosExito
AS
  BEGIN TRAN
  BEGIN TRY

  PRINT 'Obteniendo Organismos'
  SELECT [Nombre]
  FROM [GREEN_TEC].[GREEN_TEC].[Organismo];

  PRINT 'Obteniendo Comunidades'
  SELECT [Nombre]
  FROM [GREEN_TEC].[GREEN_TEC].[Comunidad];

  PRINT 'Iniciando ObtenerParquesNacionales'
  EXECUTE ObtenerParquesNacionalesExito;
  COMMIT TRAN
  PRINT 'Transaccion comitteada'

  END TRY
  BEGIN CATCH

  PRINT 'Error: Rollback'
  ROLLBACK TRAN

  END CATCH

  PRINT 'Transaccion finalizada'
GO

--stored procedure para cargar datos de archivo xml
CREATE PROCEDURE InsertarCaracteristicaXMLParametros
    @Ruta VARCHAR(100)
AS
  BEGIN
    SET NOCOUNT ON;
    PRINT 'Leyendo XML'
    DECLARE @xml XML
    DECLARE @SQL NVARCHAR(1000) = 'SET @xml = (SELECT * FROM OPENROWSET (BULK ''' + @Ruta +
                                  ''', SINGLE_CLOB) AS XmlData)'

    EXECUTE sp_executesql @SQL, N'@xml XML OUTPUT', @xml OUTPUT;

    PRINT 'Insertando datos en tabla'
    INSERT INTO [GREEN_TEC].[GREEN_TEC].[CaracteristicaPersonal]

    SELECT row.value('(Nombre/text())[1]', 'VARCHAR(100)') AS Nombre,
           row.value('(Valor/text())[1]', 'VARCHAR(100)')  AS Valor
    FROM @xml.nodes('/data/row') AS Listing (row);
    PRINT 'Finalizado'

  END



  --stored procedure que utiliza tabled-value parameters

  --Crea una tabla de tipo
  PRINT 'Creando tabla de tipo'
  CREATE TYPE TIPOCARACTERISTICA AS TABLE
  ( NombreCaracteristica VARCHAR(50)
  , ValorCaracteristica  VARCHAR(50));
GO

--Crea un procedimiento que recibe una TVP 
PRINT 'Creando procedimiento que recibe TVP'
CREATE PROCEDURE InsertarCaracteristicaEspecie
    @TVP TIPOCARACTERISTICA READONLY
AS
  SET NOCOUNT ON
  INSERT INTO [GREEN_TEC].[CaracteristicaEspecie] (Nombre, Valor)
  SELECT *
  FROM @TVP;
GO

--Variable que referencia el tipo
DECLARE @TCE AS TIPOCARACTERISTICA;

PRINT 'Leyendo XML'
DECLARE @xml XML
DECLARE @SQL NVARCHAR(1000) =
'SET @xml = (SELECT * FROM OPENROWSET (BULK ''' + 'M:\MSSQL14.MSSQLSERVER\MSSQL\DATA\CaracteristicasEspecie.xml' +
''', SINGLE_CLOB) AS XmlData)'

EXECUTE sp_executesql @SQL, N'@xml XML OUTPUT', @xml OUTPUT;
PRINT 'Insertando Datos'
--Agrega datos a la tabla 
INSERT INTO @TCE (NombreCaracteristica, ValorCaracteristica)
SELECT row.value('(Nombre/text())[1]', 'VARCHAR(100)') AS Nombre,
       row.value('(Valor/text())[1]', 'VARCHAR(100)')  AS Valor
FROM @xml.nodes('/data/row') AS Listing (row);

--Pasa la tabla variable a un stored procedure  
EXEC InsertarCaracteristicaEspecie @TCE;
GO


--Query con sp_recompile que hace que todos los triggers, stored procedures y funciones sean
--recompiladas la proxima vez que se corran

USE GREEN_TEC
EXEC sp_recompile N'GREEN_TEC.CaracteristicaPersonal';

--Query puede actualizar e insertar datos a la misma vez, funciona de manera que si el
--valor en la columna es igual a alguno en la tabla objetivo entonces se actualiza el valor
--a un nuevo valor, mientras que si no es igual entonces se agrega el registro con los
--valores en el insert

-- Crea una tabla temporal para mostrar los cambios  
DECLARE @Cambios TABLE(Cambio VARCHAR(20));

MERGE INTO GREEN_TEC.CaracteristicaEspecie AS TARGET
USING (VALUES ('Comportamiento', 'Agresivo'),
              ('Comportamiento', 'Timido'))
  AS SOURCE (NuevaCaracteristica, NuevoValor)
ON TARGET.Valor = SOURCE.NuevoValor
WHEN MATCHED THEN
  UPDATE SET Valor = Source.NuevoValor
WHEN NOT MATCHED BY TARGET THEN
  INSERT (Nombre, Valor) VALUES (NuevaCaracteristica, NuevoValor)
--agrega la accion realizada a la tabla de cambios
OUTPUT $action INTO @Cambios;

--muestra los resultados de cuantos cambios se realizaron por cada accion 
SELECT Cambio, COUNT(*) AS CantidadCambios
FROM @Cambios
GROUP BY Cambio;

--Query que asigna a PrimerNoNulo el valor de la primera columna en el orden dado que no sea nulo
SELECT IdEspecie, IdCaracteristica, IdPeriodo, IdTipoEspecie, COALESCE(IdPeriodo, IdEspecie) AS PrimerNoNulo
FROM GREEN_TEC.Especie;

--Query que devuelve dada una columna, una cantidad 4 de caracteres a partir de la posicion 1
SELECT NombreVulgar, SUBSTRING(NombreCientifico, 1, 4) AS CuatroPrimeros
FROM GREEN_TEC.Especie;

--Query que devuelve una cadena de caracteres sin espacios en blanco adelante'
SELECT LTRIM('         Devuelve una cadena de caracteres sin espacios en blanco adelante')

--Devuelve los primeros 1000 resultados de una tabla
SELECT TOP (1000) Nombre, Profesion
FROM [GREEN_TEC].[GREEN_TEC].[Visitante];

--Cambia el contexto de ejecución a un usuario o inicio de sesión específicos
EXECUTE AS USER = 'jimena'
--Muestra el usuario actual
SELECT SUSER_NAME(), USER_NAME();
