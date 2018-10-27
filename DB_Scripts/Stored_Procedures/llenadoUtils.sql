USE GREEN_TEC;  
GO


CREATE PROCEDURE EpecieRandom AS
  SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie ORDER BY newid()
GO;

CREATE PROCEDURE VisitanteRandom AS
  SELECT TOP 1 IdVisitante FROM GREEN_TEC.Visitante ORDER BY newid()
GO;
  
CREATE PROCEDURE VehiculosDeParqueNacional   
    @ParqueNacional int
AS
    SELECT GREEN_TEC.Vehiculo.IdVehiculo FROM Green_TEC.Vehiculo
		INNER JOIN GREEN_TEC.VehiculoXPersonal ON GREEN_TEC.VehiculoXPersonal.IdVehiculo = GREEN_TEC.Vehiculo.IdVehiculo
		INNER JOIN GREEN_TEC.Personal ON GREEN_TEC.VehiculoXPersonal.IdPersonal = GREEN_TEC.Personal.IdPersonal
		INNER JOIN GREEN_TEC.Area ON GREEN_TEC.Personal.IdAreaAsignada = GREEN_TEC.Area.IdArea
		WHERE GREEN_TEC.Area.IdParqueNacional = @ParqueNacional
GO;

