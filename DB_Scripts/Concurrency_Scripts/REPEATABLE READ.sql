--Ejemplo REPEATABLE READ
/* Existen los bloqueos compartidos (shared locks) en los datos que esta leyendo. Al leer un conjunto
de registros estos se matienen intactos al finalizar la operacion.

Evita:
  -Lecturas Sucias
  -Lecturas no repetibles
NO evita:
  -Lecturas Fantasma

 Nótese que el valor actual del NombreVulgar es 'Perro', este sera cambiado por Lobo en esta transaccion;

 */

--**************** Ejemplo 1 ********************
/*
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
  BEGIN TRAN
  SELECT * FROM GREEN_TEC.Especie WHERE IdEspecie BETWEEN 3 AND 6
  WAITFOR DELAY '00:00:15'
  ROLLBACK
*/
--El UPDATE se realiza pero hasta que la transaccion anterior finalice, esto por los bloqueos existentes
UPDATE GREEN_TEC.Especie
SET NombreVulgar = 'Lobo'
WHERE IdEspecie = 4

--**************** Ejemplo 2 ********************
/*
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
  BEGIN TRAN
  SELECT * FROM GREEN_TEC.Especie
  WAITFOR DELAY '00:00:15'
  ROLLBACK
*/
/* El INSERT se ejecuta correctamente sin delay ya que el Repeatable read permite insertar nuevos datos pero no
modificar existentes */
INSERT INTO GREEN_TEC.Especie (NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo)
VALUES ('Conejo Colorado', 'Oryctolagus cuniculus', 3, 1, 8)


--Volver a perro
UPDATE GREEN_TEC.Especie
SET NombreVulgar = 'Perro'
WHERE IdEspecie = 4