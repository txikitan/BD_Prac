start transaction;
alter table zones_biocontencio modify responsable varchar(9) null;
update qualificats,zones_biocontencio
set qualificats.zona_assignada=zones_biocontencio.codi, zones_biocontencio.responsable=null
where qualificats.num_pass=zones_biocontencio.responsable and qualificats.lab = zones_biocontencio.codiLab;
commit;