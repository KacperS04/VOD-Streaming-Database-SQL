-- =========================================
-- PROJEKT: BAZA DANYCH PLATFORMY STREAMINGOWEJ
-- =========================================


CREATE TABLE Jakosc (
    IDJakosci INT PRIMARY KEY,
    jakosc_filmu VARCHAR(10)
);

CREATE TABLE Jezyk (
    IDJezyka INT PRIMARY KEY,
    domyslny_jezyk VARCHAR(25)
);

CREATE TABLE Jezyk_napisow (
    IDJezyka_napisow INT PRIMARY KEY,
    jezyk_napisow VARCHAR(25)
);

CREATE TABLE Dodatkowe_ustawienia (
    IDDodatkowych_ustawien INT PRIMARY KEY,
    autoodtwarzanie BIT,
    ciemny_motyw BIT
);

CREATE TABLE Powiadomienia (
    IDPowiadomienia INT PRIMARY KEY,
    tytul_powiadomienia VARCHAR(25),
    wiadomosc VARCHAR(100),
    typ_powiadomienia VARCHAR(25)
);

CREATE TABLE Platnosci (
    IDPlatnosci INT PRIMARY KEY,
    metoda_platnosci VARCHAR(25),
    data_platnosci DATE
);

CREATE TABLE Typ_subskrybcji (
    IDTypu_subskrybcji INT PRIMARY KEY,
    typ_subskrybcji VARCHAR(30),
    czas_trwania VARCHAR(25),
    cena_subskrybcji MONEY
);

CREATE TABLE Uzytkownicy (
    IDUzytkownika INT PRIMARY KEY,
    Imie VARCHAR(25),
    Nazwisko VARCHAR(50),
    email VARCHAR(50),
    haslo VARCHAR(50)
);

CREATE TABLE Aktorzy (
    IDAktora INT PRIMARY KEY,
    imie_aktora VARCHAR(25),
    nazwisko_aktora VARCHAR(50),
    ocena_aktora DECIMAL(2,1),
    fotografia IMAGE,
    wygral_oskara BIT
);

CREATE TABLE Rezyserzy (
    IDRezysera INT PRIMARY KEY,
    imie_rezysera VARCHAR(25),
    nazwisko_rezysera VARCHAR(50),
    wiek TINYINT,
    ocena DECIMAL(2,1),
    fotografia IMAGE
);

CREATE TABLE Gatunek (
    IDGatunku INT PRIMARY KEY,
    gatunek VARCHAR(25),
    typ VARCHAR(25)
);


CREATE TABLE Filmy (
    IDFilmu INT PRIMARY KEY,
    IDGatunku INT FOREIGN KEY REFERENCES Gatunek(IDGatunku),
    IDAktora INT FOREIGN KEY REFERENCES Aktorzy(IDAktora),
    IDRezysera INT FOREIGN KEY REFERENCES Rezyserzy(IDRezysera),
    tytul VARCHAR(25),
    ocena DECIMAL(2,1),
    data_premiery DATE,
    czas_trwania SMALLINT
);

CREATE TABLE Ustawienia (
    IDUstawien INT PRIMARY KEY,
    IDUzytkownika INT FOREIGN KEY REFERENCES Uzytkownicy(IDUzytkownika),
    IDJakosci INT FOREIGN KEY REFERENCES Jakosc(IDJakosci),
    IDJezyka INT FOREIGN KEY REFERENCES Jezyk(IDJezyka),
    IDJezyka_napisow INT FOREIGN KEY REFERENCES Jezyk_napisow(IDJezyka_napisow),
    IDDodatkowych_ustawien INT FOREIGN KEY REFERENCES Dodatkowe_ustawienia(IDDodatkowych_ustawien),
    data_zapisania_ustawien DATE
);

CREATE TABLE Powiadomienia_uzytkownika (
    IDPowiadomienia_uzytkownika INT PRIMARY KEY,
    IDPowiadomienia INT FOREIGN KEY REFERENCES Powiadomienia(IDPowiadomienia),
    IDUzytkownika INT FOREIGN KEY REFERENCES Uzytkownicy(IDUzytkownika),
    data_wyslania DATE,
    czy_odczytane BIT
);

CREATE TABLE Subskrybcje (
    IDSubskrybcji INT PRIMARY KEY,
    IDTypu_subskrybcji INT FOREIGN KEY REFERENCES Typ_subskrybcji(IDTypu_subskrybcji),
    IDUzytkownika INT FOREIGN KEY REFERENCES Uzytkownicy(IDUzytkownika),
    IDPlatnosci INT FOREIGN KEY REFERENCES Platnosci(IDPlatnosci),
    data_zakupu_subskrybcji DATE
);

CREATE TABLE Faktury (
    IDFaktury INT PRIMARY KEY,
    IDSubskrybcji INT FOREIGN KEY REFERENCES Subskrybcje(IDSubskrybcji),
    data_wystawienia_faktury DATE
);

CREATE TABLE Rekomendacje (
    IDRekomendacji INT PRIMARY KEY,
    IDUzytkownika INT FOREIGN KEY REFERENCES Uzytkownicy(IDUzytkownika),
    IDFilmu INT FOREIGN KEY REFERENCES Filmy(IDFilmu),
    powod_rekomendacji VARCHAR(50)
);

CREATE TABLE Lista_ulubionych (
    IDListy INT PRIMARY KEY,
    IDUzytkownika INT FOREIGN KEY REFERENCES Uzytkownicy(IDUzytkownika),
    IDFilmu INT FOREIGN KEY REFERENCES Filmy(IDFilmu),
    data_dodania DATE
);

CREATE TABLE Historia_ogladania (
    IDHistorii INT PRIMARY KEY,
    IDUzytkownika INT FOREIGN KEY REFERENCES Uzytkownicy(IDUzytkownika),
    IDFilmu INT FOREIGN KEY REFERENCES Filmy(IDFilmu),
    data_obejrzenia DATE,
    obejrzanych_minut SMALLINT
);