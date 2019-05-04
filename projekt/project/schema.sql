DROP TABLE WhoPlays;
DROP TABLE Sets_m;
DROP TABLE Players;
DROP TABLE Users;
DROP TABLE Tournament_Application;
DROP TABLE Tournament;
DROP TABLE Games;
DROP TABLE Teams;


DROP SEQUENCE User_seq;
DROP SEQUENCE Tournament_Application_seq;
DROP SEQUENCE Tournament_seq;
DROP SEQUENCE Team_seq;
DROP SEQUENCE Games_seq;
DROP SEQUENCE WhoPlays_seq;
DROP SEQUENCE Set_ID_seq;
DROP SEQUENCE Player_ID_seq;

CREATE SEQUENCE User_seq START WITH 1;
CREATE SEQUENCE Tournament_Application_seq START WITH 1;
CREATE SEQUENCE Tournament_seq START WITH 1;
CREATE SEQUENCE Team_seq START WITH 1;
CREATE SEQUENCE Games_seq START WITH 1;
CREATE SEQUENCE WhoPlays_seq START WITH 1;
CREATE SEQUENCE Set_ID_seq START WITH 1;
CREATE SEQUENCE Player_ID_seq START WITH 1;

CREATE TABLE Users (
    User_ID NUMBER(10)  DEFAULT User_seq.nextval NOT NULL,
    Username VARCHAR2(64) NOT NULL,
    Password VARCHAR2(94) NOT NULL,
    Status VARCHAR2(7) NOT NULL
);

ALTER TABLE Users ADD (
    CONSTRAINT user_pk PRIMARY KEY (User_ID)
);


CREATE TABLE Teams (
    Team_ID NUMBER(10) DEFAULT Team_seq.nextval NOT NULL,
    TeamName VARCHAR2(40)  NOT NULL,
    CONSTRAINT Druzyny_pk PRIMARY KEY (Team_ID)
);

CREATE TABLE Tournament (
   Tournament_ID NUMBER(10) DEFAULT Tournament_seq.nextval NOT NULL,
   Tournament_NAME VARCHAR2(40) NOT NULL,
   Date_start DATE NOT NULL,
   Date_end DATE NOT NULL,

   CONSTRAINT Tournament_pk PRIMARY KEY (Tournament_ID)
)

CREATE TABLE Tournament_Application (
    Application_ID NUMBER(10) DEFAULT Tournament_Application_seq.nextval NOT NULL,
    Team_ID NUMBER(10)  NOT NULL,
    Tournament_ID NUMBER(10) NOT NULL,
    Date_application DATE NOT NULL
)


ALTER TABLE Tournament_Application ADD CONSTRAINT Tournament_Application_Ref
    FOREIGN KEY (Team_ID)
    REFERENCES Teams (Team_ID)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

ALTER TABLE Tournament_Application ADD CONSTRAINT Tournament_Application_Tour
    FOREIGN KEY (Tournament_ID)
    REFERENCES Tournament (Tournament_ID)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;


-- WHO PLAYS

CREATE TABLE WhoPlays (
    Game_ID NUMBER(10) NOT NULL,
    Player_ID NUMBER(10)  NOT NULL,
    CONSTRAINT WhoPlays_pk PRIMARY KEY (Game_ID, Player_ID)
);

ALTER TABLE WhoPlays ADD CONSTRAINT WhoPlays_Games
    FOREIGN KEY (Game_ID)
    REFERENCES Games (Game_ID)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;
ALTER TABLE WhoPlays ADD CONSTRAINT WhoPlays_Players
    FOREIGN KEY (Player_ID)
    REFERENCES Players (Player_ID)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

CREATE TABLE Games (
    Game_ID NUMBER(10) DEFAULT Games_seq.nextval NOT NULL,
    Date_Game DATE  NOT NULL,
    Result VARCHAR2(3)  NOT NULL,
    Team1_ID NUMBER(10)  NOT NULL,
    Team2_ID NUMBER(10) NOT NULL,
    Tournament NUMBER(10)  NOT NULL,
    CONSTRAINT Game_pk PRIMARY KEY (Game_ID)
);

ALTER TABLE Games ADD CONSTRAINT Game_Teams_2
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


-- SETS


CREATE TABLE Sets_m (
    Set_ID NUMBER(10) DEFAULT Set_ID_seq.nextval NOT NULL,
    Game_ID NUMBER(10)  NOT NULL,
    NumerSet NUMBER(3)  NOT NULL,
    ResultSet_1 VARCHAR2(4)  NOT NULL,
    ResultSet_2 VARCHAR2(4)  NOT NULL,
    CONSTRAINT Sets_pk PRIMARY KEY (Set_ID)
);

ALTER TABLE Sets_m ADD CONSTRAINT Sets_Games
    FOREIGN KEY (Game_ID)
    REFERENCES Games (Game_ID)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- PLAYERS

CREATE TABLE Players (
    Player_ID NUMBER(10) DEFAULT Player_ID_seq.nextval NOT NULL,
    FirstName VARCHAR2(20) NOT NULL,
    LastName VARCHAR2(20)  NOT NULL,
    Team_ID NUMBER(10)  NOT NULL,
    CONSTRAINT Player_pk PRIMARY KEY (Player_ID)
);



ALTER TABLE Players ADD CONSTRAINT NalezyDoDruzyny
    FOREIGN KEY (Team_ID)
    REFERENCES Teams (Team_ID)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;




INSERT INTO WhoPlays(Game_ID, Player_ID) VALUES (1, 1);
INSERT INTO WhoPlays(Game_ID, Player_ID) VALUES (1, 2);
INSERT INTO WhoPlays(Game_ID, Player_ID) VALUES (1, 3);


INSERT INTO Teams(TeamName) VALUES ('Francja');
INSERT INTO Teams(TeamName) VALUES ('Kanada');
INSERT INTO Teams(TeamName) VALUES ('Rosja');
INSERT INTO Teams(TeamName) VALUES ('Polska');

INSERT INTO Tournament(Tournament_NAME, Date_start, Date_end)
VALUES ('Memoriał Huberta Jerzego Wagnera', to_date('24-09-2018', 'DD-MM-YYYY'), to_date('26-09-2018', 'DD-MM-YYYY'));
INSERT INTO Tournament_Application(Team_ID, Tournament_ID, Date_application) VALUES (1, 1, to_date('24-07-2018', 'DD-MM-YYYY'));
INSERT INTO Tournament_Application(Team_ID, Tournament_ID, Date_application) VALUES (2, 1, to_date('24-07-2018', 'DD-MM-YYYY'));
INSERT INTO Tournament_Application(Team_ID, Tournament_ID, Date_application) VALUES (3, 1, to_date('24-07-2018', 'DD-MM-YYYY'));
INSERT INTO Tournament_Application(Team_ID, Tournament_ID, Date_application) VALUES (4, 1, to_date('24-07-2018', 'DD-MM-YYYY'));




--Polska        3:0 Kanada
INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
values (to_date('24-08-2018', 'DD-MM-YYYY'), '3:0', 4, 2, 1);
--Francja   1:3      Rosja
INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
values (to_date('24-08-2018', 'DD-MM-YYYY'), '1:3', 1, 3, 1);
--Polska    3:2      Francja
INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
values (to_date('25-08-2018', 'DD-MM-YYYY'), '3:2', 4, 1, 1);
--Rosja     3:2      Kanada
INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
values (to_date('25-08-2018', 'DD-MM-YYYY'), '3:2', 3, 2, 1);

--Francja   3:1      Kanada
INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
values (to_date('26-08-2018', 'DD-MM-YYYY'), '3:1', 1, 2, 1);
--Polska    3:2      Rosja
INSERT INTO Games(Date_game, Result, Team1_ID, Team2_ID, Tournament)
values (to_date('26-08-2018', 'DD-MM-YYYY'), '3:2', 4, 3, 1);



-- Polska 3:0 Kanada
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (1, 1, 29, 27);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (1, 2, 25, 17);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (1, 3, 25, 19);
--Francja   1:3      Rosja

INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2 ,1, 16, 25);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2 ,2, 25, 23);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2 ,3, 20, 25);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2 ,4, 24, 26);
--Polska    3:2      Francja

INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (3 ,1, 30, 28);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (3 ,2, 21, 25);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (3 ,3, 22, 25);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (3 ,4, 25, 21);
INSERT INTO Sets_m(Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (3 ,5, 15, 13);

--
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Artur' , 'Szalpuk' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Jakub' , 'Kochanowski' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Piotr' , 'Nowakowski' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Jenia' , 'Grebennikov' , 1);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Jean' , 'Patry' , 1);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Dmitrij' , 'Wołkow' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Mateusz ' , 'Bieniek' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Dawid ' , 'Konarski' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Maksim' , 'Michajłow' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Fiodor' , 'Rodiczew' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Dmitrij' , 'Muserski' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Bartosz' , 'Kwolek' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Michał' , 'Kubiak' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Damian' , 'Schulz' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Dmitrij' , 'Kowalew' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Artem' , 'Wołwicz' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Jegor' , 'Kliuka' , 3);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Paweł' , 'Zatorski' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Grzegorz' , 'Łomacz' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Aleksander' , 'Śliwka' , 4);
INSERT INTO Players(FirstName, LastName, Team_ID) VALUES ('Mateusz' , 'Bieniek' , 4);


CREATE OR REPLACE TRIGGER trg_check_dates
  BEFORE INSERT OR UPDATE ON Tournament_Application
  FOR EACH ROW
DECLARE
  data_startu Tournament.Date_start%TYPE;
BEGIN
        select Date_start into data_startu from Tournament ta where ta.Tournament_ID = :new.Tournament_ID;
        IF( :new.Date_application >= data_startu )
        THEN
             RAISE_APPLICATION_ERROR( -20001,
              'Invalid Date_start: Date_start must be lower than the current date' ||
              to_char( :new.Date_application, 'YYYY-MM-DD HH24:MI:SS' ) );
        END IF;
END;