# Instukcja nr 2

## 1. Wszystkie dane dokumentów sprzedaży wraz z pełną nazwą i adresem klienta uporządkowane alfabetycznie według nazw klientów; tylko pierwszych 7 dokumentów sprzedaży 
``` sql
SELECT nagsprzedaz.*,nazwa,adres 
FROM nagsprzedaz JOIN klienci ON nagsprzedaz.idklienta=klienci.idklienta 
ORDER BY nazwa DESC LIMIT 7;

drugi sposób

SELECT nagsprzedaz.*,nazwa,adres 
FROM nagsprzedaz JOIN klienci USING (idklienta) 
ORDER BY nazwa DESC LIMIT 7;
```
## 2. Nazwy i adresy klientów, którzy kupowali w pierwszych pięciu dniach dowolnego miesiąca 
``` sql
SELECT nazwa,adres 
FROM nagsprzedaz JOIN klienci USING(idklienta) 
WHERE date_part('day', nagsprzedaz.datasp) < 6;
```
## 3. Identyfikatory produktów kupowanych między 25 a 30 dniem każdego miesiąca przez klienta K03. 
``` sql
SELECT DISTINCT idproduktu 
FROM pozsprzedaz JOIN nagsprzedaz USING(nrfaktury) 
WHERE (date_part('day', nagsprzedaz.datasp) >= 25 AND date_part('day', nagsprzedaz.datasp) <= 30) AND nagsprzedaz.idklienta='K03' ; 
```
## 4. Nazwy i adresy klientów, którzy kupili produkty Malfarba
``` sql
SELECT DISTINCT klienci.nazwa,klienci.adres 
FROM klienci JOIN nagsprzedaz USING(idklienta) JOIN pozsprzedaz USING(nrfaktury) JOIN produkty USING(idproduktu) 
WHERE producent='Malfarb';
```
## 5. Nazwy i adresy klientów z Sopotu lub Gdańska, którzy kupowali liczone na metry lub kilogramy produkty w cenie wyższej niż 40 
``` sql
SELECT DISTINCT klienci.nazwa,klienci.adres 
FROM klienci JOIN nagsprzedaz USING(idklienta) JOIN pozsprzedaz USING(nrfaktury) JOIN produkty USING(idproduktu) 
WHERE (miasto='Sopot' OR miasto='Gdańsk') AND (miara='kg' OR miara='m') AND cena>40;
```
## 6. Nazwy i producenci produktów, które nie były sprzedawane 
``` sql
SELECT produkty.nazwa,produkty.producent 
FROM produkty LEFT JOIN pozsprzedaz USING(idproduktu) 
WHERE nrfaktury IS Null ;
```
## 7. Identyfikatory sprzedanych produktów nie zapisanych w tabeli produkty 
``` sql
SELECT idproduktu 
FROM pozsprzedaz LEFT JOIN produkty USING(idproduktu) 
WHERE nazwa IS Null ;
```
## 8. Numery faktur i identyfikatory klientów, którym je wystawiono, ale o których to klientach nic poza identyfikatorem nie wiadomo
``` sql
SELECT nrfaktury,idklienta 
FROM nagsprzedaz LEFT JOIN klienci USING(idklienta) 
WHERE nazwa IS Null ;
```
## 9. Łączne sprzedane ilości poszczególnych produktów w postaci:a. (idproduktu, laczna_ilosc); b. nazwa produktu, laczna_ilosc) – są różnice?
``` sql
SELECT DISTINCT idproduktu, COUNT(ilosc) AS laczna_ilosc 
FROM pozsprzedaz 
GROUP BY idproduktu;
SELECT DISTINCT nazwa, COUNT(ilosc) AS laczna_ilosc 
FROM produkty JOIN pozsprzedaz USING(idproduktu) 
GROUP BY nazwa;
```
## 10. Numery, daty wystawienia i wartości brutto i poszczególnych dokumentów sprzedaży (faktur)
``` sql
SELECT DISTINCT nrfaktury, datasp, SUM((produkty.cena + produkty.vat)*ilosc) AS brutto 
FROM nagsprzedaz JOIN pozsprzedaz USING (nrfaktury) JOIN produkty USING(idproduktu) 
GROUP BY nrfaktury,datasp 
ORDER BY nrfaktury DESC ;
```
## 11. Dla każdego klienta (identyfikator) podaj wartość netto jego zakupów z okresu 15 lutego – 15 marca
``` sql
SELECT DISTINCT idklienta, SUM(produkty.cena*ilosc) AS netto 
FROM nagsprzedaz JOIN pozsprzedaz USING (nrfaktury) JOIN produkty USING(idproduktu) 
WHERE datasp BETWEEN '2021-02-15' AND '2021-03-15' 
GROUP BY idklienta;
```
## 12. Dla każdego klienta (identyfikator) podaj datę ostatniej sprzedaży i liczbę wystawionych mu faktur
``` sql
SELECT DISTINCT MAX(datasp) as ostatnia_data, COUNT(nrfaktury) AS liczba_faktur 
FROM nagsprzedaz 
GROUP BY idklienta;
```
## 13. Dla każdego klienta podaj wartość brutto jego zakupów z podziałem na zapłacone i niezapłacone.
``` sql
SELECT klienci.nazwa,SUM(produkty.cena*pozsprzedaz.ilosc*(1+produkty.vat)) as brutto,nagsprzedaz.zaplacono 
FROM klienci NATURAL JOIN nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu) 
GROUP BY klienci.nazwa,nagsprzedaz.zaplacono 
ORDER BY zaplacono;
```
## 14. Dni (data) z utargiem (brutto) większym niż 2000 
``` sql
SELECT datasp 
FROM klienci NATURAL JOIN nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu) 
GROUP BY datasp
HAVING SUM(produkty.cena*pozsprzedaz.ilosc*(1+produkty.vat))>2000; 
```
## 15. Liczone na sztuki produkty, które były sprzedawane co najmniej 5 razy; których łączna wartość sprzedaży wyniosła więcej niż 2000
``` sql
SELECT produkty.nazwa 
FROM klienci NATURAL JOIN nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu) 
GROUP BY produkty.nazwa,ilosc
HAVING SUM(produkty.cena*pozsprzedaz.ilosc*(1+produkty.vat))>2000 AND ilosc >= 5; 
```
## 16. Identyfikatory klientów, których ostatnia wizyta w sklepie odbyła się po 10 marca
``` sql
SELECT idklienta 
FROM nagsprzedaz 
WHERE datasp>'2021.03.10'
GROUP BY idklienta
```
## 17. Producent, którego produkty dały największe wpływy
``` sql
SELECT producent,SUM(produkty.cena*pozsprzedaz.ilosc*(1+produkty.vat)) 
FROM produkty NATURAL JOIN pozsprzedaz 
GROUP BY producent 
ORDER BY SUM(produkty.cena*pozsprzedaz.ilosc*(1+produkty.vat)) DESC LIMIT 1;
```
## 18. Nazwy klientów z siedzibami w tym samym mieście, co WodKanRem 
``` sql
SELECT nazwa,miasto FROM klienci ;
SELECT nazwa 
FROM klienci 
WHERE miasto LIKE 'Sopot' AND nazwa NOT LIKE 'WodKanRem'
```
## 19. Nazwy, adresy klientów, którzy nic nie kupowali w lutym
<span style="color:red">nie skończone</span>

``` sql
SELECT nazwa,miasto FROM klienci ;
SELECT DISTINCT nazwa,miasto 
FROM klienci NATURAL JOIN nagsprzedaz 
WHERE (datasp BETWEEN '2021-02-01' AND '2021-02-28');
SELECT DISTINCT nazwa,adres 
FROM klienci NATURAL JOIN nagsprzedaz 
WHERE (datasp BETWEEN '2021-01-01' AND '2021-01-31') OR (datasp BETWEEN '2021-03-01' AND '2021-12-31')
```
## 20. Identyfikator produktu, który był najczęściej kupowany
``` sql
SELECT idproduktu, SUM(ilosc) 
FROM pozsprzedaz 
GROUP BY idproduktu 
ORDER BY SUM(ilosc) DESC LIMIT 1
```
## 21. Dla każdego produktu podaj, ilu różnych klientów go kupowało
``` sql
SELECT DISTINCT produkty.nazwa,klienci.nazwa
FROM klienci NATURAL JOIN nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu) 
ORDER BY produkty.nazwa
```
## 22. Średnia wartość wystawionej faktury
``` sql
SELECT pozsprzedaz.nrfaktury,ROUND(AVG(cena*ilosc),2) as średnia
FROM pozsprzedaz JOIN produkty USING(idproduktu) 
GROUP BY pozsprzedaz.nrfaktury 
ORDER BY pozsprzedaz.nrfaktury
```
## 23. Nazwy klientów i numery faktur o wartości wyższej niż średnia wartość faktury
<span style="color:red">nie skończone</span>

``` sql
SELECT klienci.nazwa,nagsprzedaz.nrfaktury, COUNT(produkty.cena*pozsprzedaz.ilosc) AS wartosc
FROM klienci NATURAL JOIN nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu)
GROUP BY klienci.nazwa,nagsprzedaz.nrfaktury
HAVING COUNT(produkty.cena*pozsprzedaz.ilosc)>AVG(produkty.cena*pozsprzedaz.ilosc)
```
## 24. Jakie ilości poszczególnych produktów kupowano w poszczególnych miesiącach
``` sql
-SELECT date_part('Month',nagsprzedaz.datasp),SUM(ilosc),produkty.nazwa 
FROM nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu)
GROUP BY date_part('Month',nagsprzedaz.datasp),produkty.nazwa
ORDER BY date_part('Month',nagsprzedaz.datasp)
```
## 25. Identyfikatory produktów, których wartość sprzedaży (netto) w marcu wyniosła więcej niż 1000
<span style="color:red">nie skończone</span>

``` sql
SELECT produkty.idproduktu,COUNT(cena*ilosc) AS netto
FROM nagsprzedaz NATURAL JOIN pozsprzedaz JOIN produkty USING(idproduktu)
GROUP BY produkty.idproduktu,datasp
HAVING (datasp BETWEEN '2021-03-01' AND '2021-3-31') AND COUNT(cena*ilosc) >1000
```
## 26. Numery dokumentów sprzedaży, na które kupowano farby i taśmę malarską ( na jednym dokumencie
<span style="color:red">nie skończone</span>

``` sql
SELECT  nrfaktury,nazwa FROM produkty NATURAL JOIN pozsprzedaz WHERE (nazwa LIKE 'Farba%' OR nazwa LIKE 'Taśma%') AND (nazwa LIKE 'Farba%' OR nazwa LIKE 'Taśma%') ORDER BY nrfaktury DESC ;

```