SELECT t.Titel,t.ErstDatum FROM
(SELECT Artikel.Id,Artikel.Titel,Artikel.ErstDatum FROM Artikel
GROUP BY Artikel.Id,Artikel.Titel,Artikel.ErstDatum) t
INNER JOIN geschrieben_von ON t.Id = geschrieben_von.IdArtikel
INNER JOIN Wissenschaftler ON geschrieben_von.IdWissenschaftler = Wissenschaftler.Id
WHERE Wissenschaftler.Forschungsgebiet='AI'
EXCEPT
SELECT t.Titel,t.ErstDatum FROM
(SELECT Artikel.Id,Artikel.Titel,Artikel.ErstDatum FROM Artikel
GROUP BY Artikel.Id,Artikel.Titel,Artikel.ErstDatum) t
INNER JOIN geschrieben_von ON t.Id = geschrieben_von.IdArtikel
INNER JOIN Wissenschaftler ON geschrieben_von.IdWissenschaftler = Wissenschaftler.Id
WHERE Wissenschaftler.Forschungsgebiet='FCA'


