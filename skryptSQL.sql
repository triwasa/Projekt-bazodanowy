

--Czyszczenie bazy --
DROP TABLE IF EXISTS Sprzeda¿;
DROP TABLE IF EXISTS Handluje_modelami;
DROP TABLE IF EXISTS Zamontowany_w_modelu;
DROP TABLE IF EXISTS Zamontowane_wyposa¿enie;
DROP TABLE IF EXISTS Oferta;
DROP TABLE IF EXISTS Samochód;
DROP TABLE IF EXISTS Osobowy;
DROP TABLE IF EXISTS Ciê¿arowy;
DROP TABLE IF EXISTS Model;
DROP TABLE IF EXISTS Dealer;
DROP TABLE IF EXISTS Wyposa¿enie_samochodu;
DROP TABLE IF EXISTS Klient;
DROP TABLE IF EXISTS Marka;
DROP TABLE IF EXISTS Typ_silnika;
DROP PROCEDURE IF EXISTS Raport;
DROP PROCEDURE IF EXISTS Sprzedaj_Samochod;
DROP TRIGGER IF EXISTS Integralnosc;

GO

--Tworzenie bazy --
CREATE TABLE Ciê¿arowy 
    (
     ³adownoœæ NUMERIC (28) , 
     model_identyfikator INTEGER NOT NULL 
    )
GO

ALTER TABLE Ciê¿arowy ADD CONSTRAINT Ciê¿arowy_PK PRIMARY KEY CLUSTERED (model_identyfikator)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Dealer 
    (
     dealer_nazwa VARCHAR (80) NOT NULL , 
     adres TEXT 
     
    )
GO

ALTER TABLE Dealer ADD CONSTRAINT Dealer_PK PRIMARY KEY CLUSTERED (dealer_nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Handluje_modelami 
    (
     Dealer_nazwa VARCHAR (80) NOT NULL , 
     model_identyfikator INTEGER NOT NULL 
    )
GO

ALTER TABLE Handluje_modelami ADD CONSTRAINT Handluje_modelami_PK PRIMARY KEY CLUSTERED (Dealer_nazwa, model_identyfikator)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Klient 
    (
     identyfikator INTEGER NOT NULL , 
     nazwisko VARCHAR(80) , 
     imie VARCHAR (80) , 
     telefon INTEGER 
    )
GO

ALTER TABLE Klient ADD CONSTRAINT Klient_PK PRIMARY KEY CLUSTERED (identyfikator)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Marka 
    (
     nazwa VARCHAR (50) NOT NULL , 
     rok_za³o¿enia DATE 
    )
GO

ALTER TABLE Marka ADD CONSTRAINT Marka_PK PRIMARY KEY CLUSTERED (nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Model 
    (
     model_identyfikator INTEGER NOT NULL , 
     nazwa VARCHAR (50) NOT NULL , 
     model_nazwa varchar(80),
     poprzednia_generacja INTEGER 
    )
GO

ALTER TABLE Model ADD CONSTRAINT Model_PK PRIMARY KEY CLUSTERED (model_identyfikator)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Oferta 
    (
     dealer_nazwa VARCHAR (80) NOT NULL , 
     vin_samochodu VARCHAR (17) NOT NULL 
    )
GO

ALTER TABLE Oferta ADD CONSTRAINT Oferta_PK PRIMARY KEY CLUSTERED (vin_samochodu)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Osobowy 
    (
     Liczba_pas¿erów INTEGER , 
     Pojemnoœæ_baga¿nika NUMERIC (28) , 
     model_identyfikator INTEGER NOT NULL,
     CONSTRAINT osliczbapasazerow CHECK (Liczba_pas¿erów >= 1)
     
    )
GO

ALTER TABLE Osobowy ADD CONSTRAINT Osobowy_PK PRIMARY KEY CLUSTERED (model_identyfikator)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Samochód 
    (
     VIN VARCHAR (17) NOT NULL , 
     "kraj pochodzenia" VARCHAR (80) , 
     "skrzynia biegów" VARCHAR (80) , 
     "rok produkcji" DATE , 
     przebieg NUMERIC (28) , 
     model_identyfikator INTEGER NOT NULL , 
     Typ_silnika_identyfikator INTEGER NOT NULL,
     CONSTRAINT przebieg CHECK(przebieg>=0)
    )
GO

ALTER TABLE Samochód ADD CONSTRAINT Samochód_PK PRIMARY KEY CLUSTERED (VIN)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Sprzeda¿ 
    (
     Cena NUMERIC (28) , 
     Data DATE NOT NULL , 
     Dealer_nazwa VARCHAR (80) NOT NULL , 
     Klient_identyfikator INTEGER NOT NULL , 
     vin_samochod VARCHAR (17) NOT NULL,
     CONSTRAINT cena CHECK(Cena>0)
    )
GO

ALTER TABLE Sprzeda¿ ADD CONSTRAINT Sprzeda¿_PK PRIMARY KEY CLUSTERED (Data)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Typ_silnika 
    (
     identyfikator INTEGER NOT NULL , 
     "opis parametrów" TEXT , 
     "rodzaj paliwa" VARCHAR (80) 
    )
GO

ALTER TABLE Typ_silnika ADD CONSTRAINT "Typ silnika_PK" PRIMARY KEY CLUSTERED (identyfikator)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Wyposa¿enie_samochodu 
    (
     nazwa VARCHAR (80) NOT NULL 
    )
GO

ALTER TABLE Wyposa¿enie_samochodu ADD CONSTRAINT Wyposa¿enie_samochodu_PK PRIMARY KEY CLUSTERED (nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Zamontowane_wyposa¿enie 
    (
     vin_samochodu VARCHAR (17) NOT NULL , 
     nazwa VARCHAR (80) NOT NULL 
    )
GO

ALTER TABLE Zamontowane_wyposa¿enie ADD CONSTRAINT Zamontowane_wyposa¿enie_PK PRIMARY KEY CLUSTERED (vin_samochodu, nazwa)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Zamontowany_w_modelu 
    (
     silnik_identyfikator INTEGER NOT NULL , 
     model_identyfikator INTEGER NOT NULL 
    )
GO

ALTER TABLE Ciê¿arowy 
    ADD CONSTRAINT Ciê¿arowy_Model_FK FOREIGN KEY 
    ( 
     model_identyfikator
    ) 
    REFERENCES Model 
    ( 
     model_identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Handluje_modelami 
    ADD CONSTRAINT Handluje_modelami_Dealer_FK FOREIGN KEY 
    ( 
     Dealer_nazwa
    ) 
    REFERENCES Dealer 
    ( 
     dealer_nazwa 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Handluje_modelami 
    ADD CONSTRAINT Handluje_modelami_Model_FK FOREIGN KEY 
    ( 
     model_identyfikator
    ) 
    REFERENCES Model 
    ( 
     model_identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Model 
    ADD CONSTRAINT Model_Marka_FK FOREIGN KEY 
    ( 
     nazwa
    ) 
    REFERENCES Marka 
    ( 
     nazwa 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Model 
    ADD CONSTRAINT Model_Model_FK FOREIGN KEY 
    ( 
     poprzednia_generacja
    ) 
    REFERENCES Model 
    ( 
     model_identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Oferta 
    ADD CONSTRAINT Oferta_Dealer_FK FOREIGN KEY 
    ( 
     dealer_nazwa
    ) 
    REFERENCES Dealer 
    ( 
     dealer_nazwa 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Oferta 
    ADD CONSTRAINT Oferta_Samochód_FK FOREIGN KEY 
    ( 
     vin_samochodu
    ) 
    REFERENCES Samochód 
    ( 
     VIN 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Osobowy 
    ADD CONSTRAINT Osobowy_Model_FK FOREIGN KEY 
    ( 
     model_identyfikator
    ) 
    REFERENCES Model 
    ( 
     model_identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Samochód 
    ADD CONSTRAINT Samochód_Model_FK FOREIGN KEY 
    ( 
     model_identyfikator
    ) 
    REFERENCES Model 
    ( 
     model_identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Samochód 
    ADD CONSTRAINT "Samochód_Typ silnika_FK" FOREIGN KEY 
    ( 
     Typ_silnika_identyfikator
    ) 
    REFERENCES Typ_silnika 
    ( 
     identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Sprzeda¿ 
    ADD CONSTRAINT Sprzeda¿_Dealer_FK FOREIGN KEY 
    ( 
     Dealer_nazwa
    ) 
    REFERENCES Dealer 
    ( 
     dealer_nazwa 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Sprzeda¿ 
    ADD CONSTRAINT Sprzeda¿_Klient_FK FOREIGN KEY 
    ( 
     Klient_identyfikator
    ) 
    REFERENCES Klient 
    ( 
     identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Sprzeda¿ 
    ADD CONSTRAINT Sprzeda¿_Samochód_FK FOREIGN KEY 
    ( 
     vin_samochod
    ) 
    REFERENCES Samochód 
    ( 
     VIN 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zamontowane_wyposa¿enie 
    ADD CONSTRAINT Zamontowane_wyposa¿enie_Samochód_FK FOREIGN KEY 
    ( 
     vin_samochodu
    ) 
    REFERENCES Samochód 
    ( 
     VIN 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zamontowane_wyposa¿enie 
    ADD CONSTRAINT Zamontowane_wyposa¿enie_Wyposa¿enie_samochodu_FK FOREIGN KEY 
    ( 
     nazwa
    ) 
    REFERENCES Wyposa¿enie_samochodu 
    ( 
     nazwa 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zamontowany_w_modelu 
    ADD CONSTRAINT Zamontowany_w_modelu_Model_FK FOREIGN KEY 
    ( 
     model_identyfikator
    ) 
    REFERENCES Model 
    ( 
     model_identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Zamontowany_w_modelu 
    ADD CONSTRAINT "Zamontowany_w_modelu_Typ silnika_FK" FOREIGN KEY 
    ( 
     silnik_identyfikator
    ) 
    REFERENCES Typ_silnika 
    ( 
     identyfikator 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO


--INSERTY--
INSERT INTO Dealer VALUES('Danielczyk BMW','Lublin');
INSERT INTO Dealer VALUES('fORD RADOM','Radom');
INSERT INTO Dealer VALUES('KIA Salon','Poznañ');
INSERT INTO Dealer VALUES('Honda','Gdañsk');
INSERT INTO Dealer VALUES('Opel Sopot','Sopot');
INSERT INTO Dealer VALUES('Poznana Alfa','Poznana');
INSERT INTO Dealer VALUES('Fiat Rzeszów','Rzeszów');
INSERT INTO Dealer VALUES('Szybkie BMW' , 'Stara Wieœ');
INSERT INTO Dealer VALUES('Zakopane Fiat','Zakopane');
INSERT INTO Dealer VALUES('Mercedes','Lublin');

INSERT INTO Wyposa¿enie_samochodu VALUES('Radio');
INSERT INTO Wyposa¿enie_samochodu VALUES('TV');
INSERT INTO Wyposa¿enie_samochodu VALUES('Basen');
INSERT INTO Wyposa¿enie_samochodu VALUES('Przyciemniane szyby');
INSERT INTO Wyposa¿enie_samochodu VALUES('Zegar');
INSERT INTO Wyposa¿enie_samochodu VALUES('Zestaw Audio');
INSERT INTO Wyposa¿enie_samochodu VALUES('Zestaw Naprawczy');
INSERT INTO Wyposa¿enie_samochodu VALUES('Nawigacja');
INSERT INTO Wyposa¿enie_samochodu VALUES('Szyberdach');
INSERT INTO Wyposa¿enie_samochodu VALUES('Basy');
INSERT INTO Wyposa¿enie_samochodu VALUES('Czujnik parkowania');


INSERT INTO Klient VALUES(1,'Len','Jan',111222333);
INSERT INTO Klient VALUES(2,'Musk','Elon',222333444);
INSERT INTO Klient VALUES(3,'Marek','Jan',000555888);
INSERT INTO Klient VALUES(4,'Ryk','Eryk',780780780);
INSERT INTO Klient VALUES(5,'Meryn','Ola',444555888);
INSERT INTO Klient VALUES(6,'Dron','Ali',NULL);
INSERT INTO Klient VALUES(7,'Ma³ysz','Jurek',0550555055);
INSERT INTO Klient VALUES(8,'Owsiak','Adam',454598764);
INSERT INTO Klient VALUES(9,'Tracz','Janusz',45490909);
INSERT INTO Klient VALUES(10,'Reg','Jan',NULL);

INSERT INTO Marka VALUES('Opel','1895');
INSERT INTO Marka VALUES('Honda','1900');
INSERT INTO Marka VALUES('BMW','1500');
INSERT INTO Marka VALUES('Fiat','1740');
INSERT INTO Marka VALUES('Mercedes','1847');
INSERT INTO Marka VALUES('KIA','1866');
INSERT INTO Marka VALUES('Mazda','1900');
INSERT INTO Marka VALUES('Tesla','2001');
INSERT INTO Marka VALUES('Audi','1877');
INSERT INTO Marka VALUES('Lexus','1870');

INSERT INTO Model VALUES(1,'Opel','Ceed II',NULL);
INSERT INTO Model VALUES(2,'Honda','407',1);
INSERT INTO Model VALUES(3,'BMW','Stinger',2);
INSERT INTO Model VALUES(4,'Fiat','307',3);
INSERT INTO Model VALUES(5,'Mercedes','Optima',4);
INSERT INTO Model VALUES(6,'KIA','500',NULL);
INSERT INTO Model VALUES(7,'Mazda','600',6);
INSERT INTO Model VALUES(8,'Tesla','800',6);
INSERT INTO Model VALUES(9,'Audi','900',7);
INSERT INTO Model VALUES(10,'Lexus','Super',8);

INSERT INTO Handluje_modelami VALUES('Opel Sopot',1);
INSERT INTO Handluje_modelami VALUES('Poznana Alfa',2);
INSERT INTO Handluje_modelami VALUES('Danielczyk BMW',3);
INSERT INTO Handluje_modelami VALUES('fORD RADOM',4);
INSERT INTO Handluje_modelami VALUES('Mercedes',5);
INSERT INTO Handluje_modelami VALUES('Fiat Rzeszów',6);
INSERT INTO Handluje_modelami VALUES('Zakopane Fiat',7);
INSERT INTO Handluje_modelami VALUES('Honda',8);
INSERT INTO Handluje_modelami VALUES('Poznana Alfa',9);
INSERT INTO Handluje_modelami VALUES('Fiat Rzeszów',10);


INSERT INTO Typ_silnika VALUES(1,'150','LPG');
INSERT INTO Typ_silnika VALUES(2,'180','PB');
INSERT INTO Typ_silnika VALUES(3,'80','LPG');
INSERT INTO Typ_silnika VALUES(4,'140','LPG');
INSERT INTO Typ_silnika VALUES(5,'50','PB');
INSERT INTO Typ_silnika VALUES(6,'850','LPG');
INSERT INTO Typ_silnika VALUES(7,'450','LPG');
INSERT INTO Typ_silnika VALUES(8,'220','PB');
INSERT INTO Typ_silnika VALUES(9,'100','PB');
INSERT INTO Typ_silnika VALUES(10,'480','LPG');
INSERT INTO Typ_silnika VALUES(11,'15','PB');



INSERT INTO Samochód VALUES('S5G8F47R9V554784V','Polska','Manualna','2007',200000,1,10);
INSERT INTO Samochód VALUES('A0S50D8A4F0A6A0D5','Anglia','Manualna','2019',250000,2,9);
INSERT INTO Samochód VALUES('A5D0E8D4E5D6D2D0D','USA','Automat','2002',300000,3,8);
INSERT INTO Samochód VALUES('A4S5S8S4S2S0S7S8S','Polska','Maual','2012',450000,4,7);
INSERT INTO Samochód VALUES('AKDOGMWOEJ802JFIE','Niemcy','Automat','2014',65000,5,6);
INSERT INTO Samochód VALUES('S4D0E8F5S40E8W4D0','Polska','Manual','2001',85000,6,5);
INSERT INTO Samochód VALUES('D5A1S0A8D0A3A0D8S','Hiszpania','Manaul','2012',15000,7,4);
INSERT INTO Samochód VALUES('A0S8S0S5S0D0D0D0D','Polska','Maual','1999',46000,8,3);
INSERT INTO Samochód VALUES('S52S4F8E5E1E2E4D7','Niemcy','Manaul','2001',48000,9,2);
INSERT INTO Samochód VALUES('S5S0A5A4A9D0D8A5S','Polska','Automat','2000',200000,10,1);

INSERT INTO Zamontowane_wyposa¿enie VALUES('S5S0A5A4A9D0D8A5S','Radio');
INSERT INTO Zamontowane_wyposa¿enie VALUES('S52S4F8E5E1E2E4D7','TV');
INSERT INTO Zamontowane_wyposa¿enie VALUES('A5D0E8D4E5D6D2D0D','Nawigacja');
INSERT INTO Zamontowane_wyposa¿enie VALUES('D5A1S0A8D0A3A0D8S','Basen');
INSERT INTO Zamontowane_wyposa¿enie VALUES('S4D0E8F5S40E8W4D0','Przyciemniane szyby');
INSERT INTO Zamontowane_wyposa¿enie VALUES('AKDOGMWOEJ802JFIE','Zegar');
INSERT INTO Zamontowane_wyposa¿enie VALUES('A4S5S8S4S2S0S7S8S','Zestaw Audio');
INSERT INTO Zamontowane_wyposa¿enie VALUES('A0S8S0S5S0D0D0D0D','Zestaw Naprawczy');
INSERT INTO Zamontowane_wyposa¿enie VALUES('A0S50D8A4F0A6A0D5','Nawigacja');
INSERT INTO Zamontowane_wyposa¿enie VALUES('S5G8F47R9V554784V','Szyberdach');
INSERT INTO Zamontowane_wyposa¿enie VALUES('A0S8S0S5S0D0D0D0D','TV');

INSERT INTO Oferta VALUES('Danielczyk BMW','S5G8F47R9V554784V');
INSERT INTO Oferta VALUES('fORD RADOM','A0S50D8A4F0A6A0D5');
INSERT INTO Oferta VALUES('KIA Salon','A0S8S0S5S0D0D0D0D');
INSERT INTO Oferta VALUES('Honda','A4S5S8S4S2S0S7S8S');
INSERT INTO Oferta VALUES('Opel Sopot','AKDOGMWOEJ802JFIE');
INSERT INTO Oferta VALUES('Poznana Alfa','S4D0E8F5S40E8W4D0');
INSERT INTO Oferta VALUES('Fiat Rzeszów','D5A1S0A8D0A3A0D8S');
INSERT INTO Oferta VALUES('Szybkie BMw','A5D0E8D4E5D6D2D0D');
INSERT INTO Oferta VALUES('Zakopane Fiat','S52S4F8E5E1E2E4D7');
INSERT INTO Oferta VALUES('Mercedes','S5S0A5A4A9D0D8A5S');

INSERT INTO Osobowy VALUES(5,250,1);
INSERT INTO Osobowy VALUES(5,380,2);
INSERT INTO Osobowy VALUES(2,175,3);
INSERT INTO Osobowy VALUES(8,410,4);
INSERT INTO Osobowy VALUES(2,250,5);

INSERT INTO Ciê¿arowy VALUES(5000,6);
INSERT INTO Ciê¿arowy VALUES(6500,7);
INSERT INTO Ciê¿arowy VALUES(3200,8);
INSERT INTO Ciê¿arowy VALUES(6500,9);
INSERT INTO Ciê¿arowy VALUES(1500,10);

INSERT INTO Sprzeda¿ VALUES(50000,'2007-02-05','Danielczyk BMW',1,'S5G8F47R9V554784V');
INSERT INTO Sprzeda¿ VALUES(321500,'2019-05-07','fORD RADOM',2, 'A0S50D8A4F0A6A0D5');
INSERT INTO Sprzeda¿ VALUES(15000,'2002-03-05','KIA Salon',3, 'A0S8S0S5S0D0D0D0D');
INSERT INTO Sprzeda¿ VALUES(36000,'2012-12-12','Honda',4,'A4S5S8S4S2S0S7S8S');
INSERT INTO Sprzeda¿ VALUES(45000,'2014-11-05','Opel Sopot',5,'AKDOGMWOEJ802JFIE');
INSERT INTO Sprzeda¿ VALUES(14000,'2001-10-02','Poznana Alfa',6,'S4D0E8F5S40E8W4D0');
INSERT INTO Sprzeda¿ VALUES(18000,'2012-12-11','Fiat Rzeszów',7,'D5A1S0A8D0A3A0D8S');
INSERT INTO Sprzeda¿ VALUES(2800,'1999-9-11','Szybkie BMw',8,'A5D0E8D4E5D6D2D0D');
INSERT INTO Sprzeda¿ VALUES(3200,'2002-03-04','Zakopane Fiat',9,'S52S4F8E5E1E2E4D7');
INSERT INTO Sprzeda¿ VALUES(7800,'2000-02-04','Mercedes',10,'S5S0A5A4A9D0D8A5S');


GO

--zwraca samochody z obecnej oferty dealera
CREATE PROCEDURE Raport
	@nazwa VARCHAR(80)
AS BEGIN
SELECT Samochód.* FROM Samochód 
JOIN Oferta ON Samochód.VIN = Oferta.vin_samochodu
WHERE Oferta.dealer_nazwa = @nazwa;
END
GO

EXEC Raport
    @nazwa = 'Fiat Rzeszów';
GO

--Usuwa sprzedany samochód z oferty dealera
CREATE PROCEDURE Sprzedaj_Samochod
	@vin VARCHAR(80)
AS 
BEGIN
DELETE FROM Oferta WHERE vin_samochodu = @vin
END
GO

EXEC Sprzedaj_Samochod
    @vin = 'S5G8F47R9V554784V';
GO

--Sprawdza czy dealer handluje modelami sprzedanego przez w³aœnie samochodu
CREATE TRIGGER Integralnosc
ON Sprzeda¿
AFTER INSERT
AS
IF((SELECT Samochód.model_identyfikator FROM Samochód JOIN inserted ON inserted.vin_samochod = Samochód.vin) NOT IN (SELECT Handluje_modelami.model_identyfikator FROM Handluje_modelami JOIN inserted ON inserted.dealer_nazwa = Handluje_modelami.dealer_nazwa))
ROLLBACK TRANSACTION

--INSERT INTO Samochód VALUES('S5S0A5A4A9D0ASDFM','Polska','Automat','2000',200000,10,1);
--INSERT INTO Sprzeda¿ VALUES(36000,'2012-09-12','Poznana Alfa',6,'S5S0A5A4A9D0ASDFM');