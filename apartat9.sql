update zones_biocontencio,armes_biologiques
set zones_biocontencio.nivell='A'
where armes_biologiques.zona=zones_biocontencio.codi and armes_biologiques.potencial>5;