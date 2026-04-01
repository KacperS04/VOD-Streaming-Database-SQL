-- =========================================
-- PROJEKT: BAZA DANYCH PLATFORMY STREAMINGOWEJ
-- Zestaw przykładowych zapytań 
-- =========================================

-- 1. Zestawienie top 5 najlepiej ocenianych filmów wraz z reżyserem i gatunkiem
SELECT TOP 5
    f.tytul AS Tytul_Filmu,
    f.ocena AS Ocena_Filmu,
    g.gatunek AS Gatunek,
    r.imie_rezysera + ' ' + r.nazwisko_rezysera AS Rezyser,
    f.czas_trwania AS Czas_Trwania_Min
FROM Filmy f
JOIN Gatunek g ON f.IDGatunku = g.IDGatunku
JOIN Rezyserzy r ON f.IDRezysera = r.IDRezysera
ORDER BY f.ocena DESC;

-- 2. Raport subskrypcji: Liczba użytkowników przypisanych do poszczególnych typów subskrypcji
SELECT 
    t.typ_subskrybcji AS Typ_Planu,
    t.cena_subskrybcji AS Cena,
    COUNT(s.IDSubskrybcji) AS Liczba_Aktywnych_Subskrypcji
FROM Typ_subskrybcji t
LEFT JOIN Subskrybcje s ON t.IDTypu_subskrybcji = s.IDTypu_subskrybcji
GROUP BY t.typ_subskrybcji, t.cena_subskrybcji
ORDER BY Liczba_Aktywnych_Subskrypcji DESC;

-- 3. Historia oglądania konkretnego użytkownika wraz z całkowitym czasem spędzonym w serwisie (Wyszukujemy dla użytkownika o ID = 1)
SELECT 
    u.Imie,
    u.Nazwisko,
    f.tytul AS Obejrzany_Film,
    h.data_obejrzenia,
    h.obejrzanych_minut
FROM Historia_ogladania h
JOIN Uzytkownicy u ON h.IDUzytkownika = u.IDUzytkownika
JOIN Filmy f ON h.IDFilmu = f.IDFilmu
WHERE u.IDUzytkownika = 1
ORDER BY h.data_obejrzenia DESC;

-- 4. Finanse: Przychody z płatności wygenerowane w poszczególnych miesiącach
SELECT 
    YEAR(p.data_platnosci) AS Rok,
    MONTH(p.data_platnosci) AS Miesiac,
    COUNT(p.IDPlatnosci) AS Liczba_Transakcji,
    SUM(t.cena_subskrybcji) AS Suma_Przychodow
FROM Platnosci p
JOIN Subskrybcje s ON p.IDPlatnosci = s.IDPlatnosci
JOIN Typ_subskrybcji t ON s.IDTypu_subskrybcji = t.IDTypu_subskrybcji
GROUP BY YEAR(p.data_platnosci), MONTH(p.data_platnosci)
ORDER BY Rok DESC, Miesiac DESC;

-- 5. Rekomendacje: Filmy polecane użytkownikom wraz z powodem rekomendacji
SELECT 
    u.email AS Email_Uzytkownika,
    f.tytul AS Polecany_Film,
    rek.powod_rekomendacji AS Powod
FROM Rekomendacje rek
JOIN Uzytkownicy u ON rek.IDUzytkownika = u.IDUzytkownika
JOIN Filmy f ON rek.IDFilmu = f.IDFilmu;