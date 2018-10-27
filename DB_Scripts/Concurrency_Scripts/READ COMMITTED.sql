--Ejemplo READ COMMITTED
/* Existen los bloqueos compartidos (shared locks) en los datos que esta leyendo.

Evita:
  -Lecturas Sucias
NO evita:
  -Lecturas no repetibles
  -Lecturas Fantasma

 Nótese que el valor actual del NombreVulgar es 'Perro', este sera cambiado por Lobo en esta transaccion;

 */

--**************** Ejemplo 1 ********************
/*
Ejecutar al mismo tiempo que:

BEGIN TRAN
  UPDATE GREEN_TEC.Especie SET NombreVulgar='Lobo' WHERE IdEspecie=4
  WAITFOR DELAY '00:00:15'
  COMMIT
*/
--Debe retornar 'Lobo' sin embargo hasta despues del delay ya que la tabla se encuentra bloqueada
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SELECT NombreVulgar
FROM GREEN_TEC.Especie
WHERE IdEspecie = 4

--**************** Ejemplo 2 ********************
/*
Ejecutar al mismo tiempo que:

BEGIN TRAN
  SELECT * FROM GREEN_TEC.Especie
  WAITFOR DELAY '00:00:15'
  COMMIT
*/
/*Debe retornar la tabla SIN delay ya que al no haber un 'UPDATE' o 'DELETE' en la transaccion anterior la tabla no se
bloquea */
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SELECT *
FROM GREEN_TEC.Especie


--Vuelve a ser perro:
BEGIN TRAN
UPDATE GREEN_TEC.Especie
SET NombreVulgar = 'Perro'
WHERE IdEspecie = 4
COMMIT