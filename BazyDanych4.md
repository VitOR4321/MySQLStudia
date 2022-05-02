# Instukcja nr 4
## 1. Zapisz funkcję wyzwalacza (trigger) kontr_stan w swojej bazie rembud:
## -- baza rembud, funkcja trigger - kontrola zerowych stanów magazynu
```sql
declare
oldstan numeric(8,2);
nazproduktu text;
begin
select into oldstan stan from produkty where idproduktu = NEW.idproduktu;
select into nazproduktu nazwa from produkty where idproduktu = NEW.idproduktu;
if NEW.ilosc > oldstan then
 raise exception 'zabraklo towaru: %',nazproduktu;
end if;
return NEW;
end;

TRIGGER on pozsprzedaz BEFORE INSERT,UPDATE
INSERT INTO pozsprzedaz(nrfaktury,idproduktu,ilosc) VALUES (1,'P01',100);
```
## 2. Napisz funkcję wyzwalacza mod_mag oraz wyzwalacz wmod_mag aktualizujący stan magazynu o sprzedane ilości produktów w reakcji na wprowadzanie informacji o sprzedaży.
```sql
begin
UPDATE produkty SET stan=stan-NEW.ilosc WHERE idproduktu=NEW.idproduktu;
return NEW;
end;

TRIGGER on pozsprzedaz BEFORE INSERT
INSERT INTO pozsprzedaz(nrfaktury,idproduktu,ilosc) VALUES (1,'P01',11);
```

## 3. Zapisz funkcję serwerową klient_zaplacil(id_klienta, data_pocz, data_konc) wyliczającą ile łącznie dany klient zapłacił w sklepie w okresie od data_pocz do data_konc:

## Wypróbuj działanie funkcji w zapytaniach: 
## a. SELECT klient_zaplacil(‘K01’, ‘2020-03-01’, ‘2021-03-31’);
## b. SELECT id klienta, klient_zaplacil(id klienta, ‘2021-03-15’, ‘2021-03-31’) FROM klienci;
## c. Wykorzystaj funkcję klient_zaplacil w zapytaniu: Podaj wartości styczniowych zakupów poszczególnych 
## klientów pochodzących z Gdyni

```sql
klient_zaplacil(
id_klienta characeter IN, 
data_pocz date IN, 
data_konc date IN,
zaplacil numeric OUT
)

begin
SELECT INTO zaplacil SUM(ilosc*cena*(1+vat))
FROM nagsprzedaz NATURAL JOIN pozsprzedaz
NATURAL JOIN produkty
WHERE idklienta=id_klienta AND datasp >= data_pocz AND datasp <= data_konc;
End;

SELECT klient_zaplacil('K01', '2020-03-01', '2021-03-31');
SELECT idklienta, klient_zaplacil(idklienta, '2021-03-15', '2021-03-31') FROM klienci;
SELECT klient_zaplacil(idklienta, '2021-01-01', '2021-01-31') FROM klienci WHERE miasto='Gdynia';
```

## 4. Zdefiniuj funkcję serwerową licz_brutto obliczającą wartość brutto dla podanej wartości netto i vatu. Sformułuj zapytanie wyliczające wartości brutto poszczególnych produktów i wykorzystujące zdefiniowaną funkcję
```sql
licz_brutto(netto numeric IN, vat numeric IN, brutto numeric OUT)

begin
SELECT INTO brutto netto*(1+vat);
End;

SELECT licz_brutto(cena,vat) FROM produkty;
```

## 5. Zdefiniuj widok rejfakt tak aby wirtualna tabela zawierała następujące dane o fakturach: {nazwa klienta, nrfaktury, data sprzedaży, wartość netto, wartość vat, wartość brutto}
## Wykorzystaj widok w zapytaniach: 
## a. Podaj wartość podatku VAT jaki zapłacili poszczególni klienci (nazwa klienta, podatek)
## b. Podaj wartości netto i brutto zarobione przez rembud w poszczególnych miesiącach.

```sql
SELECT t1.nazwa,nrfaktury,datasp,cena AS netto,cena*vat AS vacik,licz_brutto(cena,vat) AS brutto FROM
klienci t1 JOIN(nagsprzedaz NATURAL JOIN pozsprzedaz NATURAL JOIN produkty) t2 ON t1.idklienta=t2.idklienta;

SELECT * FROM rejfakt;
SELECT nazwa,vacik FROM rejfakt;
SELECT SUM(netto) AS suma_netto,SUM(brutto) AS suma_brutto FROM rejfakt WHERE EXTRACT(MONTH FROM datasp)=1;
```
## 6. Zmodyfikuj funkcję kontr_stan z punktu 1 tak, aby odrzucona sprzedaż została zapisana w tabeli zamow (idzamow, datazamow, idproduktu, ilosc), gdzie idzamow jest kolejnym numerem, datazamow bieżącą datą, a idproduktu i ilosc podanymi w instrukcji INSERT identyfikatorem i ilością produktu.
```sql
declare
oldstan numeric(8,2);
nazproduktu text;
dataspr date;
begin
select into oldstan stan from produkty where idproduktu = NEW.idproduktu;
select into nazproduktu nazwa from produkty where idproduktu = NEW.idproduktu;
select into dataspr MAX(datasp) from nagsprzedaz ns where ns.nrfaktury = NEW.nrfaktury;
if NEW.ilosc > oldstan then
 INSERT INTO zamow(datazamow,idproduktu,ilosc) VALUES (dataspr, NEW.idproduktu, NEW.ilosc);
 select into NEW.ilosc 0;
end if;
return NEW;
end;

--INSERT INTO pozsprzedaz(nrfaktury,idproduktu,ilosc) VALUES (1,'P01',100);
--SELECT * FROM produkty;
--SELECT * FROM zamow;
```

## 7. Skonstruuj wyzwalacz, który nie dopuści do sprzedaży czegokolwiek klientowi, który jest zadłużony w rembud na więcej niż 500 zł (łączna wartość brutto jego niezapłaconych faktur wynosi co najmniej 500 zł)

```sql
declare
suma integer;
idk text;

begin
SELECT INTO idk idklienta
FROM pozsprzedaz NATURAL JOIN nagsprzedaz
WHERE nrfaktury=NEW.nrfaktury;
SELECT INTO suma SUM(cena*(1+vat))
FROM pozsprzedaz NATURAL JOIN nagsprzedaz NATURAL JOIN produkty
WHERE idklienta=idk AND zaplacono='nie' GROUP BY idklienta
LIMIT 1;
if suma>=500 then
	RAISE EXCEPTION '% jest zadłużony!', idk;
end if;
RETURN NEW;
end;

--TRIGGER on pozsprzedaz BEFORE INSERT

--INSERT INTO pozsprzedaz(nrfaktury,idproduktu,ilosc) VALUES (9,'P01',4);
```
## 8. Napisz wyzwalacz, który uniemożliwi obniżenie ceny produktu o więcej niż 10%

```sql
declare
ce_na numeric;

begin
SELECT INTO ce_na cena
FROM produkty WHERE idproduktu=NEW.idproduktu;

if NEW.cena<ce_na*0.9 then
	RAISE EXCEPTION 'Zniżka za duża!';
end if;
RETURN NEW;
end;

--TRIGGER on produkty BEFORE UPDATE
--UPDATE produkty SET cena=0.8*cena WHERE idproduktu='P01';
```
## 9. Zdefiniuj widok prodetal(idproduktu, nazproduktu, cena_brutto, stan). Wykorzystaj widok do:
## a. policzenia należności klienta K03 za zakupy zrealizowane w pierwszej połowie stycznia
## b. wskazania nazwy produktu z najwyższą ceną brutto

```sql
SELECT idproduktu, nazwa AS nazproduktu, licz_brutto(cena,vat) AS cena_brutto, stan FROM produkty;

SELECT SUM(ilosc*cena_brutto) FROM prodetal NATURAL JOIN pozsprzedaz NATURAL JOIN nagsprzedaz WHERE idklienta='K03'
AND EXTRACT(MONTH FROM datasp)=1;
SELECT nazproduktu FROM prodetal WHERE cena_brutto=(SELECT MAX(cena_brutto) FROM prodetal);
```
## 10. Zdefiniuj funkcję serwerową pierwszy_kontakt(id_klienta), która dla podanego identyfikatora klienta poda datę wystawienia jego pierwszej (najstarszej) faktury. Wykorzystaj ją w zapytaniach: 
## a. Kiedy wystawiono pierwsza fakturę klientowi K05? 
## b. Podaj, kiedy po raz pierwszy wystawiono faktury poszczególnym klientom z Sopotu
## c. Podaj nazwy klientów, którzy po raz pierwszy odwiedzili sklep później niż klient K03

```sql
pierwszy_kontake(id_klienta text IN, dataspr date OUT)

begin
SELECT INTO dataspr min(datasp) FROM nagsprzedaz WHERE idklienta=id_klienta;
end;

-- SELECT pierwszy_kontakt('K05');
-- SELECT pierwszy_kontakt(idklienta) FROM klienci WHERE miasto='Sopot';
-- SELECT nazwa FROM klienci WHERE pierwszy_kontakt(idklienta)>pierwszy_kontakt('K03');
```
## 11. Zdefiniuj funkcję serwerową srednia_producenta(nazproducenta) wyliczającą średnią cenę produktów dostarczanych przez danego producenta. Wykorzystaj ją w zapytaniach: 
## a. podaj średnią cenę produktów Cersanita
## b. podaj średnią cenę produktów u producentów dostarczających wiertarki (nazwa producenta, średnia cena jego produktów)

```sql
srednia_producenta(nazprducenta text IN, srednia numeric OUT)

begin
SELECT INTO srednia AVG(cena) FROM produkty WHERE producent=nazproducenta
GROUP BY producent;
end;

SELECT srednia_producenta('Cersanit');
SELECT DISTINCT producent,srednia_producenta(producent) FROM produkty WHERE producent
IN (SELECT DISTINCT producent FROM produkty WHERE nazwa LIKE '%iertarka%');
```
## 12. Zdefiniuj funkcję serwerową wart_faktury(numfaktury), która dla podanego numeru faktury wylicza wartość brutto tej faktury. Wypróbuj działanie funkcji w zapytaniach: 
## a. Policz średnią wartość faktury wystawianej w sklepie rembud.
## b. Podaj nazwy klientów (i numery ich faktur), których jednorazowe zakupy warte były więcej niż średnia wartość faktury.
## Spróbuj powyższe zapytania zapisać w SQL bez użycia funkcji wart_faktury

```sql
wart_faktury(numfaktury integer IN, wartosc numeric OUT)

begin
SELECT INTO wartosc SUM(ilosc*cena*(1+vat))
FROM pozsprzedaz NATURAL JOIN produkty
WHERE nrfaktury=numfaktury;
end;

SELECT AVG(wart_faktury(nrfaktury)) FROM nagsprzedaz;
SELECT nazwa,nrfaktury FROM nagsprzedaz NATURAL JOIN klienci WHERE wart_faktury(nrfaktury)>
(SELECT AVG(wart_faktury(nrfaktury)) FROM nagsprzedaz);
```
## 13. Zdefiniuj funkcję wart_producent(dzien, nazproducenta), która dla zadanej daty i nazwy producenta poda wartość sprzedaży produktów danego producenta w danym dniu. Jeśli w damym dniu nie sprzedano żadnego produktu wskazanego producenta funkcja powinna zwrócić wartość 0. Wypróbuj działanie funkcji w zapytaniu: 
## a. Podaj daty dni, kiedy producent Cersanit zarobił więcej niż 500 (dopasuj wartość). 
## b. Sformułuj powyższe zapytanie bez używania funkcji wart_producent

```sql
wart_producent(dzien date IN, nazproducenta text IN, wartosc numeric OUT)

begin
SELECT INTO wartosc SUM(ilosc*cena*(1+vat))
FROM produkty NATURAL JOIN pozsprzedaz NATURAL JOIN nagsprzedaz
WHERE producent=nazproducenta AND datasp=dzien;
if wartosc IS NULL then
	wartosc=0;
end if;
end;

SELECT wart_producent('2021-03-19','Stanley');
SELECT wart_producent('2021-03-19','Stankiewicz'); --0

-- SELECT datasp,wart_producent(datasp,'Cersanit') FROM nagsprzedaz WHERE wart_producent(datasp,'Cersanit')>500;

-- SELECT datasp, SUM(ilosc*cena*(1+vat))
-- FROM produkty NATURAL JOIN pozsprzedaz NATURAL JOIN nagsprzedaz
-- WHERE producent='Cersanit' AND wart_producent(datasp,'Cersanit')>500 GROUP BY datasp;

```
## 14. Zdefiniuj wyzwalacz, dodaj_klienta który podczas wprowadzania nagłówka sprzedaży dla klienta niezapisanego w tabeli klienci, najpierw zapisuje jego identyfikator w tabeli klienci, a następnie wprowadza nagłówek sprzedaży. (być może będzie to wymagało usunięcia więzów integralnościowych między odpowiednimi tabelami).

```sql
begin
if (SELECT COUNT(*) FROM klienci WHERE idklienta=NEW.idklienta)=0 then
	INSERT INTO klienci(idklienta) VALUES (NEW.idklienta);
end if;
return NEW;
end;

TRIGGER on nagsprzedaz BEFORE INSERT

INSERT INTO nagsprzedaz(idklienta,datasp,zaplacono) VALUES ('K56',CURRENT_DATE,'tak');
SELECT * FROM klienci;
-- Domyślnie brak wymagań co do więzów.
```
## 15. Zdefiniuj wyzwalacz, poz10 który nie pozwala zapisać dla jednego dokumentu sprzedaży więcej niż 10 pozycji, Przy próbie zapisu kolejnej pozycji tworzony jest nowy nagłówek i kolejne pozycje są wiązane z nowym nagłówkiem (ewentualnie z jakimś komunikatem informującym) (dla celów testowych można założyć mniejszą niż 10 liczbę pozycji).

```sql
declare
idk text;

begin
SELECT INTO idk MAX(idklienta) FROM nagsprzedaz NATURAL JOIN pozsprzedaz WHERE nrfaktury=NEW.nrfaktury;
if (SELECT COUNT(*) FROM pozsprzedaz WHERE nrfaktury=NEW.nrfaktury)>=10 then
	INSERT INTO nagsprzedaz(idklienta,datasp,zaplacono) VALUES(idk,CURRENT_DATE,'nie');
	NEW.nrfaktury=(SELECT MAX(nrfaktury) FROM nagsprzedaz);
	RAISE NOTICE 'Utworzono nowy nagłówek.';
end if;
RETURN NEW;
end;

TRIGGER on pozsprzedaz BEFORE INSERT

INSERT INTO pozsprzedaz(nrfaktury,idproduktu,ilosc) VALUES(1,'P04',14);
-- przed użyciem dodano kilka rekordów do faktury nr 1
```
## 16. Zdefiniuj wyzwalacz zmklient, który przy jakiejkolwiek zmianie w tabeli klienci zapisuje starą wersję tego wiersza w tabeli archklienci, zapisując dodatkowo datę dokonania zmiany.

```sql
-- Nowa, pusta tebela arch_klienci
SELECT * INTO archklienci
FROM klienci
WHERE 1 = 0;

begin
INSERT INTO archklienci(idklienta,nazwa,nip,adres,
	miasto,kod,rabat) VALUES
	(OLD.idklienta,OLD.nazwa,OLD.nip,OLD.adres,
	OLD.miasto,OLD.kod,OLD.rabat);
RETURN NEW;
end;

TRIGGER on klienci BEFORE UPDATE

UPDATE klienci SET adres='Winieckiego 4/1' WHERE adres='Irysowa 3';
SELECT * FROM archklienci;
```
## 17. Napisz wyzwalacz, który będzie pilnował, aby liczba produktów Black&Deckera i Boscha razem wziętych nie przekraczała liczby produktów Stanleya.

```sql
declare
c1 integer;
c2 integer;

begin
SELECT INTO c2 COUNT(*) FROM produkty WHERE producent='Stanley';
SELECT INTO c1 COUNT(*) FROM produkty WHERE producent='Black&Decker' OR producent='Bosch';
if (NEW.nazwa = 'Black&Decker' OR NEW.nazwa = 'Bosch') AND c1<(c2+1) then
	RAISE NOTICE 'Stasinek ma za małe udziały!';
end if;
return NEW;
end;

TRIGGER on produkty BEFORE INSERT
```
## 18. Zdefiniuj tabelę produkty1 o strukturze takiej, jak tabela produkty z dodatkową kolumną stan_minimalny (typ danych jak stan). Kolumnę stan_minimalny wypełnij wartościami równymi 5% stanu bieżącego. Następnie skonstruuj wyzwalacz, który w sytuacji sprzedaży zakończonej zejściem poniżej stanu minimalnego wyprowadzi stosowny komunikat.
```sql
--nowa tabela
SELECT *,FLOOR(0.05*stan) AS stan_minimalny INTO produkty1
FROM produkty

declare
st_kr numeric;
nazproduktu text;

begin
SELECT INTO st_kr (SELECT stan FROM produkty1 WHERE
idproduktu=NEW.idproduktu);
SELECT INTO nazproduktu (SELECT nazwa FROM produkty1
WHERE idproduktu=NEW.idproduktu);
if NEW.stan<st_kr then
	RAISE NOTICE 'Dokup %!', nazproduktu;
end if;
RETURN NEW;
end

TRIGGER on produkty, BEFORE UPDATE

UPDATE produkty1 SET stan=100 WHERE stan_minimalny=125;
```