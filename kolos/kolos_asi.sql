CREATE TABLE Osoby (
	PESEL CHAR(11) PRIMARY KEY,
	IMIE VARCHAR(15) NOT NULL,
	NAZWISKO VARCHAR(20) NOT NULL,
	DATA_URODZENIA DATE,
	CHECK (LENGTH(PESEL) = 11),
	CHECK (LEFT(PESEL,2) = SUBSTRING(YEAR('1939-09-01'),3,2)),
	CHECK (SUBSTRING(PESEL,2,4) = MONTH('1939-09-01'))
);

insert into Osoby values ('39090100001','Jan','Kowalski','1939-09-01');
insert into Osoby values ('750218','Adam','Nowak','1975-02-18');
insert into Osoby values ('75021800123','Adam','Nowak','1975-02-20');
insert into Osoby values ('75021800123','Adam','Nowak','1975-02-18');
select * from Osoby

select SUBSTRING('39090100001',3,2) = '';
select SUBSTRING(YEAR('1939-09-01'),3,2)

 SELECT LEFT("SQL Tutorial", 3) AS ExtractString; 

insert into Osoby values('39090100001','Jan’,’Kowalski','1939-09-01');

select * from Osoby 

select date_part('year', '1975-02-20');

-- zadanie 1
use kolos;
select * from Ubezpieczenie where os_id = 13; 

-- Zadanie2 wypisz wszystkie info. o agentach, ktorzy kiedykolwiek ubezpieczyli osobe o id 13 
select * from Ubezpieczenie join Agent on Ubezpieczenie.ag_id = Agent.id and os_id = 13 
desc Ubezpieczenie
-- zadanie 4 
select * from Agent a left join Ubezpieczenie u on a.id=u.ag_id where u.skladka IS Null

-- wypisz maksymalna liczbe ubezpieczeń jednej osoby 
-- 
select u.os_id, count(*) from Ubezpieczenie u group by u.os_id 
-- zad 5 


select * from osoba o left join Ubezpieczenie u on o.id = u.os_id where u.wariant <> 'd' 
-- zad6 select max(skladka) from Ubezpieczenie

-- 
select max(x.liczba) from (select count(*) as liczba from Ubezpieczenie group by os_id) x



desc osoba
select o.imie, a.imie from osoba o, Agent a
 
select imie from Agent
desc Agent


-- 8 wypisz wszystkie mozliwe kombinacje imion
select * from ((select imie from osoba) x cross join (select imie from Agent) y)

-- 9 

-- 10 

select DISTINCT miasto from Osoba