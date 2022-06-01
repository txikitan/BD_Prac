--BASES DE DADES--
--PRACTICA 3--
--Gabriel Garcia--
/*Obtenir els noms dels empleats ordinaris que no han estat mai assignats a cap
zona de biocontenció de nivell de perillositat Alt.*/
use BD1;
select e.nom 
from empleats as e,ordinaris as o
where e.num_pass=o.num_pass AND o.num_pass not in (select a.empl_ord 
                            from assignacions as a,zones_biocontencio as z 
                            where a.zona = z.codi AND z.nivell='A');