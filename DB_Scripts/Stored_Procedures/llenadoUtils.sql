USE GREEN_TEC;
GO

-- Obtiene una especie random
CREATE PROCEDURE EspecieRandom AS
  SELECT TOP 1 IdEspecie
  FROM GREEN_TEC.Especie
  ORDER BY newid()
GO ;

-- Obtiene un visitante random
CREATE PROCEDURE VisitanteRandom AS
  SELECT TOP 1 IdVisitante
  FROM GREEN_TEC.Visitante
  ORDER BY newid()
GO ;

-- Obtiene los vehiculos que pertenecen a empleados de un parque determinado
CREATE PROCEDURE VehiculosDeParqueNacional
    @ParqueNacional INT
AS
  SELECT GREEN_TEC.Vehiculo.IdVehiculo
  FROM Green_TEC.Vehiculo
         INNER JOIN GREEN_TEC.VehiculoXPersonal
           ON GREEN_TEC.VehiculoXPersonal.IdVehiculo = GREEN_TEC.Vehiculo.IdVehiculo
         INNER JOIN GREEN_TEC.Personal ON GREEN_TEC.VehiculoXPersonal.IdPersonal = GREEN_TEC.Personal.IdPersonal
         INNER JOIN GREEN_TEC.Area ON GREEN_TEC.Personal.IdAreaAsignada = GREEN_TEC.Area.IdArea
  WHERE GREEN_TEC.Area.IdParqueNacional = @ParqueNacional
GO;

