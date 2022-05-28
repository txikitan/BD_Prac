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
    codi int(5) not null,
    nom varchar(25) not null,
    pais varchar(25) not null,
    constraint pk_laboratoris primary key (codi),
    constraint fk_laboratoris_paisos foreign key (pais) references paisos (nom)
) engine = innodb;
create table empleats (
    num_pass varchar(9) not null,
    nom varchar(10) not null,
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
    zona_assignada int(5),
    lab int(5),
    constraint pk_qualificats primary key (num_pass),
    constraint fk_qualificats_empleats foreign key (num_pass) references empleats(num_pass)
) engine = innodb;

create table zones_biocontencio(
    codi int(5) not null,
    codiLab int(5) not null,
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
    zona int(5) not null unique,
    lab int(5) not null,
    -- add check for potencial
    constraint ck_potencial CHECK (potencial >=1 AND potencial<=10),
    constraint pk_armes_biologiques primary key (nom),
    constraint fk_armes_biologiques_zones_biocontencio foreign key (zona,lab) references zones_biocontencio(codi,codiLab)
) engine = innodb;

create table assignacions(
    fecha date not null,
    empl_ord varchar(9) not null,
    zona int (5) not null,
    lab int(5) not null,
    data_fi date,
    constraint pk_assignacions primary key (fecha,empl_ord),
    constraint fk_assignacions_ordinaris foreign key (empl_ord) references ordinaris(num_pass),
    constraint fk_assignacions_zones_biocontencio foreign key (zona,lab) references zones_biocontencio(codi,codiLab)
) engine = innodb;

-- test checks
insert into paisos(nom,pot_desenv,tractat_signat) values ('Espanya',10,'S'); -- test for ck_tractat

insert into laboratoris(codi,nom,pais) values (00001, 'Lab01','Espanya');
insert into empleats(num_pass,nom) values ('12345','Gabriel');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('12345','Medicina',null,null);
insert into zones_biocontencio(codi,codiLab,nivell,responsable) values (00000,00001,'A','12345');--check for ck_nivell
update qualificats set zona_assignada=00000, lab = 00001 where num_pass = '12345';

insert into armes_biologiques(nom,fecha,potencial,zona,lab) values ('Arma1','2022-05-28',8,00000,00001); --check for potencial