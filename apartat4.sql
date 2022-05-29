select e.nom 
from empleats as e,ordinaris as o
where e.num_pass=o.num_pass AND o.num_pass not in (select a.empl_ord 
                            from assignacions as a,zones_biocontencio as z 
                            where a.zona = z.codi AND z.nivell='A');