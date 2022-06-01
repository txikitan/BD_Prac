--BASES DE DADES--
--PRACTICA 3--
--Gabriel Garcia--
/*Assignar el nivell de perillositat a ‘A’ (=alt) a aquelles zones de biocontenció
que desenvolupin alguna arma de potencial superior a 5.*/
use BD1;
update zones_biocontencio,armes_biologiques
set zones_biocontencio.nivell='A'
where armes_biologiques.zona=zones_biocontencio.codi and armes_biologiques.potencial>5;