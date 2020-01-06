-- dieta.sql
--zadanie 1  Dla każdego posiłku wypisz ile różnych produktów obejmuje.

select posilek, count(*)
from obejmuje 
group by posilek 

-- zadanie2  Posortuj posiłki względem malejącej sumarycznej liczby kalorii (wypisz identyfikator posiłku i liczbę kalorii). 
select obejmuje.posilek, sum(dostarcza.ile)
from obejmuje
join dostarcza 
on dostarcza.co = obejmuje.co 
where dostarcza.czego = 'energia'
group by obejmuje.posilek

select *
from obejmuje
join dostarcza 
on dostarcza.co = obejmuje.co 
where dostarcza.czego = 'energia'


--- 
select posilek
from dostarcza 
join obejmuje 
on dostarcza.co = obejmuje.co 
where dostarcza.czego ='energia'
group by posilek 
order by kalorie desc


-- zadanie3  Wypisz wszystkie pary różnych posiłków, które obejmują co najmniej 3 identyczne produkty. 
--- wyrwanie 
select A.posilek, B.posilek
from obejmuje A, obejmuje B
where A.co = B.co
and A.posilek < B.posilek
group by A.posilek, B.posilek 
--- 
select *
from obejmuje A, obejmuje B
where A.co = B.co
and A.posilek < B.posilek
order by A.posilek
--- 


select A.posilek, B.posilek
from obejmuje A, obejmuje B
where A.co = B.co
and A.posilek < B.posilek
group by A.posilek, B.posilek 
having count(*) >= 3 

--- zadanie4 Posortuj posiłki (malejąco) względem procentowego zaspokojenia zapotrzebowania na białko u dzieci (wypisz identyfikator posiłku i procent pokrytego zapotrzebowania).
select posilek, sum(dostarcza.ile*obejmuje.ile)/ (select ile from potrzebuje where czego ='bialko' and kto='D') kalorie
from dostarcza 
join obejmuje 
on dostarcza.co = obejmuje.co 
where dostarcza.czego='bialko'
group by posilek 
order by kalorie desc 

(select * from dostarcza)
(select * from obejmuje)
(select ile from potrzebuje where czego='bialko' and kto='D')

-- zadanie5  Dla każdej substancji odżywczej wypisz posiłek o minimalnej i maksymalnej jej zawartości. 
with zawartosc as (
select  posilek,
        sum(dostarcza.ile*obejmuje.ile)
from dostarcza 
join obejmuje 
on dostarcza.co = obejmuje.co 
group by posilek, czego)

with maxmin as (
select  czego,
        min(ile) min_zaw,
        max(ile) max_zaw
from zawartosc 
group by czego) 

from maxmin join zawartosc z_min 
on maxmin.czego=z_min.czego and min_zaw=z.min_zaw

select maxmin.czego, z_in.posilek 
from maxmin join zawartosc z_min 
join zawartosc z_max 
on maxmin.czego = z_min.czego and min_zaw=zmax.ile
and maxmin.czego= z_max.czego and max_zaw = zmaxile

-- zadanie5 Dla każdej substancji odżywczej wypisz posiłek o minimalnej i maksymalnej jej zawartości.
with zawartosc as 
(
select  posilek, 
        sum(dostarcza.ile*obejmuje.ile) 
from dostarcza 
join obejmuje 
on dostarcza.co = obejmuje.co 
group by posilek, czego
)

-- zadanie5 Dla każdej substancji odżywczej wypisz posiłek o minimalnej i maksymalnej jej zawartości.
-- maxmin przerobienie na swoje uzycie
select *
from 
    (select czego, 
            min(ile_new) min_zaw, 
            max(ile_new) max_zaw
    from (  select posilek, 
            sum(dostarcza.ile*obejmuje.ile) ile_new,
            czego
            from dostarcza 
            join obejmuje 
            on dostarcza.co = obejmuje.co 
            group by posilek, czego)
    group by czego)
join ( select posilek, 
            sum(dostarcza.ile*obejmuje.ile) ile_new,
            czego
            from dostarcza 
            join obejmuje 
            on dostarcza.co = obejmuje.co 
            group by posilek, czego)
on min_zaw = ile_new


from maxmin 
join zawartosc z_min 
on maxmin.czego=z_min.czego and min_zaw=z.min_zaw 
select  maxmin.czego, 
        z_in.posilek 
from maxmin 
join zawartosc z_min 
join zawartosc z_max 
on maxmin.czego = z_min.czego and min_zaw=zmax.ile and maxmin.czego= z_max.czego and max_zaw = zmaxile








