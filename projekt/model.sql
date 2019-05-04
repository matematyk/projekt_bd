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
    Status VARCHAR2(7) NOT NULL,
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
    Date_application DATE NOT NULL,
    CONSTRAINT Tournament_apl_pk PRIMARY KEY (Application_ID),
    CONSTRAINT Tournament_Application_Tour
        FOREIGN KEY (Tournament_ID)
        REFERENCES Tournament (Tournament_ID),
    CONSTRAINT Tournament_Application_Ref
        FOREIGN KEY (Team_ID)
        REFERENCES Teams (Team_ID)
)


CREATE TABLE Games (
    Game_ID NUMBER(10) DEFAULT Games_seq.nextval NOT NULL,
    Date_Game DATE  NOT NULL,
    Result VARCHAR2(3)  NOT NULL,
    Team1_ID NUMBER(10)  NOT NULL,
    Team2_ID NUMBER(10) NOT NULL,
    Tournament NUMBER(10)  NOT NULL,
    CONSTRAINT Game_pk PRIMARY KEY (Game_ID),
    CONSTRAINT Game_Teams_1
        FOREIGN KEY (Team1_ID)
        REFERENCES Teams (Team_ID),
    CONSTRAINT Game_Teams_2
        FOREIGN KEY (Team2_ID)
        REFERENCES Teams (Team_ID)
);

CREATE TABLE Players (
    Player_ID NUMBER(10) DEFAULT Player_ID_seq.nextval NOT NULL,
    FirstName VARCHAR2(20) NOT NULL,
    LastName VARCHAR2(20)  NOT NULL,
    Team_ID NUMBER(10)  NOT NULL,
    CONSTRAINT Player_pk PRIMARY KEY (Player_ID),
    CONSTRAINT NalezyDoDruzyny
        FOREIGN KEY (Team_ID)
        REFERENCES Teams (Team_ID)
);


CREATE TABLE Sets_m (
    Set_ID NUMBER(10) DEFAULT Set_ID_seq.nextval NOT NULL,
    Game_ID NUMBER(10)  NOT NULL,
    NumerSet NUMBER(3)  NOT NULL,
    ResultSet_1 VARCHAR2(4)  NOT NULL,
    ResultSet_2 VARCHAR2(4)  NOT NULL,
    CONSTRAINT Sets_pk PRIMARY KEY (Set_ID),
    CONSTRAINT Sets_Games
        FOREIGN KEY (Game_ID)
        REFERENCES Games (Game_ID)

);

CREATE TABLE WhoPlays (
    Game_ID NUMBER(10) NOT NULL,
    Player_ID NUMBER(10)  NOT NULL,
    CONSTRAINT WhoPlays_Player
        FOREIGN KEY (Player_ID)
        REFERENCES Players (Player_ID),
    CONSTRAINT WhoPlays_Games
        FOREIGN KEY (Game_ID)
        REFERENCES Games (Game_ID)
);