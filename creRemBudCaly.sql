﻿CREATE TABLE klienci
(
   idklienta character(5),
   nazwa character varying(30),
   nip character(8),
   adres character varying(30),
   miasto character varying(20),
   kod character(6),
   rabat numeric(6,2)
);

CREATE TABLE produkty
(
  idproduktu character(5),
  nazwa character varying(30),
  cena numeric(8,2),
  vat numeric(6,2),
  ilosc_w_op numeric(8,2),
  miara character varying(10),
  producent character varying(30),
  stan numeric(8,2)
 );

CREATE TABLE nagsprzedaz
(
  nrfaktury serial,
  idklienta character(5),
  datasp date,
  zaplacono character(3)
 );  

CREATE TABLE pozsprzedaz
(
   idpoz serial,
   nrfaktury integer,
   idproduktu character(5),
   ilosc numeric(8,2)
);

INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K01', 'Budrex Sp z.o.o.', '222-3333', 'Kwiatowa 1', 'Gdynia', '80-980', 0.03);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K02', 'Posadzki Remonty', '99-88732', 'Różana 13', 'Gdańsk', '70-231', 0.02);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K03', 'WodKanRem', '98-99995', 'Tulipanowa 11', 'Sopot', '23-090', 0.00);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K04', 'Hydrobud', '76-45940', 'Storczykowa 2', 'Gdynia', '78-909', 0.02);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K05', 'Docieplacz', '45-95959', 'Fiołkowa 14', 'Gdynia', '80-807', 0.00);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K06', 'Sprawny Malarz', '89-85858', 'Storczykowa 16', 'Gdańsk', '70-978', 0.00);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K07', 'Gładzki Sp z o.o.', '99-99999', 'Narcyzowa 23', 'Słupsk', '70-490', 0.00);
INSERT INTO klienci (idklienta, nazwa, nip, adres, miasto, kod, rabat) VALUES ('K09', 'Piękne Wnętrze', '88-77777', 'Irysowa 3', 'Sopot', '22-444', 0.02);


INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P01', 'Wiertarka udarowa KR55', 129, 0.23, 1, 'szt', 'Black&Decker', 30);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P02', 'Wiertarka udarowa PSB 700', 367, 0.23, 1, 'szt', 'Bosch', 25);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P03', 'Wiertarka udarowa KR68', 155, 0.23, 1, 'szt', 'Black&Decker', 23);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P04', 'Wyrzynarka KS54', 188, 0.23, 1, 'szt', 'Black&Decker', 22);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P05', 'Poziomica S34', 99, 0.23, 1, 'szt', 'Stanley', 15);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P06', 'Poziomica u34', 107, 0.23, 1, 'szt', 'Stanley', 22);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P07', 'Piła płatnica', 94, 0.23, 1, 'szt', 'Stanley', 35);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P08', 'Piła do pustaków', 333, 0.23, 1, 'szt', 'Stanley', 20);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P09', 'Ścisk stolarski', 99, 0.23, 1, 'szt', 'Stanley', 25);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P10', 'Imadło modelarskie', 103, 0.23, 1, 'szt', 'Stanley', 28);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P11', 'Płytki łazienkowe A1 50 cm', 9.43, 0.08, 10.8, 'cm', 'Cersanit', 1850);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P12', 'Płytki łaz B3 30 cm', 12.17, 0.08, 13.6, 'cm', 'Cersanit', 2500);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P13', 'Listwa łaz. Ozdobna 10cm', 16.2, 0.08, 25.4, 'cm', 'Cersanit', 1300);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P14', 'Taśma malarska 2 cm', 5.6, 0.08, 20, 'metr', 'Maltap', 160);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P15', 'Taśma malarska 6 cm', 8.2, 0.08, 10, 'metr', 'TapMal', 250);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P16', 'Emulsja zew', 16, 0.08, 1, 'litr', 'Malfarb', 190);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P17', 'Emulsja zew typ C', 38, 0.08, 2, 'litr', 'Malfarb', 250);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P18', 'Emalia Lak', 27, 0.23, 1, 'litr', 'Emolak', 30);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P19', 'Lakier bezb', 45, 0.23, 0.75, 'litr', 'LakMal', 60);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P20', 'Lakier do drewna LA', 23, 0.23, 0.5, 'litr', 'LakMal', 90);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P21', 'Lakier do metalu', 28, 0.23, 2, 'litr', 'Emolak', 100);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P22', 'Farba spray typ C', 16.2, 0.23, 0.5, 'litr', 'LakMal', 120);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P23', 'Lakierobejca zew', 21.2, 0.23, 0.75, 'litr', 'HolzLasur', 570);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P24', 'Farba acryl', 89.5, 0.23, 5, 'litr', 'Emolak', 29);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P25', 'Kołek 0,6 cm', 2.3, 0.23, 1, 'szt', 'KolEx', 1300);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P26', 'Kołek 0,8 cm', 2.35, 0.23, 1, 'szt', 'KolEx', 120);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P27', 'Wełna min', 119, 0.23, 5, 'kg', 'Beranek', 50);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P28', 'Wełna dociepleniowa', 125, 0.23, 6, 'kg', 'HotDach', 60);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P29', 'Cekol drobnoziarnisty', 25.3, 0.08, 4.5, 'kg', 'Cersanit', 100);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P30', 'Gładź gipsowa', 42.6, 0.08, 5, 'kg', 'Megaron', 28);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P31', 'Cement biały', 3.5, 0.08, 1.5, 'kg', 'Cersanit', 90);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P32', 'Cement szary', 21.5, 0.08, 6, 'kg', 'Cersanit', 69);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P33', 'Listwa plastikowa 2 cm', 5, 0.23, 3, 'metr', 'Listewnik', 120);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P34', 'Listwa aluminiowa 2.5 cm', 7.2, 0.23, 2.5, 'metr', 'Listal', 100);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P35', 'Kątownik 5 cm', 10, 0.23, 2, 'metr', 'Listal', 100);
INSERT INTO produkty (idproduktu, nazwa, cena, vat, ilosc_w_op, miara, producent, stan) VALUES ('P36', 'Kątownik 4 cm', 8.8, 0.23, 2.5, 'metr', 'Listal', 28);


INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K07', '2021-01-04', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K02', '2021-01-05', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-01-05', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K10', '2021-01-05', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K02', '2021-01-06', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-01-08', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K01', '2021-01-09', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K02', '2021-01-10', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K04', '2021-01-12', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K04', '2021-01-14', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K01', '2021-01-16', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K04', '2021-01-18', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K07', '2021-01-18', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K02', '2021-01-19', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-01-19', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K04', '2021-01-21', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-01-22', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K01', '2021-01-26', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K03', '2021-01-29', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K07', '2021-01-29', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K04', '2021-01-29', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-01-30', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-02-01', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K04', '2021-02-02', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K03', '2021-02-04', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-02-07', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-02-11', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-02-12', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-02-13', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-02-20', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-02-22', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K01', '2021-02-23', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K03', '2021-02-23', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K02', '2021-02-24', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K07', '2021-02-25', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K01', '2021-02-27', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K02', '2021-02-27', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K07', '2021-02-28', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-03-07', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-03-09', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-03-10', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-03-12', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K17', '2021-03-19', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K07', '2021-03-20', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-03-25', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K03', '2021-03-25', 'nie');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K05', '2021-03-25', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K01', '2021-03-27', 'tak');
INSERT INTO nagsprzedaz (idklienta, datasp, zaplacono) VALUES ('K06', '2021-03-29', 'tak');


INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (1, 'P13', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (1, 'P27', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (2, 'P09', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (2, 'P35', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (3, 'P01', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (3, 'P17', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (3, 'P22', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (3, 'P28', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (3, 'P31', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (4, 'P32', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (4, 'P35', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (5, 'P14', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (5, 'P29', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (5, 'P33', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (5, 'P34', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (6, 'P08', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (6, 'P22', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (8, 'P01', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (8, 'P34', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (9, 'P16', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (9, 'P22', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (9, 'P23', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (10, 'P03', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (10, 'P04', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (11, 'P06', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (11, 'P15', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (11, 'P22', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (11, 'P30', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P13', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P16', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P17', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P21', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P22', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P29', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P31', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (12, 'P36', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (13, 'P10', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (13, 'P11', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (13, 'P12', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (14, 'P02', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (15, 'P05', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (16, 'P08', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (16, 'P36', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (16, 'P28', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (16, 'P30', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (17, 'P02', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (17, 'P04', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (17, 'P15', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (17, 'P17', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (17, 'P19', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (18, 'P12', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (18, 'P24', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (18, 'P25', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (19, 'P03', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (19, 'P30', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (19, 'P31', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (19, 'P32', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (20, 'P02', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (20, 'P07', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (20, 'P34', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (20, 'P16', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (20, 'P34', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (21, 'P01', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (21, 'P14', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (21, 'P30', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (22, 'P11', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (23, 'P04', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (24, 'P08', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (24, 'P28', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (24, 'P30', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (25, 'P07', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (25, 'P02', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (25, 'P22', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (25, 'P30', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P14', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P01', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (26, 'P19', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (26, 'P20', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (26, 'P22', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (26, 'P24', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (27, 'P28', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (27, 'P24', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (27, 'P31', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (28, 'P23', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (28, 'P26', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (29, 'P31', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (30, 'P34', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (30, 'P35', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (31, 'P12', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (31, 'P27', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (32, 'P15', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (32, 'P24', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (32, 'P34', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (33, 'P26', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (34, 'P24', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (35, 'P11', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (35, 'P22', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (35, 'P24', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (35, 'P29', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (36, 'P13', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (36, 'P03', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (36, 'P19', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (36, 'P35', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (37, 'P13', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (37, 'P24', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (38, 'P06', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (38, 'P24', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (38, 'P36', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (40, 'P24', 1);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (40, 'P25', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (41, 'P04', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (41, 'P05', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (41, 'P07', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (41, 'P11', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (42, 'P04', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (42, 'P07', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (42, 'P17', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P08', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P09', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P10', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P12', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P13', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P32', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (43, 'P36', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (44, 'P04', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (45, 'P01', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (45, 'P04', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (45, 'P15', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (45, 'P24', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (45, 'P36', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P14', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P15', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P17', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P22', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (46, 'P31', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (47, 'P27', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (48, 'P11', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (48, 'P15', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (48, 'P23', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (48, 'P32', 6);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (48, 'P35', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (49, 'P03', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (49, 'P24', 4);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (49, 'P04', 3);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (49, 'P06', 2);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (49, 'P15', 5);
INSERT INTO pozsprzedaz (nrfaktury, idproduktu, ilosc) VALUES (49, 'P26', 3);
