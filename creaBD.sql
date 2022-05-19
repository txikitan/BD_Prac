drop database BD1;
create database BD1;
use BD1;

create table paisos (
    nom varchar(25),
    pot_desenv int(20),
    tractat_signat bit,
    constraint pk_paisos primary key (nom)
) engine = innodb;