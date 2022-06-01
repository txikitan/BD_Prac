--BASES DE DADES--
--PRACTICA 3--
--Gabriel Garcia--
/*Destituir a tots els responsables dels seus càrrecs, és a dir, passar-los de la
relació de “cap” a la relació “assignats”. Potser et sigui necessari fer un petit canvi en el
disseny per tal de poder aconseguir-ho. Si aquest és el vostre cas, escriviu també la
sentència per tal de fer aquest canvi.*/

use BD1;
start transaction;
alter table zones_biocontencio modify responsable varchar(9) null;

update qualificats,zones_biocontencio
set qualificats.zona_assignada=zones_biocontencio.codi, zones_biocontencio.responsable=null
where qualificats.num_pass=zones_biocontencio.responsable and qualificats.lab = zones_biocontencio.codiLab;
commit;