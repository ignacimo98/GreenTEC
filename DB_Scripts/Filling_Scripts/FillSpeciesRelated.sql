use GREEN_TEC;
GO

INSERT INTO [GREEN_TEC].[GREEN_TEC].[TipoEspecie] ([Nombre]) VALUES ('Animal');
INSERT INTO [GREEN_TEC].[GREEN_TEC].[TipoEspecie] ([Nombre]) VALUES ('Vegetal');
INSERT INTO [GREEN_TEC].[GREEN_TEC].[TipoEspecie] ([Nombre]) VALUES ('Mineral');

INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Floracion', 'True');
INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Floracion', 'False');
INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Dieta', 'Omnivoro');
INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Dieta', 'Carnivoro');
INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Dieta', 'Herbivoro');
INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Material', 'Roca');
INSERT INTO GREEN_TEC.GREEN_TEC.CaracteristicaEspecie (Nombre, Valor) VALUES ('Material', 'Cristal');


INSERT INTO GREEN_TEC.GREEN_TEC.Alimentacion (IdDepredador, IdPresa) VALUES (4, 5);
INSERT INTO GREEN_TEC.GREEN_TEC.Alimentacion (IdDepredador, IdPresa) VALUES (5, 6);
INSERT INTO GREEN_TEC.GREEN_TEC.Alimentacion (IdDepredador, IdPresa) VALUES (5, 2008);
INSERT INTO GREEN_TEC.GREEN_TEC.Alimentacion (IdDepredador, IdPresa) VALUES (2009, 2008);
