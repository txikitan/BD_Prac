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

insert into paisos(nom,pot_desenv,tractat_signat) values ('Espanya',10,'S'); -- test for ck_tractat

insert into laboratoris(codi,nom,pais) values (00001, 'Lab01','Espanya');
insert into empleats(num_pass,nom) values ('12345','Gabriel');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('12345','Medicina',null,null);
insert into zones_biocontencio(codi,codiLab,nivell,responsable) values (00000,00001,'A','12345');--check for ck_nivell
update qualificats set zona_assignada=00000, lab = 00001 where num_pass = '12345';
insert into armes_biologiques(nom,fecha,potencial,zona,lab) values ('Arma1','2022-05-28',8,00000,00001); --check for potencial

--3
select l.codi,l.nom 
from laboratoris as l, zones_biocontencio as z 
where z.codiLab= l.codi AND z.nivell='A'
order by l.nom asc;

--4
insert into empleats(num_pass,nom) values('23456','Josep');
insert into ordinaris(num_pass) values ('23456');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-20','23456',00000,00001,'2022-05-28');
select e.nom 
from empleats as e,ordinaris as o
where e.num_pass=o.num_pass AND o.num_pass not in (select a.empl_ord 
                            from assignacions as a,zones_biocontencio as z 
                            where a.zona = z.codi AND z.nivell='A');

--5
insert into empleats(num_pass,nom) values ('34567','Maria');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('34567','Biologia',00000,00001);
insert into empleats(num_pass,nom) values ('45678','Sonia');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('45678','Microbiologia',00000,00001);
insert into empleats(num_pass,nom) values ('56789','Alex');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('56789','Quimica',00000,00001);
select z.codi,l.nom
from zones_biocontencio as z, laboratoris as l
where z.codiLab=l.codi AND 3<  (select COUNT(q.zona_assignada)
                                from qualificats as q
                                where z.codi=q.zona_assignada and z.codiLab=q.lab)
order by l.codi, z.codi;

--6
select o.*
from ordinaris as o,assignacions as a
where o.num_pass = a.empl_ord and o.num_pass in (select a.empl_ord 
                                                     from laboratoris as l,zones_biocontencio as z
                                                     where l.codi = z.codiLab and l.nom='BCN-XXX');