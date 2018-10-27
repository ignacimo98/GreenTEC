--UNION
/* Union se utiliza para unir los resultados de dos o mas select */
USE GREEN_TEC
GO

SELECT Direccion
FROM GREEN_TEC.Personal
WHERE IdPersonal BETWEEN 1 AND 50
UNION
SELECT Domicilio
FROM GREEN_TEC.Visitante
WHERE IdVisitante BETWEEN 1 AND 50