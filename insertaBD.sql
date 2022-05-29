insert into paisos(nom,pot_desenv,tractat_signat) values ('Espanya',10,'S'); -- test for ck_tractat
insert into laboratoris(codi,nom,pais) values (00001, 'Lab01','Espanya');
insert into empleats(num_pass,nom) values ('12345','Gabriel');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('12345','Medicina',null,null);
insert into zones_biocontencio(codi,codiLab,nivell,responsable) values (00000,00001,'M','12345');--check for ck_nivell
update qualificats set zona_assignada=00000, lab = 00001 where num_pass = '12345';

insert into armes_biologiques(nom,fecha,potencial,zona,lab) values ('Arma1','2022-05-28',8,00000,00001); --check for potencial
insert into empleats(num_pass,nom) values('23456','Josep');
insert into ordinaris(num_pass) values ('23456');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-20','23456',00000,00001,'2022-05-28');


insert into empleats(num_pass,nom) values ('34567','Maria');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('34567','Biologia',00000,00001);
insert into empleats(num_pass,nom) values ('45678','Sonia');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('45678','Microbiologia',00000,00001);
insert into empleats(num_pass,nom) values ('56789','Alex');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('56789','Quimica',00000,00001);

insert into laboratoris(codi,nom,pais) values (00002, 'BCN-XXX','Espanya');
insert into empleats(num_pass,nom) values ('67891','Arnau');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('67891','Fisica',null,null);
insert into zones_biocontencio(codi,codiLab,nivell,responsable) values (00001,00002,'B','67891');
update qualificats set zona_assignada=00001, lab = 00002 where num_pass = '67891';
insert into empleats(num_pass,nom) values ('78912','Manel');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('78912','Matematiques',null,null);
insert into zones_biocontencio(codi,codiLab,nivell,responsable) values (00002,00002,'M','78912');
update qualificats set zona_assignada=00002, lab = 00002 where num_pass = '78912';
insert into empleats(num_pass,nom) values ('89123','Kilian');
insert into qualificats(num_pass,titulacio,zona_assignada,lab)values('89123','Estadistica',null,null);
insert into zones_biocontencio(codi,codiLab,nivell,responsable) values (00003,00002,'M','89123');
update qualificats set zona_assignada=00003, lab = 00002 where num_pass = '89123';

insert into empleats(num_pass,nom) values('91234','Aaron');
insert into ordinaris(num_pass) values ('91234');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-20','91234',00001,00002,'2022-05-29');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-21','91234',00002,00002,'2022-05-29');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-22','91234',00003,00002,'2022-05-29');

insert into empleats(num_pass,nom) values('00012','Jordi Guasch');
insert into ordinaris(num_pass) values ('00012');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-20','00012',00001,00002,'2022-05-29');
insert into assignacions(fecha,empl_ord,zona,lab,data_fi) values ('2022-05-21','00012',00002,00002,'2022-05-29');