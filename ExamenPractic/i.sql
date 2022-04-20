create database Konferenz

go

use Konferenz 

go





create table Wissenschaftler (

Id int primary key,

Name varchar(20),

Vorname varchar(20),

Forschungsgebiet varchar(50), 

Herkunftsland varchar(20))



create table Artikel (

Id int primary key,

Titel varchar(100), 

ErstDatum date)



create table geschrieben_von(

IdArtikel int,

IdWissenschaftler int,

primary key(IdArtikel,IdWissenschaftler),

foreign key (IdArtikel) references Artikel,

foreign key (IdWissenschaftler) references Wissenschaftler,

)



create table Zeitschrift (

ISSN varchar(10) primary key, 

Name varchar(100))



create table Verlag (

Id int primary key,

Name varchar(20), 

Adresse varchar(100)

)



create table Ausgabe (

Id int primary key,

AusgabenNr int, 

AusgabenJahr int, 

ZeitschriftISSN varchar(10), 

IdVerlag int,

foreign key (ZeitschriftISSN) references Zeitschrift,

foreign key (IdVerlag) references Verlag

)



create table erscheint_in (

Id int primary key,

IdArtikel int, 

ErstDatum date, 

SeiteBeginn int, 

SeiteEnde int, 

IdAusgabe int, 

foreign key (IdArtikel) references Artikel,

foreign key (IdAusgabe) references Ausgabe)



create table EditorialBoard (

IdWissenschaftler int,

IdAusgabe int,

primary key (IdWissenschaftler,IdAusgabe),

foreign key (IdWissenschaftler) references Wissenschaftler,

foreign key (IdAusgabe) references Ausgabe)

