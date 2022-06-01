--BASES DE DADES--
--PRACTICA 3--
--Gabriel Garcia--
/*Obtenir el codi i nom dels laboratoris que tenen alguna zona de biocontenció d’alt nivell de perillositat.
segons el nom del laboratori*/
use BD1;
select distinct l.codi,l.nom 
from laboratoris as l, zones_biocontencio as z 
where z.codiLab= l.codi AND z.nivell='A'
order by l.nom asc;