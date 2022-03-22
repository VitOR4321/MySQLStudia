# Insturkcja nr 1
## 1. Oblicz ile wynosi 2 razy 2 (SELECT 2*2 AS iloczyn)
``` sql
SELECT 2*2 AS iloczyn;
```

## 2. Podaj wszystkie dane o klientach (SELECT * FROM klienci)

``` sql
SELECT * FROM klienci
```

## 3. Podaj identyfikator, nazwę, producenta i cenę każdego produktu.

``` sql
SELECT idproduktu,nazwa,producent,cena 
FROM produkty;
```

## 4. Nazwa, cena, stan produktów producenta Cersanit

``` sql
SELECT nazwa,stan,cena 
FROM produkty 
WHERE producent = 'Cersanit';
```

## 5. Identyfikator, nazwa, producent, cena produktów droższych niż 100

``` sql
SELECT idproduktu,nazwa,producent,cena 
FROM produkty 
WHERE cena>100;
```

## 6. Numer faktury, id klienta, data dokumentów sprzedaży z okresu 15 – 25 stycznia

```sql
SELECT * FROM nagsprzedaz
SELECT nrfaktury,idklienta,datasp 
FROM nagsprzedaz 
WHERE datasp >= '2021-01-15' AND datasp <= '2021-01-25';
```

## 7. Nazwa, cena, miara i stan lakierów

```sql
SELECT * FROM produkty
SELECT nazwa,miara,cena,stan 
FROM produkty WHERE nazwa LIKE 'Lakier%';
```

## 8. Identyfikator, nazwa, adres klientów z Gdyni i Sopotu

```sql
SELECT * FROM klienci
SELECT idklienta,nazwa,adres 
FROM klienci 
WHERE miasto = 'Gdynia' OR miasto = 'Sopot';
```

## 9. Nazwa, producent, stan produktów Malfarba i Cersanita ze stanami w granicach [200, 2000]

```sql
SELECT nazwa,producent,stan 
FROM produkty 
WHERE (producent LIKE 'Malfarb' OR producent LIKE 'Cersanit') AND stan >= 200 AND stan <= 2000;
```

## 10. Nazwa, miasto, rabat klientów z Gdyni lub Słupska lub z niezerowym rabatem

```sql
SELECT * FROM klienci
SELECT nazwa,miasto,rabat 
FROM klienci 
WHERE (miasto = 'Gdynia' OR miasto = 'Słupsk') OR  rabat>0.00;
```

## 11. Identyfikator, nazwa klienta z niezerowym rabatem z Gdyni lub Gdańska

```sql
SELECT idklienta,nazwa 
FROM klienci 
WHERE (miasto = 'Gdynia' OR miasto = 'Gdańsk') AND  rabat>0.00;
```

## 12. Pełna informacja o każdym produkcie oraz jego cena brutto (w tabeli przechowujemy cenę netto)

```sql
SELECT *, cena+vat AS cena_brutto 
FROM produ
```

## 13. Pełna informacja o nieopłaconych dokumentach sprzedaży oraz liczba dni jakie minęły od dnia sprzedaży do dziś

```sql
SELECT * FROM nagsprzedaz
SELECT *, CURRENT_DATE - datasp AS ile_minelo 
FROM nagsprzedaz 
WHERE zaplacono='nie';
```

## 14. Numery dokumentów sprzedaży na które sprzedano produkty o identyfikatorach P06, P15, P36

```sql
SELECT nrfaktury 
FROM pozsprzedaz 
WHERE idproduktu = 'P06' OR idproduktu = 'P015' OR idproduktu = 'P036';
```

## 15. Identyfikatory klientów, którzy kupowali w styczniu

```sql
SELECT idklienta 
FROM nagsprzedaz 
WHERE date_part('Month', datasp) = '01';
```

## 16. Identyfikatory produktów, które były sprzedawane

```sql
SELECT DISTINCT idproduktu 
FROM pozsprzedaz 
ORDER BY idproduktu
```

## 17. Wartości poszczególnych produktów, jakie mamy na stanie 

```sql
SELECT nazwa, cena*stan AS wartosc 
FROM produkty;
```

## 18. Numery i daty nieopłaconych dokumentów sprzedaży zrealizowanych w lutym 

```sql
SELECT nrfaktury,datasp 
FROM nagsprzedaz 
WHERE zaplacono='nie' AND date_part('Month', datasp) = '02';
```

## 19. Kiedy (data) pojawił się pierwszy klient

```sql
SELECT * FROM nagsprzedaz;
SELECT idklienta,datasp 
FROM nagsprzedaz 
ORDER BY datasp DESC LIMIT 1;
```

## 20. Nazwa i producent najdroższego produktu

```sql
SELECT nazwa,producent,cena 
FROM produkty 
ORDER BY cena DESC LIMIT 1;
```

## 21. Pełna informacja o dokumentach sprzedaży wraz z pełnymi danymi klienta

```sql
SELECT * 
FROM nagsprzedaz NATURAL JOIN klienci 
ORDER BY nrfaktury DESC ; 
```

## 22. Pełny opis pozycji sprzedaży oraz jej wartość netto i brutto 

```sql
SELECT pozsprzedaz.* ,cena AS netto, cena*vat+cena AS brutto 
FROM pozsprzedaz 
NATURAL JOIN produkty ORDER BY nrfaktury;
SELECT * FROM produkty
```

## 23. Nazwy, miary i stany sprzedawanych produktów producenta Cersanit 

```sql
SELECT * FROM pozsprzedaz
SELECT nazwa,miara,stan 
FROM produkty NATURAl JOIN pozsprzedaz 
WHERE producent='Cersanit';
```

## 24. Nazwy i miary farb i emulsji, które sprzedano w ilościach (ilosc*ilość_w_op) większych niż 10 

```sql
SELECT  nazwa,miara 
FROM produkty NATURAL JOIN pozsprzedaz 
WHERE (nazwa LIKE 'Farba%' OR nazwa LIKE 'Emulsja%') AND (ilosc*ilosc_w_op > 10);
SELECT nazwa,ilosc,ilosc_w_op 
FROM produkty NATURAL JOIN pozsprzedaz 
WHERE (nazwa LIKE 'Farba%' OR nazwa LIKE 'Emulsja%');
```

## 25. Numery dokumentów sprzedaży, na które kupowano farby i taśmę malarską ( na jednym dokumencie)

<span style="color:red">nie skończone</span>

```sql
SELECT nrfaktury,nazwa 
FROM produkty NATURAL JOIN pozsprzedaz 
WHERE (nazwa LIKE 'Farba%' OR nazwa LIKE 'Taśma%') AND (nazwa LIKE 'Farba%' OR nazwa LIKE 'Taśma%') 
ORDER BY nrfaktury DESC ;
```

## 26. Identyfikatory produktów zakupionych w okresie 15 stycznia – 15 lutego

```sql
SELECT DISTINCT idproduktu 
FROM pozsprzedaz NATURAL JOIN nagsprzedaz 
WHERE datasp BETWEEN '2021-01-15' AND '2021-02-15' ORDER BY idproduktu;
```