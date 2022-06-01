--BASES DE DADES--
--PRACTICA 3--
--Gabriel Garcia--
/*Obtenir quines zones tenen més de 3 empleats qualificats. Concretament es
demana el codi de la zona conjuntament amb el nom del laboratori, ordenat per
laboratori i zona.*/
use BD1;
select z.codi,l.nom
from zones_biocontencio as z, laboratoris as l
where z.codiLab=l.codi AND 3<  (select COUNT(q.zona_assignada)
                                from qualificats as q
                                where z.codi=q.zona_assignada and z.codiLab=q.lab)
order by l.codi, z.codi;