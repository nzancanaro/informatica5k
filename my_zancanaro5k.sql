-- phpMyAdmin SQL Dump
-- version 4.1.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 09, 2022 alle 21:55
-- Versione del server: 8.0.26
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `my_zancanaro5k`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `Dipartimenti`
--

CREATE TABLE IF NOT EXISTS `Dipartimenti` (
  `Codice` char(5) NOT NULL,
  `Descrizione` char(20) NOT NULL,
  `Sede` char(20) DEFAULT NULL,
  `Manager` smallint DEFAULT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `Descrizione` (`Descrizione`),
  KEY `Manager` (`Manager`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `Impiegati`
--

CREATE TABLE IF NOT EXISTS `Impiegati` (
  `ID` smallint NOT NULL,
  `Nome` char(20) NOT NULL,
  `Cognome` char(30) NOT NULL,
  `Residenza` char(20) DEFAULT '*** Manca Residenza',
  `Stipendio` decimal(9,2) DEFAULT NULL,
  `Dipartimento` char(5) DEFAULT NULL,
  `Nascita` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IndiceImpiegati` (`Cognome`,`Nome`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=1 ;

--
-- Dump dei dati per la tabella `Impiegati`
--

INSERT INTO `Impiegati` (`ID`, `Nome`, `Cognome`, `Residenza`, `Stipendio`, `Dipartimento`, `Nascita`) VALUES
(20, 'Mario', 'Rossini', 'Caserta', '31500.00', 'Mag', NULL),
(21, 'Enrico', 'Grossi', 'Nuoro', '30240.00', 'Prod', NULL),
(22, 'Bruno', 'Locatelli', '*** Manca Residenza', '33000.00', NULL, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
