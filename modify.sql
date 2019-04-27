DROP TABLE Teams;
DROP TABLE Gracze;
DROP TABLE Games;
DROP TABLE Sets_m;
DROP TABLE Players;


CREATE TABLE Teams (
    Team_ID NUMBER(3)  NOT NULL,
    TeamName VARCHAR2(40)  NOT NULL,
    CONSTRAINT Druzyny_pk PRIMARY KEY (Team_ID)
);

CREATE TABLE WhoPlays (
    Game_ID NUMBER(3) NOT NULL,
    Player_ID NUMBER(3)  NOT NULL,
    CONSTRAINT WhoPlays_pk PRIMARY KEY (Game_ID, Player_ID)
);


CREATE TABLE Games (
    Game_ID NUMBER(3) NOT NULL,
    Data DATE  NOT NULL,
    Result VARCHAR2(3)  NOT NULL,
    Team1_ID NUMBER(3)  NOT NULL,
    Team2_ID NUMBER(3) NOT NULL,
    CONSTRAINT Game_pk PRIMARY KEY (Game_ID)
);

CREATE TABLE Sets_m (
    Set_ID NUMBER(3) NOT NULL,
    Game_ID NUMBER(3)  NOT NULL,
    NumerSet NUMBER(3)  NOT NULL,
    ResultSet_1 NUMBER(3)  NOT NULL,
    ResultSet_2 NUMBER(3)  NOT NULL,
    CONSTRAINT Sets_pk PRIMARY KEY (Set_ID)
);

CREATE TABLE Players (
    Player_ID NUMBER(3)  NOT NULL,
    FirstName VARCHAR2(20) NOT NULL,
    LastName VARCHAR2(20)  NOT NULL,
    Team_ID NUMBER(3)  NOT NULL,
    CONSTRAINT Player_pk PRIMARY KEY (Player_ID)
);

ALTER TABLE WhoPlays ADD CONSTRAINT WhoPlays_Games
    FOREIGN KEY (Game_ID)
    REFERENCES Games (Game_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Players ADD CONSTRAINT Players_Zawodnicy
    FOREIGN KEY (Player_ID)
    REFERENCES Players (Player_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Game ADD CONSTRAINT Game_Teams_2
    FOREIGN KEY (Team2_ID)
    REFERENCES Teams (Team_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Games ADD CONSTRAINT Game_Teams_1
    FOREIGN KEY (Team1_ID)
    REFERENCES Teams (Team_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Players ADD CONSTRAINT NalezyDoDruzyny
    FOREIGN KEY (Team_ID)
    REFERENCES Teams (Team_ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE Sets_m ADD CONSTRAINT Sets_Games
    FOREIGN KEY (Game_ID)
    REFERENCES Games (Game_ID)  
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
	from Players where player_id=new.player_id;

	select count(*) into ile 
	from Gracze g join Players z on g.player_id=z.player_id 
	where g.mecz_id=new.mecz_id and druzyna_id=druzynag group by druzyna_id;	
   
	if (ile > 5) then
    		raise exception 'Too many players';
  	end if;
	
	select druzyna1_id into druzyna1
	from Games where game_id=new.mecz_id;
	
	select druzyna2_id into druzyna2
	from Games where game_id=new.mecz_id;
	
	
	if (druzynag != druzyna1 and druzynag != druzyna2) then
		raise exception 'Nieuprawniony zawodnik';
	end if;
	
  return new;
end;
$$ language plpgsql;

create trigger t2 before insert or update
 on Gracze for each row
 execute procedure f2();



