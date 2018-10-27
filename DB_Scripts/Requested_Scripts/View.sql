USE [GREEN_TEC]
GO


DROP VIEW IF EXISTS [Datos De Depredadores En Investigacion]
GO

CREATE VIEW [Datos De Depredadores En Investigacion] AS
  SELECT IdProyectoInvestigacion AS [Numero de Proyecto],
         Presupuesto             AS [Presupuesto],
         E.NombreVulgar          AS [Nombre De Depredador en Investigacion],
         CE.Nombre               AS [Caracteristica],
         CE.Valor                AS [Valor],
         E2.NombreVulgar         AS [Nombre De Presa En Investigacion]
  FROM GREEN_TEC.ProyectoInvestigacion AS PI
         INNER JOIN GREEN_TEC.Especie AS E ON PI.IdEspecieInvestigada = E.IdEspecie
         INNER JOIN GREEN_TEC.Alimentacion AS A ON E.IdEspecie = A.IdDepredador
         INNER JOIN GREEN_TEC.Especie AS E2 ON A.IdPresa = E2.IdEspecie
         INNER JOIN GREEN_TEC.CaracteristicaEspecie AS CE ON E.IdCaracteristica = CE.IdCaracteristica;
GO


DROP VIEW IF EXISTS [Area Total por Parque Nacional]
GO

CREATE VIEW [Area Total por Parque Nacional] AS
  SELECT PN.IdParqueNacional, PN.Nombre, SUM(A.Extension) AS AreaTotal
  FROM GREEN_TEC.ParqueNacional AS PN
         INNER JOIN GREEN_TEC.Area AS A ON PN.IdParqueNacional = A.IdParqueNacional
  GROUP BY PN.IdParqueNacional, PN.Nombre;
GO


DROP VIEW IF EXISTS [Parques Nacionales por Comunidad]
GO

CREATE VIEW [Parques Nacionales por Comunidad]
  WITH SCHEMABINDING AS
  SELECT C.IdComunidad, C.Nombre, COUNT_BIG(*) AS CantidadDeParques
  FROM GREEN_TEC.Comunidad AS C
         INNER JOIN GREEN_TEC.ParqueXComunidad AS PC ON C.IdComunidad = PC.IdComunidad
  GROUP BY C.IdComunidad, C.Nombre;
GO


DROP VIEW IF EXISTS [Area Protegida por Comunidad]
GO

CREATE VIEW [Area Protegida por Comunidad]
  WITH SCHEMABINDING AS
  SELECT C.IdComunidad, C.Nombre, SUM(ISNULL(A.Extension, 0)) AS AreaProtegida, COUNT_BIG(*) AS CantidadDeAreas
  FROM GREEN_TEC.Comunidad AS C
         INNER JOIN GREEN_TEC.ParqueXComunidad AS PC ON C.IdComunidad = PC.IdComunidad
         INNER JOIN GREEN_TEC.Area AS A ON PC.IdParqueNacional = A.IdParqueNacional
  GROUP BY C.IdComunidad, C.Nombre;
GO

SELECT *
FROM [Datos De Depredadores En Investigacion];
GO
SELECT *
FROM [Area Total por Parque Nacional];
GO
SELECT *
FROM [Parques Nacionales por Comunidad];
GO
SELECT *
FROM [Area Protegida por Comunidad];
GO