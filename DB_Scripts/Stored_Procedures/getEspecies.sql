USE GREEN_TEC;
GO

DROP PROCEDURE IF EXISTS ObtenerEspeciesDeCadena;

CREATE PROCEDURE ObtenerEspeciesDeCadena AS
  WITH CadenaAlimenticia
      AS (SELECT IdDepredador AS Id
          FROM GREEN_TEC.Alimentacion
      UNION
      SELECT IdPresa AS Id
      FROM GREEN_TEC.Alimentacion)
  SELECT IdEspecie, IdTipoEspecie AS IdTipo, NombreCientifico, NombreVulgar
  FROM GREEN_TEC.Especie
         INNER JOIN CadenaAlimenticia ON CadenaAlimenticia.Id = Especie.IdEspecie
  WHERE NOT IdTipoEspecie = 3
GO ;


DROP PROCEDURE IF EXISTS ObtenerCadena;

CREATE PROCEDURE ObtenerCadena AS
  SELECT IdDepredador, IdPresa
  FROM GREEN_TEC.Alimentacion
GO

EXEC ObtenerEspeciesDeCadena;
EXEC ObtenerCadena;