-- Database: pogotowie
--Baza danych pogotowia ratunkowego. Powinna gromadzić informacje o karetkach, zespołach
-- ratowniczych (kto wchodzi w skład zespołu), wezwaniach i zakresie udzielonej pomocy, a także
-- czasie wyjazdu i powrotu, osobach przyjmujących zgłoszenie



-- DROP DATABASE pogotowie;

CREATE DATABASE pogotowie
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pl_PL.UTF-8'
    LC_CTYPE = 'pl_PL.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


DROP TABLE IF EXISTS karetki CASCADE;
DROP TABLE IF EXISTS zespoly_ratownicze CASCADE;
DROP TABLE IF EXISTS medycy CASCADE;
DROP TABLE IF EXISTS wezwania CASCADE;
DROP TABLE IF EXISTS pomoc_udzielona CASCADE;


CREATE TABLE karetki (
	id SERIAL NOT NULL,
	nazwa varchar(50) NOT NULL,
	lokalizacja varchar(50) NULL,
	status varchar(10) NULL,
 	primary key (id),
	unique (nazwa)
);

CREATE TABLE medycy (
	id SERIAL NOT NULL, 
	imie varchar(50) NOT NULL,
	nazwisko varchar(50) NOT NULL,
	rola varchar(10) NOT NULL,
	primary key (id)
); 


CREATE TABLE zespoly_ratownicze (
	id SERIAL NOT NULL,
	ratownik int NOT NULL,
	lekarz int NOT NULL,
	kierowca int NOT NULL, 
	karetka int NOT NULL,
  	primary key (id),
	foreign key (ratownik) references medycy,
	foreign key (lekarz) references medycy,
	foreign key (kierowca) references medycy,
	foreign key (karetka) references karetki
);

CREATE TABLE wezwania (
	id SERIAL NOT NULL,
	data timestamp NOT NULL,
	zespol_ratowniczy int NOT NULL,
        primary key (id),
	foreign key (zespol_ratowniczy) references zespoly_ratownicze
);

CREATE TABLE pomoc_udzielona (
	id_wezwania int NOT NULL,
	opis varchar(50) NOT NULL,
	foreign key (id_wezwania) references wezwania
);

create or replace function sprawdz_zespol () returns trigger as $$
declare 
ile integer:=0;

begin
	select count(*) into ile
	from wezwania
	where zespol_ratowniczy = new.zespol_ratowniczy;

if ile > 1 then
	raise exception 'Na miejsce, nie może pojechać więcej niż jeden zespół ratowniczy';

else return new;

end if;

end;
$$ language plpgsql;
create trigger wezwania_pomoc
	before insert on wezwania
	for each row execute procedure sprawdz_zespol();


INSERT INTO karetki (nazwa, lokalizacja, status) VALUES ('BMW S7', 'Szpital Banacha', 'transporter');
INSERT INTO medycy (imie, nazwisko, rola) VALUES ('Marcin', 'Antos', 'dr');
INSERT INTO medycy (imie, nazwisko, rola) VALUES ('Jan', 'Kowalski', 'dr');
INSERT INTO medycy (imie, nazwisko, rola) VALUES ('Adam', 'Bartel', 'ra');
INSERT INTO medycy (imie, nazwisko, rola) VALUES ('Mateusz', 'Góral', 'ki');

INSERT INTO zespoly_ratownicze (ratownik, lekarz, kierowca, karetka) VALUES (2, 2, 3, 1);
INSERT INTO zespoly_ratownicze (ratownik, lekarz, kierowca, karetka) VALUES (2, 3, 1, 1);


INSERT INTO wezwania(data, zespol_ratowniczy) VALUES ('2020-02-02', 1);

INSERT INTO pomoc_udzielona(opis) VALUES ('RKO')