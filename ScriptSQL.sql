--Authors: CQFidalgo
--Description: Database creation and population for markets management

drop table Falta;
drop type tipo_gravedad;
drop table Licencia;
drop type tipo_licencia;
drop table Almacen;
drop table Puesto;
drop table PersonalMercado;
drop table Mercado;
drop table PersonalPuesto;
drop table Familiar;
drop table Titular;
drop table Persona;

CREATE TABLE Persona (
        dni CHAR(10) not null,
        nombre CHAR(20) not null,
        apellido1 CHAR(20) not null,
        apellido2 CHAR(20) not null,
        PRIMARY KEY (dni)
);

CREATE TABLE Titular (
        dni CHAR(10) not null,
        activo BOOLEAN not null,
        PRIMARY KEY (dni),
        FOREIGN KEY (dni) REFERENCES Persona
);

CREATE TABLE Familiar (
        dni CHAR(10) not null,
        dni_familiar CHAR(10) not null,
        PRIMARY KEY (dni, dni_familiar),
        FOREIGN KEY (dni) REFERENCES Titular,
        FOREIGN KEY (dni_familiar) REFERENCES Titular
);

CREATE TABLE PersonalPuesto (
        dni CHAR(10) not null,
        dni_titular CHAR(10) not null,
        PRIMARY KEY (dni),
        FOREIGN KEY (dni) REFERENCES Persona,
        FOREIGN KEY (dni_titular) REFERENCES Titular
);

CREATE TABLE Mercado (
        nombre CHAR(30) not null,
        dirección CHAR(50) not null,
        PRIMARY KEY (nombre)
);
CREATE TABLE PersonalMercado (
        dni CHAR(10) not null,
        mercado CHAR(30) not null,
        profesion CHAR(20) not null,
        PRIMARY KEY (dni),
        FOREIGN KEY (dni) REFERENCES Persona,
        FOREIGN KEY (mercado) REFERENCES Mercado
);

CREATE TABLE Puesto (
        num_puesto INTEGER not null,
        mercado CHAR(30) not null,
        dias_cerrado INTEGER,
        ult_apertura DATE,
        PRIMARY KEY (num_puesto,mercado),
        FOREIGN KEY (mercado) REFERENCES Mercado
);

CREATE TABLE Almacen (
        num_almacen INTEGER not null,
        mercado CHAR(30) not null,
        num_puesto INTEGER,
        PRIMARY KEY (num_almacen,mercado),
        FOREIGN KEY (mercado) REFERENCES Mercado,
        FOREIGN KEY (num_puesto, mercado) REFERENCES Puesto
);

CREATE TYPE tipo_licencia AS ENUM ('Pescaderia', 'Carniceria', 'Fruteria', 'Minorista_polivalente_de_alimentacion', 'Panaderia', 'Bar', 'Otros');

CREATE TABLE Licencia (
        id INTEGER not null,
        dni_titular CHAR(10) not null,
        num_puesto INTEGER not null,
        mercado CHAR(30) not null,
        fecha_inicio_licencia DATE not null,
        fecha_fin_licencia DATE not null,
        fianza DECIMAL(5,2) not null,
        tipo tipo_licencia not null,
        impago INTEGER,
        fecha_inicio_impago DATE,
        fecha_inicio_suspension DATE,
        fecha_inicio_cierre_permitido DATE,
        fecha_fin_cierre_permitido DATE,
        PRIMARY KEY (id),
        FOREIGN KEY (dni_titular) REFERENCES Titular,
        FOREIGN KEY (num_puesto, mercado) REFERENCES Puesto
);

CREATE TYPE tipo_gravedad AS ENUM ('leve', 'grave', 'muy_grave');

CREATE TABLE Falta (
        id INTEGER not null,
        num_licencia INTEGER not null,
        fecha_falta DATE not null,
        gravedad tipo_gravedad not null,
        observacion CHAR(200) not null,
        fecha_sancion DATE not null,
        sancion_aplicada CHAR(50) not null,
        por_reiteración BOOLEAN not null,
        PRIMARY KEY (id),
        FOREIGN KEY (num_licencia) REFERENCES Licencia
);
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Persona values ('15789655D','Maria','Martinez','Ruano');
insert into Persona values ('18748659F','Juan','Garcia','Garcia');
insert into Persona values ('17586498R','Jorge','Martinez','Esquivel');
insert into Persona values ('18652348R','Purificacion','Roque','Garcia');
insert into Persona values ('18498532S','Eduardo','Rodriguez','Sanz');
insert into Persona values ('29786854K','Sandra','Ramirez','Anton');
insert into Persona values ('27895474K','Pedro','Gonzalez','Sainz');
insert into Persona values ('27848124S','Cristina','Muñoz','Moreno');
insert into Persona values ('28457689A','Ricardo','Torres','Romero');
insert into Persona values ('27849584S','Jimena','Ruiz','Jimenez');
insert into Persona values ('37849594D','Pedro','Dominguez','Herrero');
insert into Persona values ('35987486R','Amparo','Navajo','Gutierrez');
insert into Persona values ('37849856T','Sandra','Torres','Martin');
insert into Persona values ('38765098K','Alberto','Vazquez','Ramos');
insert into Persona values ('35465984R','Gabriela','Vasileva','Vutova');
insert into Persona values ('48559627N','Marcos','Ruiz','Fernandez');
insert into Persona values ('47859612J','Alicia','Nunes','Fernandes');
insert into Persona values ('47859684H','Rafael','Callejo','Sancho');
insert into Persona values ('47859625K','Raul','De Santos','Vazquez');
insert into Persona values ('47859625L','Antonio','Contero','Sanchez');
insert into Persona values ('57899617Z','Amparo','Martinez','Martin');
insert into Persona values ('57849968P','Alvaro','Salado','Velasco');
insert into Persona values ('57489654A','Isabel','Hernandez','Zamora');
insert into Persona values ('58749564U','Carla','Torres','Ramirez');
insert into Persona values ('58474541V','Millan','Frias','Martinez');
insert into Persona values ('68748454X','Juan','Aguado','Simon');
insert into Persona values ('68486467K','Sun','Lee','Chin');
insert into Persona values ('78459451D','Javier','Ruiz','Simon');
insert into Persona values ('71245769P','Noelia','Diaz','Izquierdo');
insert into Persona values ('79846852K','Claudia','Amor','Martin');
insert into Persona values ('74869582N','Ricardo','Madrid','Charro');
insert into Persona values ('76985246D','Lorena','Gonzalez','Garcia');
insert into Persona values ('78695812S','Fathallah','Benkirane','Loudiyi');
insert into Persona values ('74895726J','Oriol','Monzo','Alberti');
insert into Persona values ('73697452T','Nuria','Manzano','Salgado');
insert into Persona values ('79724596D','Fancundo','Martinez','Martinez');
insert into Persona values ('74128796P','Celia','Trenzado','Gil');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Titular values ('15789655D',TRUE);
insert into Titular values ('18748659F',TRUE);
insert into Titular values ('17586498R',FALSE);
insert into Titular values ('18652348R',TRUE);
insert into Titular values ('18498532S',FALSE);
insert into Titular values ('29786854K',TRUE);
insert into Titular values ('27895474K',TRUE);
insert into Titular values ('27848124S',TRUE);
insert into Titular values ('28457689A',FALSE);
insert into Titular values ('27849584S',TRUE);
insert into Titular values ('37849594D',TRUE);
insert into Titular values ('35987486R',TRUE);
insert into Titular values ('37849856T',TRUE);
insert into Titular values ('38765098K',TRUE);
insert into Titular values ('35465984R',TRUE);
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Familiar values ('35465984R', '38765098K');
insert into Familiar values ('38765098K', '35465984R');
insert into Familiar values ('15789655D', '18748659F');
insert into Familiar values ('18748659F', '15789655D');
insert into Familiar values ('15789655D', '17586498R');
insert into Familiar values ('17586498R', '15789655D');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into PersonalPuesto values ('48559627N', '15789655D');
insert into PersonalPuesto values ('47859612J', '18748659F');
insert into PersonalPuesto values ('47859684H', '18748659F');
insert into PersonalPuesto values ('47859625K', '29786854K');
insert into PersonalPuesto values ('47859625L', '27895474K');
insert into PersonalPuesto values ('57849968P', '27849584S');
insert into PersonalPuesto values ('57899617Z', '37849594D');
insert into PersonalPuesto values ('57489654A', '37849594D');
insert into PersonalPuesto values ('58749564U', '35987486R');
insert into PersonalPuesto values ('58474541V', '37849856T');
insert into PersonalPuesto values ('68748454X', '38765098K');
insert into PersonalPuesto values ('68486467K', '35465984R');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Mercado values ('Mercado de Aljaraque', 'Plaza Canovas S/N 21110 Aljaraque');
insert into Mercado values ('Mercado de Corrales', 'Calle San Jose S/N 21120 Aljaraque');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into PersonalMercado values ('78459451D', 'Mercado de Aljaraque', 'Veterinario');
insert into PersonalMercado values ('71245769P', 'Mercado de Aljaraque', 'Limpiador');
insert into PersonalMercado values ('79846852K', 'Mercado de Aljaraque', 'Limpiador');
insert into PersonalMercado values ('74869582N', 'Mercado de Aljaraque', 'Vigilante');
insert into PersonalMercado values ('76985246D', 'Mercado de Aljaraque', 'Responsable');
insert into PersonalMercado values ('78695812S', 'Mercado de Aljaraque', 'Mantenimiento');
insert into PersonalMercado values ('74895726J', 'Mercado de Corrales', 'Limpiador');
insert into PersonalMercado values ('73697452T', 'Mercado de Corrales', 'Limpiador');
insert into PersonalMercado values ('79724596D', 'Mercado de Corrales', 'Vigilante');
insert into PersonalMercado values ('74128796P', 'Mercado de Corrales', 'Mantenimiento');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Puesto values ('1', 'Mercado de Aljaraque', '0', '2018-11-27');
insert into Puesto values ('2', 'Mercado de Aljaraque', '1', '2018-11-26');
insert into Puesto values ('3', 'Mercado de Aljaraque', '2', '2018-11-25');
insert into Puesto values ('4', 'Mercado de Aljaraque', '3', '2018-11-27');
insert into Puesto values ('5', 'Mercado de Aljaraque', '12', '2018-11-27');
insert into Puesto values ('6', 'Mercado de Aljaraque', '15', '2018-11-27');
insert into Puesto values ('7', 'Mercado de Aljaraque', NULL, NULL);
insert into Puesto values ('8', 'Mercado de Aljaraque', '3', '2018-08-14');
insert into Puesto values ('9', 'Mercado de Aljaraque', '0', '2018-11-27');
insert into Puesto values ('10', 'Mercado de Aljaraque', '0', '2018-11-27');
insert into Puesto values ('11', 'Mercado de Aljaraque', '0', '2018-11-27');
insert into Puesto values ('12', 'Mercado de Aljaraque', '0', '2018-11-27');
insert into Puesto values ('13', 'Mercado de Aljaraque', '0', '2017-12-24');
insert into Puesto values ('1', 'Mercado de Corrales', '4', '2018-11-27');
insert into Puesto values ('2', 'Mercado de Corrales', '7', '2018-11-27');
insert into Puesto values ('3', 'Mercado de Corrales', '1', '2018-11-27');
insert into Puesto values ('4', 'Mercado de Corrales', NULL, NULL);
insert into Puesto values ('5', 'Mercado de Corrales', '3', '2018-11-27');
insert into Puesto values ('6', 'Mercado de Corrales', '1', '2018-11-27');
insert into Puesto values ('7', 'Mercado de Corrales', '3', '2018-11-27');
insert into Puesto values ('8', 'Mercado de Corrales', '15', '2018-11-27');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Almacen values ('1', 'Mercado de Aljaraque','2');
insert into Almacen values ('2', 'Mercado de Aljaraque', '3');
insert into Almacen values ('3', 'Mercado de Aljaraque', '5');
insert into Almacen values ('4', 'Mercado de Aljaraque', '10');
insert into Almacen values ('5', 'Mercado de Aljaraque', '12');
insert into Almacen values ('1', 'Mercado de Corrales', '1');
insert into Almacen values ('2', 'Mercado de Corrales', '5');
insert into Almacen values ('3', 'Mercado de Corrales', '6');
insert into Almacen values ('4', 'Mercado de Corrales', '8');
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Licencia values ('1', '15789655D', '1', 'Mercado de Aljaraque', '2017-09-06', '2027-09-06', '200.00','Pescaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('2', '15789655D', '2', 'Mercado de Aljaraque', '2017-09-06', '2027-09-06', '200.00','Carniceria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('3', '18748659F', '3', 'Mercado de Aljaraque', '2017-09-06', '2027-09-06', '200.00','Carniceria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('4', '18748659F', '12', 'Mercado de Aljaraque', '2017-09-06', '2027-09-06', '200.00','Fruteria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('5', '17586498R', '4', 'Mercado de Aljaraque', '2017-09-06', '2018-05-09', '200.00','Panaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('6', '17586498R', '6', 'Mercado de Aljaraque', '2017-09-06', '2018-05-09', '300.00','Carniceria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('7', '18652348R', '4', 'Mercado de Aljaraque', '2018-06-28', '2028-06-28', '200.00','Pescaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('8', '18652348R', '5', 'Mercado de Aljaraque', '2018-06-28', '2028-06-28', '200.00','Minorista_polivalente_de_alimentacion', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('9', '18498532S', '8', 'Mercado de Aljaraque', '2017-09-06', '2018-08-14', '200.00','Otros', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('10', '29786854K', '6', 'Mercado de Aljaraque', '2018-05-12', '2028-05-12', '300.00','Fruteria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('11', '29786854K', '9', 'Mercado de Aljaraque', '2018-05-12', '2028-05-12', '200.00','Panaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('12', '27895474K', '10', 'Mercado de Aljaraque', '2017-09-06', '2027-09-06', '300.00','Bar', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('13', '27848124S', '11', 'Mercado de Aljaraque', '2017-09-06', '2027-09-06', '200.00','Carniceria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('14', '28457689A', '13', 'Mercado de Aljaraque', '2017-09-06', '2017-12-24', '200.00','Pescaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('15', '27849584S', '6', 'Mercado de Corrales', '2017-09-06', '2027-09-06', '250.00','Panaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('16', '37849594D', '1', 'Mercado de Corrales', '2017-09-06', '2027-09-06', '200.00','Bar', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('17', '35987486R', '5', 'Mercado de Corrales', '2017-09-06', '2027-09-06', '150.00','Minorista_polivalente_de_alimentacion', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('18', '37849856T', '7', 'Mercado de Corrales', '2017-09-06', '2027-09-06', '200.00','Fruteria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('19', '38765098K', '3', 'Mercado de Corrales', '2017-09-06', '2027-09-06', '200.00','Carniceria', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('20', '38765098K', '2', 'Mercado de Corrales', '2017-09-06', '2027-09-06', '200.00','Pescaderia', '0', NULL, NULL, NULL, NULL);
insert into Licencia values ('21', '35465984R', '8', 'Mercado de Corrales', '2017-09-06', '2018-11-26', '300.00','Bar', '0', NULL, NULL, NULL, NULL);
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
insert into Falta values ('1', '8', '2018-07-17', 'leve', 'Discusion con un cliente a gritos', '2018-07-17', 'multa 120 euros', FALSE);
insert into Falta values ('2', '8', '2018-07-20', 'leve', 'Discusion con un cliente a gritos', '2018-07-21', 'multa 120 euros', FALSE);
insert into Falta values ('3', '8', '2018-08-15', 'leve', 'Discusion con un cliente a gritos', '2018-07-15', 'multa 120 euros', FALSE);
insert into Falta values ('4', '8', '2018-08-21', 'leve', 'Discusion con un cliente a gritos', '2018-07-21', 'multa 120 euros', FALSE);
insert into Falta values ('5', '8', '2018-08-21', 'grave', 'Reiteracion de mas de tres faltas leves en un año', '2018-07-21', 'suspension de la concesion 7 dias naturales', TRUE);
insert into Falta values ('6', '14', '2018-08-22', 'leve', 'Cierre no justificado', '2018-07-22', 'multa 120 euros', FALSE);
insert into Falta values ('7', '8', '2018-09-04', 'leve', 'Discusion con un cliente a gritos', '2018-09-04', 'multa 120 euros', FALSE);
insert into Falta values ('8', '8', '2018-09-07', 'leve', 'No cumplimiento de las instrucciones emanadas de la Administracion', '2018-09-10', 'suspension de la concesion 14 dias naturales', FALSE);
insert into Falta values ('9', '19', '2018-09-10', 'grave', 'No conservar albaranes de compra', '2018-09-10', 'multa 120 euros', FALSE);
insert into Falta values ('10', '6', '2018-10-30', 'grave', 'No tener los precios de los productos a la vista', '2018-10-30', 'multa 150 euros', FALSE);
insert into Falta values ('11', '8', '2018-11-01', 'grave', 'Alteracion grave del orden publico por producir escandalo', '2018-11-01', 'suspension de la concesion 21 dias naturales', FALSE);
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*RESTRICCIONES*/
/*Un titular no puede poseer mas de dos licencias con la misma denominacion por si o a traves de su conyuge y/o hijos.*/
/*Cada licencia tiene una fecha maxima de vigencia, que, en el caso de que no se haya especificado en el momento de su creacion, sera diez años posterior a la fecha de inicio.*/
/*La relación de Titular1 con Titular2 es la misma que la de Titular2 con Titular1, de forma que es reciproca. A la hora de contar familiares de un titular, esta relacion es exclusiva, de manera que solo se cuenta una relacion por cada par de titulares.*/
                                                                            
