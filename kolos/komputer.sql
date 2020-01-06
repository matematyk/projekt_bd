select *

from komputer 

join firma 

on firma.nazwa =  komputer.producent 

-- Podaj nazwy i adresy firm, które sprzedają co najmniej dwa modele komputerów tego samego typu.
-- moje 1
select typ, nazwa
    from firma 
        join komputer 
        on firma.nazwa = komputer.producent
    group by typ, nazwa
    having count(*) > 1

select min(cena) from komputer

-- wzorcowe 1
select distinct f.nazwa, f.adres
from firma f 
    join komputer k
    on f.nazwa = k.producent
group by f.nazwa, k.typ, f.adres
having count(*) >= 2;


-- Podaj nazwę i telefon firmy, która produkuje najtańszy komputer.
--- moje rozwiazanie 2
select * from komputer 
join firma 
on firma.nazwa = komputer.producent 
where komputer.cena = (select min(cena) from komputer)
-- wzorcowe 2
select distinct *
from firma 
    join komputer 
    on komputer.producent = firma.nazwa 
where komputer.cena = (select min(cena) from komputer)


select * from firma


--- moje rozwiazanie 3 
select komputer.producent from komputer 
join firma 
on firma.nazwa = komputer.producent 
group by komputer.producent

select komputer.typ, komputer.producent from komputer
where komputer.producent in (select komputer.producent from komputer 
join firma 
on firma.nazwa = komputer.producent 
group by komputer.producent)

-- Podaj typy komputerów, produkowane przez wszystkich (znanych) producentów.


select k.typ 
from komputer k 
group by k.typ
having count(distinct k.producent) = 
(select count(*) from firma) 


-- dodatkowe do 3 
select * from firma

select count(distinct k.producent) from komputer k
select * from komputer



insert into komputer values('HP-3d', 'awokado', 'energia1', '13011')
