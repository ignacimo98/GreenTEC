USE [GREEN_TEC]
GO

DROP SCHEMA IF EXISTS [GREEN_TEC]
GO

CREATE SCHEMA GREEN_TEC
GO

CREATE TABLE Vehiculo (
  IdVehiculo INT IDENTITY PRIMARY KEY,
  Tipo       VARCHAR(15),
  Matricula  VARCHAR(6)
)
GO


CREATE TABLE Tour (
  IdTour      INT IDENTITY PRIMARY KEY,
  Nombre      VARCHAR(25),
  Descripcion VARCHAR(100)
)
GO


CREATE TABLE Organismo (
  IdOrganismo INT         NOT NULL PRIMARY KEY,
  Nombre      VARCHAR(45) NOT NULL
)
GO

CREATE TABLE ParqueNacional (
  IdParqueNacional INT IDENTITY PRIMARY KEY,
  Nombre           VARCHAR(45),
  FechaDeclaracion DATE
)
GO

CREATE TABLE Comunidad (
  IdComunidad INT IDENTITY PRIMARY KEY,
  Nombre      VARCHAR(45),
  IdOrganismo INT
    CONSTRAINT Comunidad_Organismo_IdOrganismo_fk
    REFERENCES Organismo
)
GO


CREATE TABLE ParqueXComunidad (
  IdComunidad      INT
    CONSTRAINT ParqueXComunidad_Comunidad_IdComunidad_fk
    REFERENCES Comunidad,
  IdParqueNacional INT
    CONSTRAINT ParqueXComunidad_ParqueNacional_IdParqueNacional_fk
    REFERENCES ParqueNacional,
)
GO

CREATE TABLE Alojamiento (
  IdAlojamiento       INT IDENTITY PRIMARY KEY,
  IdParqueNacional    INT
    CONSTRAINT Alojamiento_ParqueNacional_IdParqueNacional_fk
    REFERENCES ParqueNacional,
  Nombre              VARCHAR(45),
  CapacidadDisponible INT,
  Categoria           INT
)
GO

CREATE TABLE Visitante (
  IdVisitante INT IDENTITY PRIMARY KEY,
  Cedula      INT,
  Nombre      VARCHAR(45),
  Domicilio   VARCHAR(100),
  Profesion   VARCHAR(25)
)
go

CREATE TABLE Visita (
  IdVisita      INT IDENTITY PRIMARY KEY,
  IdVisitante   INT
    CONSTRAINT Visita_Visitante_IdVisitante_fk
    REFERENCES Visitante,
  IdAlojamiento INT
    CONSTRAINT Visita_Alojamiento_IdAlojamiento_fk
    REFERENCES Alojamiento,
  FechaIngreso  DATETIME NOT NULL,
  FechaSalida   DATETIME NOT NULL
)
GO


CREATE TABLE Excursion (
  IdExcursion   INT IDENTITY PRIMARY KEY,
  IdTour        INT
    CONSTRAINT Excursion_Tour_IdTour_fk
    REFERENCES Tour,
  IdAlojamiento INT
    CONSTRAINT Excursion_Alojamiento_IdAlojamiento_fk
    REFERENCES Alojamiento,
  IdVehiculo    INT
    CONSTRAINT Excursion_Vehiculo_IdVehiculo_fk
    REFERENCES Vehiculo,
  DiaDeSemana   tinyint,
  Hora          time
)
GO

CREATE TABLE Area (
  IdArea           INT IDENTITY PRIMARY KEY,
  IdParqueNacional INT
    CONSTRAINT Area_ParqueNacional_IdParqueNacional_fk
    REFERENCES ParqueNacional,
  Nombre           VARCHAR(45),
  Extension        float
)
GO

CREATE TABLE CaracteristicaEspecie (
  IdCaracteristica INT IDENTITY PRIMARY KEY,
  Nombre           VARCHAR(45),
  Valor            VARCHAR(45)
)
GO

CREATE TABLE TipoEspecie (
  IdTipoEspecie INT IDENTITY PRIMARY KEY,
  Nombre        VARCHAR(15)
)
GO


CREATE TABLE Periodo (
  IdPeriodo INT IDENTITY PRIMARY KEY,
  MesInicio tinyint,
  MesFinal  tinyint
)
GO

CREATE TABLE Especie (
  IdEspecie        INT IDENTITY PRIMARY KEY,
  NombreVulgar     VARCHAR(45),
  NombreCientifico VARCHAR(45),
  IdCaracteristica INT
    CONSTRAINT Especie_Caracteristica_IdCaracteristica_fk
    REFERENCES CaracteristicaEspecie,
  IdTipoEspecie    INT
    CONSTRAINT Especie_TipoEspecie_IdTipoEspecie_fk
    REFERENCES TipoEspecie,
  IdPeriodo        INT
    CONSTRAINT Especie_Periodo_IdPeriodo_fk
    REFERENCES Periodo
)
GO


CREATE TABLE EspecieXArea (
  IdEspecie INT
    CONSTRAINT EspecieXArea_Especie_IdEspecie_fk
    REFERENCES Especie,
  IdArea    INT
    CONSTRAINT EspecieXArea_Area_IdArea_fk
    REFERENCES Area,
  Cantidad  INT
)
GO


CREATE TABLE Alimentacion (
  IdDepredador INT
    CONSTRAINT Alimentacion_Especie_IdEspecie_fk
    REFERENCES Especie,
  IdPresa      INT
    CONSTRAINT Alimentacion_Especie_IdEspecie_fk_2
    REFERENCES Especie
)
GO


CREATE TABLE TipoPersonal (
  IdTipoPersonal INT IDENTITY PRIMARY KEY,
  Nombre         VARCHAR(25)
)
GO

CREATE TABLE ProyectoInvestigacion (
  IdProyectoInvestigacion INT IDENTITY PRIMARY KEY,
  Presupuesto             INT,
  FechaInicio             DATE,
  FechaFinal              DATE,
  IdEspecieInvestigada    INT
    CONSTRAINT ProyectoInvestigacion_Especie_IdEspecie_fk
    REFERENCES Especie
)
GO


CREATE TABLE CaracteristicaPersonal (
  IdCaracteristicaPersonal INT IDENTITY PRIMARY KEY,
  Nombre                   VARCHAR(25),
  Valor                    VARCHAR(20)
)
GO

CREATE TABLE Personal (
  IdPersonal           INT IDENTITY PRIMARY KEY,
  NumeroIdentificacion INT,
  Direccion            VARCHAR(100),
  TelefonoMovil        INT,
  TelefonoDomicilio    INT,
  Sueldo               INT,
  IdAreaAsignada       INT
    CONSTRAINT Personal_Area_IdArea_fk
    REFERENCES Area,
  IdTipoPersonal       INT
    CONSTRAINT Personal_TipoPersonal_IdTipoPersonal_fk
    REFERENCES TipoPersonal,
  IdCaracteristica     INT
    CONSTRAINT Personal_CaracteristicaPersonal_IdCaracteristicaPersonal_fk
    REFERENCES CaracteristicaPersonal
)
GO

CREATE TABLE VehiculoXPersonal (
  IdPersonal INT
    CONSTRAINT VehiculoXPersonal_Personal_IdPersonal_fk
    REFERENCES Personal,
  IdVehiculo INT
    CONSTRAINT VehiculoXPersonal_Vehiculo_IdVehiculo_fk
    REFERENCES Vehiculo
)
GO


CREATE TABLE InvestigadorXProyecto (
  IdProyecto     INT
    CONSTRAINT InvestigadorXProyecto_ProyectoInvestigacion_IdProyectoInvestigacion_fk
    REFERENCES ProyectoInvestigacion,
  IdInvestigador INT
    CONSTRAINT InvestigadorXProyecto_Personal_IdPersonal_fk
    REFERENCES Personal
)
GO
