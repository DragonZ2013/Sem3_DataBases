SELECT  Wissenschaftler.Name,Wissenschaftler.Vorname FROM EditorialBoard
INNER JOIN Wissenschaftler ON EditorialBoard.IdWissenschaftler=Wissenschaftler.Id
GROUP BY Wissenschaftler.Id,Wissenschaftler.Forschungsgebiet,Wissenschaftler.Name,Wissenschaftler.Vorname
HAVING Count(*) > (
SELECT MIN(CountAI) FROM(
SELECT Count(*) AS CountAI FROM EditorialBoard
INNER JOIN Wissenschaftler ON EditorialBoard.IdWissenschaftler=Wissenschaftler.Id
GROUP BY Wissenschaftler.Id,Wissenschaftler.Forschungsgebiet HAVING Wissenschaftler.Forschungsgebiet='AI') t)







SELECT * FROM Wissenschaftler
SELECT * FROM Ausgabe
SELECT * FROM EditorialBoard

INSERT INTO EditorialBoard VALUES (2,3)