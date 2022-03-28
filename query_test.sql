-- query_test.sql su Dip_Impiegati
-- Database: `Dip_Impiegati`
-- prefisso Dip_
--
-- solo creo tabelle per test Alter table

CREATE TABLE IF NOT EXISTS Dipartimenti (
  Codice char(5) NOT NULL,
  Descrizione char(20) NOT NULL,
  Sede char(20) DEFAULT NULL,
  Manager smallint DEFAULT NULL,
  PRIMARY KEY (Codice)
);

CREATE TABLE IF NOT EXISTS Impiegati (
  ID smallint NOT NULL,
  Nome char(20) NOT NULL,
  Cognome char(30) NOT NULL,
  Residenza char(20) DEFAULT '*** Manca Residenza',
  Stipendio decimal(9,2) DEFAULT NULL,
  Dipartimento char(5) DEFAULT NULL,
  foreign key (Dipartimento) references Dipartimenti(Codice),
  PRIMARY KEY (ID)
);

--slide  Cambiamento della struttura di una tabella
-- Aggiunta del campo Nascita a Impiegati 

ALTER TABLE Impiegati
	ADD Nascita date;


-- Eliminazione di Residenza da Impiegati

ALTER TABLE Impiegati
	DROP Residenza;

-- La coppia di attributi: Cognome, Nome indicizzata e non duplicabile

CREATE UNIQUE INDEX IndiceImpiegati
	ON Impiegati(Cognome, Nome);

-- Eliminazione della tabella Impiegati
DROP TABLE Impiegati;

--slide  Manipolazione dei dati (1)
-- Inserimento di un record nella tabella Impiegati

	INSERT INTO Impiegati
	(ID, Nome, Cognome, Residenza, Stipendio, Dipartimento)
	VALUES(20,'Mario','Rossini','Caserta',31500,'Mag');  
	INSERT INTO Impiegati
	VALUES(21,'Enrico','Grossi','Nuoro',28800,'Prod');

-- Inserimento di un record con campi mancanti:  

	INSERT INTO Impiegati (ID, Nome, Cognome, Stipendio)
	VALUES(22,'Bruno','Locatelli',33000);

-- Rossini lavora in Produzione, non in magazzino:  

	UPDATE Impiegati
	SET Dipartimento = 'Prod'
	WHERE Matricola = 20;

--slide  Manipolazione dei dati (2) 
-- Aumento del 5% ai dipendenti della Produzione
UPDATE Impiegati
	SET Stipendio = Stipendio * 1.05
	WHERE Dipartimento = 'Prod';
	

-- Eliminazione del dipendente con ID = 20:  
DELETE FROM Impiegati
	WHERE ID = 20;
	

-- Cancellazione di tutti i dipendenti del reparto R&S:  
	
DELETE FROM Impiegati
	WHERE Dipartimento = 'R&S';

-- Cosa fanno?
UPDATE Impiegati SET Stipendio = Stipendio * 1.15;
	DELETE FROM Impiegati;

