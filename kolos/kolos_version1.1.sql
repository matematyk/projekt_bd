-- (3 pkt) Wypisz tytuł i autora książek, których pierwsza litera tytułu to 'D' a przedostatnia 'i'.
select tytul 
from ksiazka 
where substr(tytul, LENGTH(tytul) -1 , 1) = 'i' and substr(tytul, 1, 1) = 'D'

-- (3 pkt) Wypisz tytuł, autora i nazwę gatunku wszystkich książek z gatunku 'Fantastyka' lub 'Kryminal'. Wyniki uporządkuj po autorze i nazwie książki.
select tytul, autor, gatunek 
from ksiazka 
where gatunek = 'FAN' or gatunek = 'KRY'
order by autor, tytul


--- (3 pkt) Wypisz imię i nazwisko osób, które nie mają aktualnie wypożyczonej żadnej książki.
select imie, nazwisko from osoba o where o.id not in (select w.id_osoba from wypozyczenie w where w.data_zwr is null)


-- (3 pkt) Wypisz ilość książek danego gatunku literackiego, które są w posiadaniu biblioteki. 
-- Wypisz nazwę gatunku i ilość książek.
-- Jeśli w bibliotece nie ma książek danego gatunku wypisz 0. 
-- Posortuj wyniki malejąco po liczbie książek, a w przypadku remisów po nazwie gatunku.
select nazwa, count(gatunek) ilosc_ksiazek
from gatunek g 
left join ksiazki k
on k.gatunek = g.kod
group by nazwa
order by ilosc_ksiazek desc, nazwa


--- (4 pkt) Wypisz id osób,
-- które wypożyczyły co najmniej dwie książki z każdego gatunku.
select id_osoba from (
    select id_osoba, gatunek, count(gatunek) count_gatunek
        from wypozyczenie w
        join osoba o
        on w.id_osoba = o.id
        left join ksiazka k
        on k.id = w.id_ksiazka
        group by id_osoba, gatunek 
        order by id_osoba)
group by id_osoba 
having count(id_osoba) = (select count(*) from gatunek) 


--- (4 pkt) Dla każdego gatunku literackiego wypisz listę osób, które wypożyczyły najwięcej książek z danego gatunku. Wpisz id osoby, kod gatunku literackiego oraz liczbę wypożyczonych ksiązek.
select distinct id_osoba, max(count_gatunek), gatunek from (
    select id_osoba, gatunek, count(gatunek) count_gatunek
        from wypozyczenie w
        join osoba o
        on w.id_osoba = o.id
        left join ksiazka k
        on k.id = w.id_ksiazka
        group by id_osoba, gatunek 
        order by id_osoba
) group by id_osoba, gatunek
