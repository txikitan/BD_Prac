--BASES DE DADES--
--PRACTICA 3--
--Gabriel Garcia--
--Fitxer de creació de la base de dades--
drop database BD1;
create database BD1;
use BD1;

create table paisos (
    nom varchar(25) not null,
    pot_desenv int(20) not null,
    tractat_signat char(1),
    constraint ck_tractat CHECK(tractat_signat = 'S' OR tractat_signat = 'N'),
    constraint pk_paisos primary key (nom)
) engine = innodb;

create table laboratoris (
    codi char(5) not null,
    nom varchar(25) not null,
    pais varchar(25) not null,
    constraint pk_laboratoris primary key (codi),
    constraint fk_laboratoris_paisos foreign key (pais) references paisos (nom)
) engine = innodb;

create table empleats (
    num_pass varchar(9) not null,
    nom varchar(20) not null,
    constraint pk_empleats primary key (num_pass)
) engine = innodb;

create table ordinaris (
    num_pass varchar(9) not null,
    constraint pk_ordinaris primary key (num_pass),
    constraint fk_ordinaris_empleats foreign key (num_pass) references empleats (num_pass)
) engine = innodb;

create table qualificats (
    num_pass varchar(9) not null,
    titulacio varchar(25) not null unique,
    zona_assignada char(5),
    lab char(5),
    constraint pk_qualificats primary key (num_pass),
    constraint fk_qualificats_empleats foreign key (num_pass) references empleats(num_pass)
) engine = innodb;

create table zones_biocontencio(
    codi char(5) not null,
    codiLab char(5) not null,
    nivell char(1) not null,
    responsable varchar(9) not null,
    constraint ck_nivell CHECK(nivell = 'A' OR nivell = 'B' OR nivell = 'M'),
    constraint pk_zones_biocontencio primary key (codi,codiLab),
    constraint fk_zones_biocontencio_laboratoris foreign key (codiLab) references laboratoris (codi),
    constraint fk_zones_biocontencio_qualificats foreign key (responsable) references qualificats(num_pass)
) engine = innodb;

alter table qualificats add constraint fk_qualificats_zones_biocontencio foreign key (zona_assignada, lab) references zones_biocontencio(codi, codiLab);

create table armes_biologiques(
    nom varchar(25) not null,
    fecha date not null,
    potencial tinyint(2) not null,
    zona char(5) not null unique,
    lab char(5) not null,
    constraint ck_potencial CHECK (potencial >=1 AND potencial<=10),
    constraint pk_armes_biologiques primary key (nom),
    constraint fk_armes_biologiques_zones_biocontencio foreign key (zona,lab) references zones_biocontencio(codi,codiLab)
) engine = innodb;

create table assignacions(
    fecha date not null,
    empl_ord varchar(9) not null,
    zona char (5) not null,
    lab char(5) not null,
    data_fi date,
    constraint pk_assignacions primary key (fecha,empl_ord),
    constraint fk_assignacions_ordinaris foreign key (empl_ord) references ordinaris(num_pass),
    constraint fk_assignacions_zones_biocontencio foreign key (zona,lab) references zones_biocontencio(codi,codiLab)
) engine = innodb;