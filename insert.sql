
INSERT INTO Teams(Team_ID, TeamName) VALUES (1,'Francja');
INSERT INTO Teams(Team_ID, TeamName) VALUES (2,'Kanada');
INSERT INTO Teams(Team_ID, TeamName) VALUES (3,'Rosja');
INSERT INTO Teams(Team_ID, TeamName) VALUES (4,'Polska');

#Polska		3:0 Kanada
INSERT INTO Game(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (1, to_date('24-08-2018', 'DD-MM-YYYY'), '3:0', 4, 2 );
#Francja  	1:3 	 Rosja
INSERT INTO Game(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (2, to_date('24-08-2018', 'DD-MM-YYYY'), '1:3', 1, 3 );
#Polska  	3:2 	 Francja
INSERT INTO Game(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (3, to_date('25-08-2018', 'DD-MM-YYYY'), '3:2', 4, 1 );
#Rosja  	3:2 	 Kanada
INSERT INTO Game(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (4, to_date('25-08-2018', 'DD-MM-YYYY'), '3:2', 3, 2 );

#Francja  	3:1 	 Kanada
INSERT INTO Game(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (5, to_date('26-08-2018', 'DD-MM-YYYY'), '3:1', 1, 2 );
#Polska  	3:2 	 Rosja
INSERT INTO Game(Game_ID, Data, Result, Team1_ID, Team2_ID) 
values (6, to_date('26-08-2018', 'DD-MM-YYYY'), '3:2', 4, 3 );



## Polska 3:0 Kanada
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (1,1,1, 29, 27);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2,1,2, 25, 17);
INSERT INTO Sets_m(Set_ID, Game_ID, NumerSet, ResultSet_1, ResultSet_2) VALUES (2,1,2, 25, 19);
## 

INSERT INTO Sets_m(Team_ID, TeamName) VALUES (3,'Rosja');
INSERT INTO Sets_m(Team_ID, TeamName) VALUES (4,'Polska');

