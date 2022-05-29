select z.codi,l.nom
from zones_biocontencio as z, laboratoris as l
where z.codiLab=l.codi AND 3<  (select COUNT(q.zona_assignada)
                                from qualificats as q
                                where z.codi=q.zona_assignada and z.codiLab=q.lab)
order by l.codi, z.codi;