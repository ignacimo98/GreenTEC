DROP TRIGGER IF EXISTS print_time_on_Especie_INSERT
GO

CREATE TRIGGER print_date_on_Especie_INSERT
  ON [GREEN_TEC].Especie
  FOR INSERT
AS
  PRINT GETDATE()
GO