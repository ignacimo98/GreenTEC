--Ejemplo READ UNCOMMITTED
/* No existen los bloqueos eso hace que no exista delay en las consultas

NO evita:
  -Lecturas sucias
  -Lecturas no repetibles
  -Lecturas fantasma

 Nótese que el valor actual del NombreVulgar es 'Perro', este sera cambiado por Lobo en esta transaccion sin embargo
 se hace un ROLLBACK al final;

 */

--**************** Ejemplo ********************
/*
Ejecutar al mismo tiempo que:

BEGIN TRAN
  UPDATE GREEN_TEC.Especie SET NombreVulgar='Lobo' WHERE IdEspecie=4
  WAITFOR DELAY '00:00:15'
  ROLLBACK
*/

/*Debe retornar 'Lobo' sin delay ya que aunque la transaccion no haya hecho commit, esto por que no se bloquea
 la tabla y no se ha llegado a ejecutar el ROLLBACK*/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT NombreVulgar FROM GREEN_TEC.Especie WHERE IdEspecie = 4




