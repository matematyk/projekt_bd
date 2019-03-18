DROP TABLE IF EXISTS Teams CASCADE;
DROP TABLE IF EXISTS Gracze CASCADE;
DROP TABLE IF EXISTS Mecze CASCADE;
DROP TABLE IF EXISTS Sets CASCADE;
DROP TABLE IF EXISTS Zawodnicy CASCADE;


CREATE TABLE Teams (
    Druzyna_ID SERIAL  NOT NULL,
    Nazwa varchar(40)  NOT NULL,
    CONSTRAINT Druzyny_pk PRIMARY KEY (Druzyna_ID)
);

CREATE TABLE Gracze (
    Mecz_ID int NOT NULL,
    Zawodnik_ID int  NOT NULL,
    CONSTRAINT Gracze_pk PRIMARY KEY (Mecz_ID,Zawodnik_ID)
);


CREATE TABLE Mecze (
    Mecz_ID SERIAL NOT NULL,
    Data date  NOT NULL,
    Wynik varchar(3)  NOT NULL,
    Druzyna1_ID int  NOT NULL,
    Druzyna2_ID int  NOT NULL,
    CONSTRAINT Mecze_pk PRIMARY KEY (Mecz_ID)
);

CREATE TABLE Sets (
    Set_ID SERIAL NOT NULL,
    Mecz_ID int  NOT NULL,
    NumerSet int  NOT NULL,
    WynikSet_1 int  NOT NULL,
    WynikSet_2 int  NOT NULL,
    CONSTRAINT Sets_pk PRIMARY KEY (Set_ID)
);

CREATE TABLE Zawodnicy (
    Zawodnik_ID SERIAL  NOT NULL,
    Imie varchar(20)  NOT NULL,
    Nazwisko varchar(20)  NOT NULL,
    Druzyna_ID int  NOT NULL,
    CONSTRAINT Zawodnicy_pk PRIMARY KEY (Zawodnik_ID)
);

ALTER TABLE Gracze ADD CONSTRAINT Gracze_Mecze
    FOREIGN KEY (Mecz_ID)
    REFERENCES Mecze (Mecz_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Gracze ADD CONSTRAINT Gracze_Zawodnicy
    FOREIGN KEY (Zawodnik_ID)
    REFERENCES Zawodnicy (Zawodnik_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Mecze ADD CONSTRAINT Mecze_Druzyny
    FOREIGN KEY (Druzyna2_ID)
    REFERENCES Teams (Druzyna_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Mecze ADD CONSTRAINT Mecze_Druzyny_1
    FOREIGN KEY (Druzyna1_ID)
    REFERENCES Teams (Druzyna_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Zawodnicy ADD CONSTRAINT NalezyDoDruzyny
    FOREIGN KEY (Druzyna_ID)
    REFERENCES Teams (Druzyna_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Sets ADD CONSTRAINT Sets_Mecze
    FOREIGN KEY (Mecz_ID)
    REFERENCES Mecze (Mecz_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Wyzwalacz pilnujący, żeby mieć nie więcej niż 6 zawodników
-- danej drużyny w meczu, oraz żeby grali tylko zawodnicy druzyn meczu

create or replace function f2 () returns trigger as $$
declare
	  ile integer := 0;
	  druzyna1 integer :=0;
	  druzyna2 integer :=0;
	  druzynag integer :=0;
begin

	select druzyna_id into druzynag
	from Zawodnicy where zawodnik_id=new.zawodnik_id;

	select count(*) into ile 
	from Gracze g join Zawodnicy z on g.zawodnik_id=z.zawodnik_id 
	where g.mecz_id=new.mecz_id and druzyna_id=druzynag group by druzyna_id;	
   
	if (ile > 5) then
    		raise exception 'Za duzo zawodnikow';
  	end if;
	
	select druzyna1_id into druzyna1
	from Mecze where mecz_id=new.mecz_id;
	
	select druzyna2_id into druzyna2
	from Mecze where mecz_id=new.mecz_id;
	
	
	if (druzynag != druzyna1 and druzynag != druzyna2) then
		raise exception 'Nieuprawniony zawodnik';
	end if;
	
  return new;
end;
$$ language plpgsql;

create trigger t2 before insert or update
 on Gracze for each row
 execute procedure f2();



