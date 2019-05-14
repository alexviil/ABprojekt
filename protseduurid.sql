-- Kõigi arvustuste keskmine arv inimeste kohta, koguarv ja keskmine hinnang,
-- admin kasutajat ja arvustusteta kontosid ei vaadata.
CREATE PROCEDURE sp_keskmine_arvustuste_arv()
BEGIN
    SELECT AVG(Kontod.Arvustusi) as 'Keskmine arvustuste arv',
           AVG(Kontod.Keskmine_antud_hinnang) as 'Arvustuste keskmine hinnang',
           SUM(Kontod.Arvustusi) as 'Arvustuste koguarv'
    FROM Kontod
    WHERE Kontod.Konto_nimi!='admin' AND Kontod.Arvustusi>=1
END;

CALL sp_keskmine_arvustuste_arv();

-- Näitleja filmide keskmine hinnang, selle alusel mis tema kõigi filmide keskmine hinnang on
CREATE PROCEDURE sp_näitleja_hinnang(IN a_naitleja_id INTEGER)
BEGIN
    SELECT AVG(Filmid.Keskmine_antud_hinnang) as 'Näitleja keskmine hinnang'
    FROM Naitlejad KEY JOIN Mangimised KEY JOIN Rollid KEY JOIN Osalemised KEY JOIN Filmid
    WHERE Naitlejad.ID = a_naitleja_id
END;

CALL sp_näitleja_hinnang(3)

-- Näitleja kõik filmid etteantud ajavahemikul
CREATE PROCEDURE sp_näitleja_filmid(IN a_naitleja_id INTEGER,
IN a_algaeg DATE, IN a_loppaeg DATE)
BEGIN 
    SELECT Filmid.Nimi as 'Näitleja filmi nimi'
    FROM Naitlejad KEY JOIN Mangimised KEY JOIN Rollid KEY JOIN Osalemised KEY JOIN Filmid
    WHERE Naitlejad.ID = a_naitleja_id AND Esilinastus>=a_algaeg AND Esilinastus<=a_loppaeg
END;

CALL sp_näitleja_filmid(1, '2007-11-11', '2009-11-11')

-- Leiab kui paljudel kasutajatel on etteantud sõna kasutajanimes
CREATE PROCEDURE sp_kasutajade_sõna_luger(IN a_sona VARCHAR(32))
BEGIN 
    SELECT COUNT(*) as 'Sõnaga kasutajate arv'
    FROM Kontod
    WHERE CHARINDEX(a_sona,Kontod.Konto_nimi) > 0 
END;

CALL sp_kasutajade_sõna_luger('8')

-- Mis näitlejatega on rezissoor tootanud
CREATE PROCEDURE sp_rezissoori_naitlejad(IN a_rezissoor_id INTEGER)
BEGIN
    SELECT DISTINCT Naitlejad.nimi as 'Naitleja nimi'
    FROM Naitlejad KEY JOIN Mangimised KEY JOIN Rollid KEY JOIN Osalemised KEY JOIN Filmid KEY JOIN Lavastused KEY JOIN Rezissoorid
    WHERE Rezissoorid.ID = a_rezissoor_id
END;

CALL sp_rezissoori_naitlejad(11)




