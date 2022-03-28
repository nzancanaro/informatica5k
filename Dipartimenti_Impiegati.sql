--
-- Dipartimenti_Impiegati.sql
-- Database: `Dip_Impiegati`
-- prefisso Dip_
--
CREATE TABLE IF NOT EXISTS Dip_Dipartimenti (
  Codice char(5) NOT NULL,
  Descrizione char(20) NOT NULL,
  Sede char(20) DEFAULT NULL,
  Manager smallint DEFAULT NULL,
  PRIMARY KEY (Codice)
);

INSERT INTO Dip_Dipartimenti (Codice, Descrizione, Sede, Manager) VALUES
('Amm', 'Amministrazione', 'Roma', 12),
('Direz', 'Direzione Generale', 'Roma', 13),
('Mag', 'Magazzino', 'Torino', 10),
('Mkt', 'Marketing', 'Milano', 13),
('Prod', 'Produzione', 'Torino', 10),
('R&S', 'Ricerca & Sviluppo', 'Torino', 14),
('Pers', 'Personale', 'Roma', 12);

CREATE TABLE IF NOT EXISTS Dip_Impiegati (
  ID smallint NOT NULL,
  Nome char(20) NOT NULL,
  Cognome char(30) NOT NULL,
  Residenza char(20) DEFAULT '*** Manca Residenza',
  Stipendio decimal(9,2) DEFAULT NULL,
  Dipartimento char(5) DEFAULT NULL,
  foreign key (Dipartimento) references Dip_Dipartimenti(Codice),
  PRIMARY KEY (ID)
);

INSERT INTO Dip_Impiegati (ID, Nome, Cognome, Residenza, Stipendio, Dipartimento) VALUES
(1, 'Mario', 'Rossi', 'Torino', '32000.00', 'Prod'),
(5, 'Marco', 'Viola', 'Palermo', '28300.00', NULL),
(6, 'Enrico', 'Mori', 'Torino', '25000.00', 'Mag'),
(10, 'Margherita', 'Colombi', 'Roma', '65000.00', 'Prod'),
(11, 'Fabrizio', 'Magenta', 'Torino', '41000.00', 'Prod'),
(12, 'Franco', 'Volpi', 'Bari', '61000.00', 'Amm'),
(13, 'Ugo', 'Boss', 'Cagliari', '85000.00', 'Direz'),
(14, 'Mario', 'Gatti', 'Firenze', '57000.00', 'R&S'),
(16, 'Elisabetta', 'Gregis', 'Roma', '29000.00', 'Amm'),
(17, 'Laura', 'Moretti', 'Venezia', '52600.00', 'Mkt'),
(18, 'Enrica', 'Bruni', 'Firenze', '61500.00', 'Mag'),
(19, 'Anita', 'Bianco', 'Perugia', '39000.00', 'Direz');



--slide  SQL un esempio di query la faccio sullle tabelle complete di dati vedi 
-- tabelle con prefisso Dip_
-- file Dipartimenti_Impiegati_by_Gravina.sql

-- Nome, Cognome, Stipendio e sede di lavoro dei dipendenti con retribuzione superiore a 50000 euro
SELECT Nome, Cognome, Stipendio, Sede
	FROM Dip_Impiegati INNER JOIN Dip_Dipartimenti ON
		Dip_Impiegati.Dipartimento = Dip_Dipartimenti.Codice 
	WHERE Stipendio > 50000;
	
	

	

-- Attenzione l'INNER JOIN esegue un equi join
-- quindi una vista che presenta le colonne indicate con select e considerando i record unione delle colonne
-- prese dalle due tabelle Dip_Impiegati, Dip_Dipartimenti dove vale la condizione 
--    Dip_Impiegati.Dipartimento = Dip_Dipartimenti.Codice   

-- in sql  = va  inteso come operatore di confronto

--quindi  la stessa query si puo’ scrivere nel seguente modo:
SELECT Nome, Cognome, Stipendio, Sede
	FROM Dip_Impiegati, Dip_Dipartimenti 
	WHERE Dip_Impiegati.Dipartimento = Dip_Dipartimenti.Codice 
   	and Stipendio > 50000;
-- Attenzione:  unire le condizioni con l’operatore and	 


-- slide Interrogazioni su una sola tabella (1)

-- Algebra relazionale: proiezioni e selezioni
-- ID, Cognome e Nome dei dipendenti torinesi della produzione  

SELECT ID, Cognome, Nome
FROM Dip_Impiegati
WHERE Dipartimento = 'Prod' AND Residenza ='Torino';



-- Tutti i dati dei dipendenti di Roma 
SELECT * 
	FROM Dip_Impiegati
	WHERE Residenza ='Roma';

-- slide Interrogazioni su una sola tabella (2)

-- Forme equivalenti

SELECT Residenza 
	FROM Dip_Impiegati;

SELECT ALL Residenza 
	FROM Dip_Impiegati;

-- DISTINCT per non avere righe duplicate

SELECT DISTINCT Residenza
   FROM Dip_Impiegati;


--slide  Interrogazioni su una sola tabella (3)

-- Ridenominazione dei campi: AS
SELECT ID AS Matricola, Cognome, Nome
	FROM Dip_Impiegati
	WHERE Dipartimento = 'Prod' AND Residenza ='Torino';
	
-- 	Esecuzione di calcoli sui campi 

SELECT Cognome, Nome, Stipendio AS Attuale,
 	    Stipendio*1.05 AS Nuovo
	FROM Dip_Impiegati
	WHERE Dipartimento ='Mag';

--slide  Interrogazioni parametriche
-- Interrogazioni parametriche  (con Access) in PhPMyAdmin con MariaDB non funziona
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >= [Retribuzione minima?];

-- Interrogazioni parametriche  in PhPMyAdmin con MariaDB?
/* // non funziona
PARAMETERS Retribuzione_minima: decimal(9,2) 
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=Retribuzione_minima;
*/

/*--  fonti microsoft non funziona in PhPMyAdmin con MariaDB
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE (Stipendio >=?);

*/
-- imposto un valore minimo come una variabile inizializzata
SET @minimo = 10000;
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=@minimo;

-- imposto un valore minimo come una variabile inizializzata con select 
--e poi aggiustando il valore di riferimento 

SELECT @minimo := MIN(Stipendio)
  FROM Dip_Impiegati;
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=@minimo +10000;

-- Se vogliamo usarla in un applicativo web php va riscritta meglio

SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=(SELECT @minimo := MIN(Stipendio)
  FROM Dip_Impiegati) +10000;

-- va bene anche se eliminiamo la variabile @minimo

SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=(SELECT MIN(Stipendio)
  FROM Dip_Impiegati) +10000;

-- senza parametri la query e' banale
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=50000;

