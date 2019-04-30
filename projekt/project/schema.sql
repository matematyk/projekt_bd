DROP TABLE Gracze;
DROP TABLE Games;
DROP TABLE Sets_m;
DROP TABLE Players;
DROP TABLE Users;

CREATE SEQUENCE User_seq START WITH 1;

CREATE TABLE Users (
    User_ID NUMBER(10)  DEFAULT User_seq.nextval NOT NULL,
    Username VARCHAR2(64) NOT NULL,
    Password VARCHAR2(94) NOT NULL
);
ALTER TABLE Users ADD (
    CONSTRAINT user_pk PRIMARY KEY (User_ID)
);



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
    ResultSet_1 VARCHAR2(4)  NOT NULL,
    ResultSet_2 VARCHAR2(4)  NOT NULL,
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


INSERT INTO Teams(Team_ID, TeamName) VALUES (1,'Francja');
INSERT INTO Teams(Team_ID, TeamName) VALUES (2,'Kanada');
INSERT INTO Teams(Team_ID, TeamName) VALUES (3,'Rosja');
INSERT INTO Teams(Team_ID, TeamName) VALUES (4,'Polska');

--Polska        3:0 Kanada
INSERT INTO Games(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (1, to_date('24-08-2018', 'DD-MM-YYYY'), '3:0', 4, 2 );
--Francja   1:3      Rosja
INSERT INTO Games(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (2, to_date('24-08-2018', 'DD-MM-YYYY'), '1:3', 1, 3 );
--Polska    3:2      Francja
INSERT INTO Games(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (3, to_date('25-08-2018', 'DD-MM-YYYY'), '3:2', 4, 1 );
--Rosja     3:2      Kanada
INSERT INTO Games(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (4, to_date('25-08-2018', 'DD-MM-YYYY'), '3:2', 3, 2 );

--Francja   3:1      Kanada
INSERT INTO Games(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (5, to_date('26-08-2018', 'DD-MM-YYYY'), '3:1', 1, 2 );
--Polska    3:2      Rosja
INSERT INTO Games(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (6, to_date('26-08-2018', 'DD-MM-YYYY'), '3:2', 4, 3 );



-- Polska 3:0 Kanada
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (1, 1, 1, 29, 27);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2, 1, 2, 25, 17);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (3, 1, 3, 25, 19);
--Francja   1:3      Rosja

INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (4, 2 ,1, 16, 25);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (5, 2 ,2, 25, 23);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (6, 2 ,3, 20, 25);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (7, 2 ,4, 24, 26);
--Polska    3:2      Francja

INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (8, 3 ,1, 30, 28);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (9, 3 ,2, 21, 25);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (10, 3 ,3, 22, 25);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (11, 3 ,4, 25, 21);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (11, 3 ,5, 15, 13);

--
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (1, 'Artur' , 'Szalpuk' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (2, 'Jakub' , 'Kochanowski' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (3, 'Piotr' , 'Nowakowski' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (4, 'Jenia' , 'Grebennikov' , 1);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (5, 'Jean' , 'Patry' , 1);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (6, 'Dmitrij' , 'Wołkow' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (7, 'Mateusz ' , 'Bieniek' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (8, 'Dawid ' , 'Konarski' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (9, 'Maksim' , 'Michajłow' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (10, 'Fiodor' , 'Rodiczew' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (11, 'Dmitrij' , 'Muserski' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (12, 'Bartosz' , 'Kwolek' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (13, 'Michał' , 'Kubiak' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (14, 'Damian' , 'Schulz' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (15, 'Dmitrij' , 'Kowalew' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (16, 'Artem' , 'Wołwicz' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (17, 'Jegor' , 'Kliuka' , 3);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (18, 'Paweł' , 'Zatorski' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (19, 'Grzegorz' , 'Łomacz' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (20, 'Aleksander' , 'Śliwka' , 4);
INSERT INTO Players(Player_ID, FirstName, LastName, Team_ID) VALUES (21, 'Mateusz' , 'Bieniek' , 4);
