#!/usr/bin/env python -W ignore::DeprecationWarning

import pyodbc
import random
import csv
import sys
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning
import pymssql
from faker import Faker
from tqdm import trange, tqdm
from datetime import datetime, timedelta, time

fake = Faker('es_MX')


msg = 'Quiere llenar la base de datos?'
shall = input("%s (y/N) " % msg).lower() == 'y'

if not shall:
	sys.exit(0)

conn = pyodbc.connect('DSN=MySQLServerDatabase;database=GREEN_TEC;UID=joseph;PWD=joseph')

cursor = conn.cursor()

def parque():
	titulos = ["Parque Nacional", "Reserva", "Refugio de Vida Silvestre"]
	tipos = ["Cihuatl","Piltzintli","Conetl","Achipactli","Cuahuitl","Popolohuiliz","Yaotl","Ye otztli","Nohuanyolque","Tlazohtla","Oquichtli","Cihuatl","Tlacatl","Tlacah","Piltzintli","Nantli","Tahtli","Cone"]
	suffix = ["",  "", " " + fake.city_suffix(), " Oriental", " Occidental", " Norte", " Sur"]
	choices = [fake.last_name() + " " + fake.last_name(), random.choice(tipos) + random.choice(suffix)]
	return random.choice(titulos) + " " + random.choice(choices)

#Paso 4
print("Insertando parques")
for i in tqdm(range(1, 79)):
	nombre = parque()
	while len(nombre) > 40:
		nombre = parque()
	cursor.execute("INSERT INTO GREEN_TEC.ParqueNacional(Nombre, FechaDeclaracion) VALUES (?, ?)", [nombre, fake.date_between(start_date="-30y", end_date="-6y")])
	cursor.execute("SELECT @@Identity")
	data = cursor.fetchone()[0]
	cursor.execute("INSERT INTO GREEN_TEC.ParqueXComunidad(idComunidad, idParqueNacional) VALUES (?, ?)", [i, data])
conn.commit()

#Paso 5
print("Insertando comunidades")
for i in tqdm(range(1, 47)):
	nombre = parque()
	while len(nombre) > 40:
		nombre = parque()
	cursor.execute("INSERT INTO GREEN_TEC.ParqueNacional(Nombre, FechaDeclaracion) VALUES (?, ?)", [nombre, fake.date_between(start_date="-30y", end_date="-6y")])
	cursor.execute("SELECT @@Identity")
	data = cursor.fetchone()[0]
	cursor.execute("INSERT INTO GREEN_TEC.ParqueXComunidad(idComunidad, idParqueNacional) VALUES (?, ?)", [random.randint(1,79), data])
conn.commit()

#Paso 6-8
print("Insertando alojamientos")

hoteles = ["Parkview Hotel","Mint Hotel","Radisson Hotels & Resorts","Glades Hotel","Aston Hotels & Resorts","The Prince George Hotel","Luma Hotel","Royal Tulip Luxury Hotels","The Orchid","Grand Hotel","The Crown Hotel","Millenium Hotels & Resorts","Spa Paws Hotel","Comfort Hotel","Hard Rock Hotel","Waterfront Hotel","Marianne Hotel","Read Also: 77 Catchy Hotel Slogans & Taglines","Hotel Ostella","Queen Hotel","The Williamsburg Hotel","Vineyard Hotel","Aloft Hotels","Hilton Dusseldorf","Cura Hospitality","Hilton Garden Inn","The Mutiny Hotel","Days Inn Hotels","Trump International Hotel & Tower","Novotel","Monte Carlo Resort & Casino","The Howard Hotel","Best Western International hotels","Conrad Hotels & Resorts","Hotel Annapolis","Renaissance Hotels","Fragrance Hotel","Noormans Hotel","Hotal Raamus","Ethan Allen Hotel","Sapientia Hotel","Rosen Plaza Hotel","Argonaut Hotel","Homewood Suites","Oberoi Hotels & Resorts","Wyndham hotels and resorts","Pullman Hotels and Resorts","Lemigo Hotel","Accor Hotels","Alise Hotels","Marco Polo Hotels","Olive Residency","Hotel Nakshatra Inn","Diamond Hotel","Protea Hotels","Tune Hotels","Howard Johnson Hotels","Royal Hotel","Park Hyatt","Choice Hotels","Lakeshore Hotels","Marriott Hotels","Golden Jubilee Conference Hotel","Marriott Fairfield Inn & Suites","Beachwood hotel","The Ritz-Carlton","Jay Peak Vermont","Intercontinental Hotels & Resorts","Drawbridge Inn Hotel","Ibis Hotel","Westin hotels and resorts","Atlantis the Palm Hotel in Dubai","MGM Grand","Gleneagles","Kensington Court Ann Arbor","Four Seasons Hotels and Resorts","Windsor Suites Hotel","The Whitelaw Hotel","Whitelaw Hotel","Ramada Hotel","Hotel Euler","Orlyonok Hotel","Fairmont Hotels & Resorts","Hyatt Hotels and Resorts","Fairmont Hotel","Hotel Villa Amarilla","Omni Hotels & Resorts","Hotel Ametyst","Sheraton Towers Singapore","Jackson Hole Resort","Holiday Inn","Hotel para damas","Grand Hotel Bonavia","Aeon Plaza Hotels","Hilton Hotels & Resorts","Warner Leisure Hotels"]
areas = ["Oriental", "Occidental", "Norte", "Sur", "Zona montañosa", "Zona pública", "Zona protegida", "Manantial", "Fuentes", "Rocas", "Naciente", "Zona costera", "Zona húmeda"]

cursor.execute("SELECT idParqueNacional FROM GREEN_TEC.ParqueNacional")
rows = cursor.fetchall()
for parque in tqdm(rows):
	hotelesUsados = []
	for i in range(1, random.randint(1, 3)):
		hotel = random.choice(hoteles)
		while len(hotel) > 40 or hotel in hotelesUsados:
			hotel = random.choice(hoteles)
		hotelesUsados.append(hotel)

		cursor.execute("INSERT INTO GREEN_TEC.Alojamiento(IdParqueNacional, Nombre, CapacidadDisponible, Categoria) VALUES (?,?,?,?)",
			[parque[0], hotel, random.randint(20, 70), random.randint(2, 5)])

	areasUsados = []
	for i in range(1, random.randint(1, 4)):
		area = random.choice(areas)
		while len(area) > 40 or area in areasUsados:
			area = random.choice(area)
		areasUsados.append(area)

		cursor.execute("INSERT INTO GREEN_TEC.Area(IdParqueNacional, Nombre, Extension) VALUES (?,?,?)",
			[parque[0], area, random.randint(5000, 85000)])
conn.commit()
conn.close()





conn = pymssql.connect("192.168.1.132", "joseph", "joseph", "GREEN_TEC")
cursor = conn.cursor()

sals = [500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4000, 3000, 2500, 1000, 500, 250, 3500, 6000, 5500, 1500, 1000, 2500]
carros = ["4x4", "SUV", "Sedan", "Pick-up", "Camion"]
conservas = [4,5,14,15,16,17]


def random_with_N_digit(n):
	range_start = 10**(n-1)
	range_end = (10**n)-1
	return random.randint(range_start, range_end)


# Pasos 9-15
cursor.execute("SELECT IdParqueNacional FROM GREEN_TEC.ParqueNacional")
rows = cursor.fetchall()
for parque in rows:
	cursor.execute("INSERT INTO GREEN_TEC.Area(IdParqueNacional, Nombre, Extension) VALUES (%d, %s, %d)" , (parque[0], "No aplica", 0))
	areaDefault = cursor.lastrowid
	print(f"El area es {areaDefault}")

	for idGestion in range(1, random.randint(1, 4)):
		cursor.execute("INSERT INTO GREEN_TEC.Personal(NumeroIdentificacion, Nombre, Direccion, TelefonoMovil, TelefonoDomicilio, Sueldo, IdTipoPersonal, IdCaracteristica, IdAreaAsignada) VALUES (%d, %s, %s, %d, %d, %d, %d, %d, %d)",
	(random.randint(100000000, 799999999), fake.name(), fake.street_address(), random_with_N_digit(8), random_with_N_digit(8), random.choice(sals), 1, idGestion + 5, areaDefault))

	for idInvestigador in range(1, random.randint(1, 5)):
		cursor.execute("INSERT INTO GREEN_TEC.Personal(NumeroIdentificacion, Nombre, Direccion, TelefonoMovil, TelefonoDomicilio, Sueldo, IdTipoPersonal, IdAreaAsignada) VALUES (%d, %s, %s, %d, %d, %d, %d, %d)",
	(random.randint(100000000, 799999999), fake.name(), fake.street_address(), random_with_N_digit(8), random_with_N_digit(8), random.choice(sals), 3, areaDefault))

	cursor.execute("SELECT IdArea FROM GREEN_TEC.Area WHERE IdParqueNacional = %d AND Extension > 0", (parque[0]))
	areas = cursor.fetchall()
	for area in areas:
		cursor.execute("INSERT INTO GREEN_TEC.Vehiculo(Tipo, Matricula) VALUES(%d,%d)", (random.choice(carros), random_with_N_digit(6)))
		idAuto = cursor.lastrowid
		print(f"El auto es {idAuto}")

		cursor.execute("INSERT INTO GREEN_TEC.Personal(NumeroIdentificacion, Nombre, Direccion, TelefonoMovil, TelefonoDomicilio, Sueldo, IdTipoPersonal, IdAreaAsignada) VALUES (%d, %s, %s, %d, %d, %d, %d, %d)",
		(random.randint(100000000, 799999999), fake.name(), fake.street_address(), random_with_N_digit(8), random_with_N_digit(8), random.choice(sals), 2, area[0]))
		idPersonal = cursor.lastrowid
		print(f"El personal es {idPersonal}")

		cursor.execute("INSERT INTO GREEN_TEC.VehiculoXPersonal(IdVehiculo, IdPersonal) VALUES(%d,%d)", (idAuto, idPersonal))

		trabajosYaHechos = []
		for i in range(1, random.randint(1, 3)):
			trabajo = random.choice(conservas)
			while trabajo in trabajosYaHechos:
				trabajo = random.choice(conservas)
			trabajosYaHechos.append(trabajo)

			cursor.execute("INSERT INTO GREEN_TEC.Personal(NumeroIdentificacion, Nombre, Direccion, TelefonoMovil, TelefonoDomicilio, Sueldo, IdTipoPersonal, IdCaracteristica, IdAreaAsignada) VALUES (%d, %s, %s, %d, %d, %d, %d, %d, %d)",
			(random.randint(100000000, 799999999), fake.name(), fake.street_address(), random_with_N_digit(8), random_with_N_digit(8), random.choice(sals), 4, trabajo, area[0]))

#Paso 16
print("Insertando visitantes...")
for i in trange(10000):
	name = fake.name()
	while len(name) > 60:
		name = fake.name()


	job = fake.job()
	while len(job) > 50:
		job = fake.job()

	street = fake.street_address()
	while len(street) > 100:
		street = fake.street_address()

	cursor.execute("INSERT INTO GREEN_TEC.Visitante(Cedula, Nombre, Domicilio, Profesion) VALUES (%d, %s, %s, %s)",
		(random.randint(100000000, 799999999), name, street, job))

#Paso 17-19
print("Ingresando excursiones")

dates = ["Jan 2 2012", "Jan 3 2012", "Jan 4 2012", "Jan 5 2012", "Jan 6 2012"]

cursor.execute("SELECT IdTour FROM GREEN_TEC.Tour")
tours = cursor.fetchall()

cursor.execute("SELECT IdParqueNacional FROM GREEN_TEC.ParqueNacional")
rows = cursor.fetchall()
for parque in tqdm(rows):
	cursor.execute("SELECT IdAlojamiento FROM GREEN_TEC.Alojamiento WHERE IdParqueNacional = %d", (parque[0]))
	alojamientos = cursor.fetchall()

	toursUsados = []
	dateUsados = []
	autoSQL = """SELECT GREEN_TEC.Vehiculo.IdVehiculo FROM Green_TEC.Vehiculo
			INNER JOIN GREEN_TEC.VehiculoXPersonal ON GREEN_TEC.VehiculoXPersonal.IdVehiculo = GREEN_TEC.Vehiculo.IdVehiculo
			INNER JOIN GREEN_TEC.Personal ON GREEN_TEC.VehiculoXPersonal.IdPersonal = GREEN_TEC.Personal.IdPersonal
			INNER JOIN GREEN_TEC.Area ON GREEN_TEC.Personal.IdAreaAsignada = GREEN_TEC.Area.IdArea
			WHERE GREEN_TEC.Area.IdParqueNacional = %d"""

	cursor.execute(autoSQL, (parque[0]))
	autos = cursor.fetchall()

	for alojamiento in alojamientos:
		tour = random.choice(tours)
		while tour in toursUsados:
			tour = random.choice(tours)

		toursUsados.append(tour)

		date = random.choice(dates)
		while date in dateUsados:
			date = random.choice(dates)

		dateUsados.append(date)

		date = datetime.strptime(date, '%b %d %Y')
		hora = random.randint(6, 18)

		if bool(random.getrandbits(1)) and len(autos) > 0:
			vehiculo = True
		else:
			vehiculo = False

		for i in range(300):
			ndate = date + timedelta(weeks = i, hours = hora)

			if vehiculo:
				cursor.execute("INSERT INTO GREEN_TEC.Excursion(IdTour, IdAlojamiento, Fecha, IdVehiculo) VALUES (%d, %d, %s, %d)",
					(tour, alojamiento[0], ndate, random.choice(autos)[0]))
			else:
				cursor.execute("INSERT INTO GREEN_TEC.Excursion(IdTour, IdAlojamiento, Fecha)  VALUES (%d, %d, %s)",
					(tour, alojamiento[0], ndate))

#Paso 20-23
print("Ingresando visitas")
cursor.execute("SELECT IdAlojamiento FROM GREEN_TEC.Alojamiento")
rows = cursor.fetchall()
for hotel in tqdm(rows):
	for i in range(5, 15):
		cursor.execute("SELECT TOP 1 IdVisitante FROM GREEN_TEC.Visitante ORDER BY newid()")
		visitante = cursor.fetchone()[0]

		date = datetime.combine(fake.date_between(start_date="-6y", end_date="-1m"), time()) + timedelta(hours = random.randint(6, 19), minutes = random.randint(0, 59))
		endDate = date + timedelta(days = random.randint(1, 5)) - timedelta(hours = random.randint(0, 12), minutes = random.randint(0, 59))

		cursor.execute("INSERT INTO GREEN_TEC.Visita(IdVisitante, IdAlojamiento, FechaIngreso, FechaSalida) VALUES(%d,%d,%s,%s)", 
			(visitante, hotel[0], date, endDate))

#Animales
floracion = [1, 2]
dieta = [3, 3, 3, 3, 4, 5]
material = [6, 7]
print("Cargando archivos...")
with open('animal.csv', 'r') as file:
	animales = list(csv.reader(file))
with open('mineral.csv', 'r') as file:
	minerales = list(csv.reader(file))
with open('flora.csv', 'r') as file:
	floras = list(csv.reader(file))

print("Insertando animales")
for animal in tqdm(animales):
	cursor.execute("INSERT INTO GREEN_TEC.Especie(NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo) VALUES(%s,%s,%d,%d,%d)",
		(animal[0], animal[1], random.choice(dieta), 1, random.randint(8, 17)))

print("Insertando flora")
for flora in tqdm(floras):
	cursor.execute("INSERT INTO GREEN_TEC.Especie(NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie, IdPeriodo) VALUES(%s,%s,%d,%d,%d)",
		(flora[0], flora[1], random.choice(floracion), 2, random.randint(8, 17)))

print("Insertando minerales")
for mineral in tqdm(minerales):
	cursor.execute("INSERT INTO GREEN_TEC.Especie(NombreVulgar, NombreCientifico, IdCaracteristica, IdTipoEspecie) VALUES(%s,%s,%d,%d)",
		(mineral[0], mineral[1], random.choice(material), 3))

#Relaciones del mundo animal

print("Enlazando plantas-animales")
cursor.execute("SELECT IdEspecie FROM GREEN_TEC.Especie WHERE IdTipoEspecie = 2")
plantas = cursor.fetchall()
for planta in tqdm(plantas):
	animalesUsados = []
	for i in range(random.randint(0, 5)):
		cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie WHERE IdTipoEspecie = 1 AND IdCaracteristica = 3 OR IdCaracteristica = 5 ORDER BY newid()")
		animal = cursor.fetchone()[0]

		while animal in animalesUsados:
			cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie WHERE IdTipoEspecie = 1 AND IdCaracteristica = 3 OR IdCaracteristica = 5 ORDER BY newid()")
			animal = cursor.fetchone()[0]

		animalesUsados.append(animal)

		cursor.execute("INSERT INTO GREEN_TEC.Alimentacion(IdDepredador, IdPresa) Values (%d, %d)", 
			(animal, planta[0]))

print("Enlazando animales-animales")
cursor.execute("SELECT IdEspecie FROM GREEN_TEC.Especie WHERE IdTipoEspecie = 1")
animales = cursor.fetchall()
for animalPresa in tqdm(animales):
	animalesUsados = []
	for i in range(random.randint(1, 8)):
		cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie WHERE IdTipoEspecie = 1 AND IdCaracteristica = 3 OR IdCaracteristica = 5 ORDER BY newid()")
		animal = cursor.fetchone()[0]

		while animal in animalesUsados:
			cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie WHERE IdTipoEspecie = 1 AND IdCaracteristica = 3 OR IdCaracteristica = 5 ORDER BY newid()")
			animal = cursor.fetchone()[0]

		animalesUsados.append(animal)

		cursor.execute("INSERT INTO GREEN_TEC.Alimentacion(IdDepredador, IdPresa) Values (%d, %d)", 
			(animal, animalPresa))

print("Enlazando areas-animal")
cursor.execute("SELECT IdArea FROM Green_TEC.AREA WHERE Extension > 0")
areas = cursor.fetchall()
for area in tqdm(areas):
	especiesUsada = []

	for i in range(10, 33):
		cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie ORDER BY newid()")
		especie = cursor.fetchone()[0]

		while especie in especiesUsada:
			cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie ORDER BY newid()")
			especie = cursor.fetchone()[0]

		especiesUsada.append(especie)

		cursor.execute("INSERT INTO GREEN_TEC.EspecieXArea(IdEspecie, IdArea, Cantidad) VALUES(%d,%d,%d)", 
			(especie, area[0], random.randint(1, 50)))


print("Creando investigaciones")
presupuestos = [1000, 10000, 100000, 50000, 25000, 15000, 200000, 10000, 20000, 30000, 35000, 5000, 2500, 7500, 7000]
especiesUsada = []

for i in trange(35):
	date = fake.date_between(start_date="-6y", end_date="-1m")
	endDate = date + timedelta(weeks=random.randint(5*6, 5*28))

	cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie ORDER BY newid()")
	especie = cursor.fetchone()[0]

	while especie in especiesUsada:
		cursor.execute("SELECT TOP 1 IdEspecie FROM GREEN_TEC.Especie ORDER BY newid()")
		especie = cursor.fetchone()[0]

	especiesUsada.append(especie)

	cursor.execute("INSERT INTO GREEN_TEC.ProyectoInvestigacion(Presupuesto, FechaInicio, FechaFinal, IdEspecieInvestigada) VALUES(%d,%s,%s,%d)",
		(random.choice(presupuestos), date, endDate, especie))

print("Enlazando con investigadores")
cursor.execute("SELECT * FROM GREEN_TEC.Personal WHERE IdTipoPersonal = 3")
investigadores = cursor.fetchall()

for investigador in tqdm(investigadores):
	for i in range(random.randint(1,4)):
		cursor.execute("INSERT INTO GREEN_TEC.InvestigadorXProyecto(IdProyecto, IdInvestigador) VALUES(%d,%d)",
			(random.randint(1, 36), investigador[0]))

conn.commit()
conn.close()
