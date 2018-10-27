USE [GREEN_TEC]
GO

DROP INDEX IF EXISTS IDX_DepredadoresEnInvestigacion ON dbo.[Datos De Depredadores En Investigacion]
GO

SELECT * FROM [Datos De Depredadores En Investigacion];

CREATE UNIQUE CLUSTERED INDEX IDX_DepredadoresEnInvestigacion
  ON dbo.[Datos De Depredadores En Investigacion] ([Numero de Proyecto]);
GO

SELECT * FROM [Datos De Depredadores En Investigacion];

DROP INDEX IF EXISTS IDX_CantidadParquesPorComunidad ON dbo.[Parques Nacionales por Comunidad];
GO

SELECT * FROM [Parques Nacionales por Comunidad];
GO

CREATE UNIQUE CLUSTERED INDEX IDX_CantidadParquesPorComunidad
  ON dbo.[Parques Nacionales por Comunidad] (IdComunidad);
GO

SELECT * FROM [Parques Nacionales por Comunidad];

DROP INDEX IF EXISTS IDX_AreaProtegidaPorComunidad ON dbo.[Area Protegida por Comunidad];
GO

SELECT * FROM [Area Protegida por Comunidad];
GO

CREATE UNIQUE CLUSTERED INDEX IDX_AreaProtegidaPorComunidad
  ON dbo.[Area Protegida por Comunidad] (IdComunidad);
GO

SELECT * FROM [Area Protegida por Comunidad];
