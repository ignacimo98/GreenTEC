USE [GREEN_TEC]
GO

CREATE FUNCTION EspecieValida(@IdEspecie INT)
  RETURNS INT AS
  BEGIN
    RETURN
    CASE
    WHEN @IdEspecie < 1
      THEN 0
    ELSE 1
    END
  END

-- Query sin optimizar
SELECT CONVERT(VARCHAR, CantidadInvestigadoresXProyecto.NumeroDeProyecto) AS ConsecutivoDeProyecto,
       CantidadInvestigadoresXProyecto.CantidadDeInvestigadores,
       E.NombreVulgar,
       SueldoPromedioXInvestigacion.SueldoPromedio,
       DepredadoresXEspecieInvestigada.CantidadDeDepredadores
FROM (SELECT PI.IdProyectoInvestigacion AS NumeroDeProyecto,
             COUNT(IxP.IdInvestigador)  AS CantidadDeInvestigadores,
             PI.IdEspecieInvestigada    AS IdEspecie
      FROM GREEN_TEC.ProyectoInvestigacion AS PI
             INNER JOIN GREEN_TEC.InvestigadorXProyecto AS IxP ON PI.IdProyectoInvestigacion = IxP.IdProyecto
      GROUP BY PI.IdProyectoInvestigacion, PI.IdEspecieInvestigada) AS CantidadInvestigadoresXProyecto
       INNER JOIN GREEN_TEC.Especie AS E ON CantidadInvestigadoresXProyecto.IdEspecie = E.IdEspecie
       INNER JOIN (SELECT PI.IdProyectoInvestigacion AS NumeroDeProyecto, AVG(P.Sueldo) AS SueldoPromedio
                   FROM GREEN_TEC.ProyectoInvestigacion AS PI
                          INNER JOIN GREEN_TEC.InvestigadorXProyecto AS IxP
                            ON PI.IdProyectoInvestigacion = IxP.IdProyecto
                          INNER JOIN GREEN_TEC.Personal AS P ON IxP.IdInvestigador = P.IdPersonal
                   GROUP BY PI.IdProyectoInvestigacion)
    AS SueldoPromedioXInvestigacion
         ON CantidadInvestigadoresXProyecto.NumeroDeProyecto = SueldoPromedioXInvestigacion.NumeroDeProyecto
       INNER JOIN (SELECT PI.IdProyectoInvestigacion AS NumeroDeProyecto, COUNT(A.IdPresa) AS CantidadDeDepredadores
                   FROM GREEN_TEC.ProyectoInvestigacion AS PI
                          INNER JOIN GREEN_TEC.Alimentacion AS A ON PI.IdEspecieInvestigada = A.IdPresa
                   GROUP BY PI.IdProyectoInvestigacion)
    AS DepredadoresXEspecieInvestigada
         ON CantidadInvestigadoresXProyecto.NumeroDeProyecto = DepredadoresXEspecieInvestigada.NumeroDeProyecto
WHERE dbo.EspecieValida(E.IdEspecie) = 1
ORDER BY SueldoPromedioXInvestigacion.SueldoPromedio DESC;

-- Query optimizado
SELECT CONVERT(VARCHAR, PI.IdProyectoInvestigacion) AS ConsecutivoDeProyecto,
       COUNT(IxP.IdInvestigador)                    AS CantidadDeInvestigadores,
       E.NombreVulgar,
       AVG(P.Sueldo)                                AS SueldoPromedio,
       DepredadoresXEspecieInvestigada.CantidadDeDepredadores
FROM GREEN_TEC.ProyectoInvestigacion AS PI
       INNER JOIN GREEN_TEC.InvestigadorXProyecto AS IxP ON PI.IdProyectoInvestigacion = IxP.IdProyecto
       INNER JOIN GREEN_TEC.Especie AS E ON PI.IdEspecieInvestigada = E.IdEspecie
       INNER JOIN GREEN_TEC.Personal AS P ON IxP.IdInvestigador = P.IdPersonal
       INNER JOIN (SELECT PI.IdProyectoInvestigacion AS NumeroDeProyecto, COUNT(A.IdPresa) AS CantidadDeDepredadores
                   FROM GREEN_TEC.ProyectoInvestigacion AS PI
                          INNER JOIN GREEN_TEC.Alimentacion AS A ON PI.IdEspecieInvestigada = A.IdPresa
                   GROUP BY PI.IdProyectoInvestigacion) AS DepredadoresXEspecieInvestigada
         ON PI.IdProyectoInvestigacion = DepredadoresXEspecieInvestigada.NumeroDeProyecto
GROUP BY PI.IdProyectoInvestigacion, E.NombreVulgar, DepredadoresXEspecieInvestigada.CantidadDeDepredadores;


