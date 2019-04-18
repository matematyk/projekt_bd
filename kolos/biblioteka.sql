DROP TABLE wypozyczenie;
DROP TABLE osoba;
DROP TABLE ksiazka;
DROP TABLE gatunek;


CREATE TABLE gatunek (
  kod CHAR(3) PRIMARY KEY,
  nazwa VARCHAR2(20) NOT NULL
);

CREATE TABLE ksiazka(
	id NUMBER(3) PRIMARY KEY,
	tytul VARCHAR2(50) NOT NULL,
	autor VARCHAR2(50) NOT NULL,
	gatunek CHAR(3) NOT NULL  REFERENCES  gatunek
);

CREATE TABLE osoba(
	id NUMBER(3) PRIMARY KEY,
	imie VARCHAR2(20) NOT NULL,
	nazwisko VARCHAR2(20) NOT NULL
);
 
CREATE TABLE wypozyczenie(
	id_ksiazka NUMBER(3) NOT NULL REFERENCES ksiazka,
 	id_osoba NUMBER(3) NOT NULL REFERENCES osoba, 
	data_wyp DATE NOT NULL,
	data_zwr DATE,
	CONSTRAINT CHK_wyp_daty CHECK (data_wyp <= data_zwr),
	PRIMARY KEY(id_ksiazka, id_osoba, data_wyp)
);


INSERT INTO gatunek(kod, nazwa) VALUES ('POW','Powiesc');
INSERT INTO gatunek(kod, nazwa) VALUES ('FAN','Fantastyka');
INSERT INTO gatunek(kod, nazwa) VALUES ('KRY','Kryminal');

INSERT INTO osoba(id, imie, nazwisko) VALUES (1, 'Jan', 'Kowalski');
INSERT INTO osoba(id, imie, nazwisko) VALUES (2, 'Anna', 'Nowak');
INSERT INTO osoba(id, imie, nazwisko) VALUES (3, 'Adam', 'Markiewicz');
INSERT INTO osoba(id, imie, nazwisko) VALUES (4, 'Jolanta', 'Zych');
INSERT INTO osoba(id, imie, nazwisko) VALUES (5, 'Katarzyna', 'Dudek');
INSERT INTO osoba(id, imie, nazwisko) VALUES (6, 'Bartosz', 'Adamowicz');
INSERT INTO osoba(id, imie, nazwisko) VALUES (7, 'Anna', 'Adamowicz');

INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (1, 'Lalka', 'Bolesław Prus', 'POW');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (2, 'W Pustyni i Puszczy', 'Henryk Sieniewicz', 'POW');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (3, 'Bramy raju', 'Jerzy Andrzejewski', 'POW');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (4, 'Dziura w niebie', 'Tadeusz Konwicki', 'POW');


INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (11, 'Hobbit', 'J. R. R. Tolkien', 'FAN');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (12, 'Trylogia Husycka', 'Andrzej Sapkowski', 'FAN');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (13, 'Silmarilion', 'J. R. R. Tolkien', 'FAN');
 
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (21, 'Morderstwo w Orient Expressie', 'Agatha Christie', 'KRY');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (22, 'Dom zbrodni', 'Agatha Christie', 'KRY');
INSERT INTO ksiazka(id, tytul, autor, gatunek) VALUES (23, 'Okularnik', 'Katarzyna Bonda', 'KRY');

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (1, 4, to_date('05-08-2016', 'DD-MM-YYYY'), to_date('25-08-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (1, 3, to_date('01-09-2016', 'DD-MM-YYYY'), to_date('24-09-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (1, 1, to_date('25-10-2016', 'DD-MM-YYYY'), null);

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (1, 2, to_date('20-06-2016', 'DD-MM-YYYY'), to_date('25-06-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (2, 1, to_date('01-10-2016', 'DD-MM-YYYY'), to_date('22-10-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (2, 2, to_date('28-10-2016', 'DD-MM-YYYY'), to_date('22-11-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (2, 3, to_date('28-12-2016', 'DD-MM-YYYY'), to_date('02-01-2017', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (11, 1, to_date('28-10-2016', 'DD-MM-YYYY'), to_date('22-11-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (12, 1, to_date('28-09-2015', 'DD-MM-YYYY'), to_date('22-10-2015', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (21, 1, to_date('02-07-2016', 'DD-MM-YYYY'), to_date('03-08-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (22, 2, to_date('02-08-2016', 'DD-MM-YYYY'), to_date('20-08-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (23, 3, to_date('13-01-2016', 'DD-MM-YYYY'),  to_date('13-04-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (23, 2, to_date('02-08-2016', 'DD-MM-YYYY'), to_date('20-08-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (23, 3, to_date('22-10-2016', 'DD-MM-YYYY'), null);

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (11, 6, to_date('02-08-2017', 'DD-MM-YYYY'), to_date('20-08-2017', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (12, 6, to_date('02-08-2017', 'DD-MM-YYYY'), to_date('20-08-2017', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (13, 6, to_date('02-08-2017', 'DD-MM-YYYY'), null);

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (11, 7, to_date('02-12-2016', 'DD-MM-YYYY'), to_date('20-12-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (11, 7, to_date('02-12-2015', 'DD-MM-YYYY'), to_date('20-12-2015', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (12, 7, to_date('02-08-2016', 'DD-MM-YYYY'), to_date('10-12-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (13, 7, to_date('02-08-2016', 'DD-MM-YYYY'), to_date('10-12-2016', 'DD-MM-YYYY'));

INSERT INTO wypozyczenie(id_ksiazka, id_osoba, data_wyp, data_zwr)
VALUES (22, 1, to_date('02-09-2017', 'DD-MM-YYYY'), to_date('10-12-2017', 'DD-MM-YYYY'));

COMMIT;