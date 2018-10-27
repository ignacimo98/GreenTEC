Session 1                   | Session 2
--=========================================================
BEGIN TRAN;                 | BEGIN TRAN;
--=========================================================
UPDATE GREEN_TEC.Comunidad
SET Nombre = 'Cartaguito'
WHERE IdComunidad = 1
--=========================================================
                             | UPDATE GREEN_TEC.Organismo
                             | SET Nombre = 'ICE'
                             | WHERE IdOrganismo = 2
--=========================================================
SELECT Nombre
FROM GREEN_TEC.Organismo
WHERE IdOrganismo = 2
--=========================================================
<blocked>                    | SELECT Nombre 
                             | FROM GREEN_TEC.Comunidad
                             | WHERE IdComunidad = 1
--=========================================================
                             | <blocked>
--=========================================================
-----------------------DEADLOCK----------------------------