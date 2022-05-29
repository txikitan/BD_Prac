select l.codi,l.nom 
from laboratoris as l, zones_biocontencio as z 
where z.codiLab= l.codi AND z.nivell='A'
order by l.nom asc;