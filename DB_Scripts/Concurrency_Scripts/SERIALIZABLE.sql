--Ejemplo SERIALIZABLE
/* Esta funcion es similar al repeatable read pero evita las lecturas fantasma ya que bloquea los datos accesados en
todo el rango de IDs lo que no permite ni modiicaciones ni inserciones o eliminaciones, si la tabla no tiene IDs
entonces bloquea toda la tabla.

Evita:
  -Lecturas Sucias
  -Lecturas no repetibles
  -Lecturas Fantasma

 Nótese que el valor actual del NombreVulgar es 'Perro', este sera cambiado por Lobo en esta transaccion;

 */

--**************** Ejemplo 1 ********************
/*
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
SELECT * FROM GREEN_TEC.Especie
WAITFOR DELAY '00:00:15'
ROLLBACK
 */
--Dado que la transacion anterior bloquea la tabla, el INSERT va a esperar hasta que esta transaccion termine.
INSERT INTO GREEN_TEC.Especie(NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo)
VALUES ('Conejo Silvestre','Oryctolagus cuniculus ',3,1,8)

--**************** Ejemplo 2 ********************
/*
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
SELECT * FROM GREEN_TEC.Especie WHERE IdEspecie BETWEEN 3 AND 6
WAITFOR DELAY '00:00:15'
ROLLBACK
 */
--Como la el id del insert no esta entre los datos accesados por la transaccion anterior esta no tiene delay
INSERT INTO GREEN_TEC.Especie(NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo)
VALUES ('Conejo Amarillo','Oryctolagus cuniculus ',3,1,8)