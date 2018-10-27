create schema GREEN_TEC
go

create table Vehiculo
(
	IdVehiculo int identity
		primary key,
	Tipo varchar(15),
	Matricula varchar(6),
	Usos int
)
go

create table Visitante
(
	IdVisitante int identity
		primary key,
	Cedula int,
	Nombre varchar(60),
	Domicilio varchar(100),
	Profesion varchar(50)
)
go

create table Tour
(
	IdTour int identity
		primary key,
	Nombre varchar(60),
	Descripcion text
)
go

create table Organismo
(
	IdOrganismo int not null
		primary key,
	Nombre varchar(45) not null
)
go

create table ParqueNacional
(
	IdParqueNacional int identity
		primary key,
	Nombre varchar(45),
	FechaDeclaracion date
)
go

create table Comunidad
(
	IdComunidad int identity
		primary key,
	Nombre varchar(45),
	IdOrganismo int
		constraint Comunidad_Organismo_IdOrganismo_fk
			references Organismo
)
go

create table ParqueXComunidad
(
	IdComunidad int
		constraint ParqueXComunidad_Comunidad_IdComunidad_fk
			references Comunidad,
	IdParqueNacional int
		constraint ParqueXComunidad_ParqueNacional_IdParqueNacional_fk
			references ParqueNacional
)
go

create table Alojamiento
(
	IdAlojamiento int identity
		primary key,
	IdParqueNacional int
		constraint Alojamiento_ParqueNacional_IdParqueNacional_fk
			references ParqueNacional,
	Nombre varchar(45),
	CapacidadDisponible int,
	Categoria int
)
go

create table Visita
(
	IdVisita int identity
		primary key,
	IdVisitante int,
	IdAlojamiento int
		constraint Visita_Alojamiento_IdAlojamiento_fk
			references Alojamiento,
	FechaIngreso datetime not null,
	FechaSalida datetime not null
)
go

create table Excursion
(
	IdExcursion int identity
		primary key,
	IdTour int not null
		constraint Excursion_Tour_IdTour_fk
			references Tour,
	IdAlojamiento int not null
		constraint Excursion_Alojamiento_IdAlojamiento_fk
			references Alojamiento,
	IdVehiculo int,
	Fecha datetime
)
go

create table Area
(
	IdArea int identity
		primary key,
	IdParqueNacional int
		constraint Area_ParqueNacional_IdParqueNacional_fk
			references ParqueNacional,
	Nombre varchar(45),
	Extension float
)
go

create table CaracteristicaEspecie
(
	IdCaracteristica int identity
		primary key,
	Nombre varchar(45),
	Valor varchar(45)
)
go

create table TipoEspecie
(
	IdTipoEspecie int identity
		primary key,
	Nombre varchar(15)
)
go

create table Periodo
(
	IdPeriodo int identity
		primary key,
	MesInicio tinyint,
	MesFinal tinyint
)
go

create table Especie
(
	IdEspecie int identity
		primary key,
	NombreVulgar varchar(45),
	NombreCientifico varchar(45),
	IdCaracteristica int
		constraint Especie_Caracteristica_IdCaracteristica_fk
			references CaracteristicaEspecie,
	IdTipoEspecie int
		constraint Especie_TipoEspecie_IdTipoEspecie_fk
			references TipoEspecie,
	IdPeriodo int
		constraint Especie_Periodo_IdPeriodo_fk
			references Periodo
)
go

create table EspecieXArea
(
	IdEspecie int
		constraint EspecieXArea_Especie_IdEspecie_fk
			references Especie,
	IdArea int
		constraint EspecieXArea_Area_IdArea_fk
			references Area,
	Cantidad int
)
go

create table Alimentacion
(
	IdDepredador int
		constraint Alimentacion_Especie_IdEspecie_fk
			references Especie,
	IdPresa int
		constraint Alimentacion_Especie_IdEspecie_fk_2
			references Especie
)
go

create table TipoPersonal
(
	IdTipoPersonal int identity
		primary key,
	Nombre varchar(25)
)
go

create table ProyectoInvestigacion
(
	IdProyectoInvestigacion int identity
		primary key,
	Presupuesto int,
	FechaInicio date,
	FechaFinal date,
	IdEspecieInvestigada int
		constraint ProyectoInvestigacion_Especie_IdEspecie_fk
			references Especie
)
go

create table CaracteristicaPersonal
(
	IdCaracteristicaPersonal int identity
		primary key,
	Nombre varchar(25),
	Valor varchar(20)
)
go

create table Personal
(
	IdPersonal int identity
		primary key,
	NumeroIdentificacion int,
	Direccion varchar(100),
	TelefonoMovil int,
	TelefonoDomicilio int,
	Sueldo int,
	IdAreaAsignada int
		constraint Personal_Area_IdArea_fk
			references Area,
	IdTipoPersonal int
		constraint Personal_TipoPersonal_IdTipoPersonal_fk
			references TipoPersonal,
	IdCaracteristica int
		constraint Personal_CaracteristicaPersonal_IdCaracteristicaPersonal_fk
			references CaracteristicaPersonal,
	Nombre varchar(60) not null
)
go

create table VehiculoXPersonal
(
	IdPersonal int
		constraint VehiculoXPersonal_Personal_IdPersonal_fk
			references Personal,
	IdVehiculo int
		constraint VehiculoXPersonal_Vehiculo_IdVehiculo_fk
			references Vehiculo
)
go

create unique index VehiculoXPersonal_IdPersonal_uindex
	on VehiculoXPersonal (IdPersonal)
go

create table InvestigadorXProyecto
(
	IdProyecto int
		constraint InvestigadorXProyecto_ProyectoInvestigacion_IdProyectoInvestigacion_fk
			references ProyectoInvestigacion,
	IdInvestigador int
		constraint InvestigadorXProyecto_Personal_IdPersonal_fk
			references Personal
)
go

