-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: gestione_corsi_inglese
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assenze`
--

DROP TABLE IF EXISTS `assenze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assenze` (
  `Studente` varbinary(16) NOT NULL,
  `Insegnante` varbinary(16) NOT NULL,
  `DataLezione` date NOT NULL,
  `OraInizioLezione` time NOT NULL,
  PRIMARY KEY (`Studente`,`Insegnante`,`DataLezione`,`OraInizioLezione`),
  KEY `fk_assenza_lezione` (`Insegnante`,`DataLezione`,`OraInizioLezione`),
  CONSTRAINT `fk_assenza_lezione` FOREIGN KEY (`Insegnante`, `DataLezione`, `OraInizioLezione`) REFERENCES `lezioni` (`Insegnante`, `DataLezione`, `OraInizio`),
  CONSTRAINT `fk_assenza_studente` FOREIGN KEY (`Studente`) REFERENCES `studenti` (`idStudente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assenze`
--

LOCK TABLES `assenze` WRITE;
/*!40000 ALTER TABLE `assenze` DISABLE KEYS */;
INSERT INTO `assenze` VALUES (_binary '\´i\┼b8ú\õùÿò\ý]',_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-01','09:30:00'),(_binary '\´ih)┤ú\õùÿò\ý]',_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼]\├Aú\õùÿò\ý]',_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´ih)┤ú\õùÿò\ý]',_binary '\´i, Ziú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼aBYú\õùÿò\ý]',_binary '\´i, Ziú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼a©uú\õùÿò\ý]',_binary '\´i, Ziú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼b8ú\õùÿò\ý]',_binary '\´iy%\0öú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼b└\Zú\õùÿò\ý]',_binary '\´iy%\0öú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼c[8ú\õùÿò\ý]',_binary '\´iîX`ú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼dëú\õùÿò\ý]',_binary '\´iîX`ú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼d£2ú\õùÿò\ý]',_binary '\´iá= ú\õùÿò\ý]','2024-09-20','09:30:00'),(_binary '\´i\┼eG\ßú\õùÿò\ý]',_binary '\´i#5b/êú\õùÿò\ý]','2024-09-20','09:30:00');
/*!40000 ALTER TABLE `assenze` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `assenze_BEFORE_INSERT` BEFORE INSERT ON `assenze` FOR EACH ROW BEGIN
	declare var_studente varbinary(16);
    declare var_livello ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2');
    declare var_corso smallint;
    
    select LivelloCorso, Corso
    from lezioni
    where Insegnante = new.Insegnante and DataLezione = new.DataLezione and OraInizio = new.OraInizioLezione
    into var_livello, var_corso;
	
	select studente
    from iscrizioni
    where LivelloCorso = var_livello and Corso = var_corso
    into var_studente;
    
    if(!var_studente) then signal sqlstate '45014' set message_text = 'Studente non iscritto al corso a cui appartiene la lezione o lezione non esistente.';
    end if;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `corsi`
--

DROP TABLE IF EXISTS `corsi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi` (
  `idCorso` smallint unsigned NOT NULL,
  `Livello` enum('A1','A2','B1','B2','C1','C2') NOT NULL,
  `DataInizio` date NOT NULL,
  `DataFine` date NOT NULL,
  `NumIscr` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCorso`,`Livello`),
  KEY `fk_corso_livello_idx` (`Livello`),
  CONSTRAINT `fk_corso_livello` FOREIGN KEY (`Livello`) REFERENCES `livelli` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsi`
--

LOCK TABLES `corsi` WRITE;
/*!40000 ALTER TABLE `corsi` DISABLE KEYS */;
INSERT INTO `corsi` VALUES (1,'A1','2024-09-20','2025-01-20',2),(1,'A2','2024-09-20','2024-12-20',3),(1,'B1','2024-09-20','2024-12-20',2),(1,'B2','2024-09-20','2025-02-20',2),(1,'C1','2024-09-20','2024-12-20',1),(1,'C2','2024-09-20','2024-12-20',1),(2,'A1','2024-09-01','2024-12-01',1),(2,'C1','2024-09-11','2024-12-11',1),(2,'C2','2024-09-19','2024-12-19',1);
/*!40000 ALTER TABLE `corsi` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `corsi_BEFORE_INSERT` BEFORE INSERT ON `corsi` FOR EACH ROW BEGIN
	if new.DataInizio >= new.DataFine then
		signal sqlstate '45011' set message_text = 'Date di inizio e fine del corso incongruenti.';
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `corsi_BEFORE_UPDATE` BEFORE UPDATE ON `corsi` FOR EACH ROW BEGIN
	if new.DataInizio >= new.DataFine then
		signal sqlstate '45012' set message_text = 'Date di inizio e fine del corso incongruenti.';
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `docenza`
--

DROP TABLE IF EXISTS `docenza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docenza` (
  `Insegnante` varbinary(16) NOT NULL,
  `LivelloCorso` enum('A1','A2','B1','B2','C1','C2') NOT NULL,
  `Corso` smallint unsigned NOT NULL,
  `timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Insegnante`,`LivelloCorso`,`Corso`),
  KEY `fk_docenza_corso_idx` (`LivelloCorso`,`Corso`),
  CONSTRAINT `fk_docenza_corso` FOREIGN KEY (`LivelloCorso`, `Corso`) REFERENCES `corsi` (`Livello`, `idCorso`),
  CONSTRAINT `fk_docenza_insegnante` FOREIGN KEY (`Insegnante`) REFERENCES `insegnanti` (`idInsegnante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docenza`
--

LOCK TABLES `docenza` WRITE;
/*!40000 ALTER TABLE `docenza` DISABLE KEYS */;
INSERT INTO `docenza` VALUES (_binary '\´h~╣ê┤i┤\\ùÿò\ý]','A1',1,'2024-09-06 11:20:04.928518'),(_binary '\´h~╣ê┤i┤\\ùÿò\ý]','A1',2,'2024-09-06 11:20:04.928518'),(_binary '\´i, Ziú\õùÿò\ý]','A2',1,'2024-09-06 11:20:04.928518'),(_binary '\´iy%\0öú\õùÿò\ý]','B1',1,'2024-09-06 11:20:04.928518'),(_binary '\´iîX`ú\õùÿò\ý]','B2',1,'2024-09-06 11:20:04.928518'),(_binary '\´iá= ú\õùÿò\ý]','C1',1,'2024-09-06 11:20:04.928518'),(_binary '\´iá= ú\õùÿò\ý]','C1',2,'2024-09-11 15:09:02.331730'),(_binary '\´i#5b/êú\õùÿò\ý]','C2',1,'2024-09-06 11:20:04.928518'),(_binary '\´lÄ╚üQ¥É*ùÿò\ý]','C2',2,'2024-09-19 09:07:44.365925');
/*!40000 ALTER TABLE `docenza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insegnanti`
--

DROP TABLE IF EXISTS `insegnanti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insegnanti` (
  `idInsegnante` varbinary(16) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Cognome` varchar(45) NOT NULL,
  `Indirizzo` varchar(45) DEFAULT NULL,
  `Mail` varchar(45) DEFAULT NULL,
  `Nazione` varchar(45) NOT NULL,
  `idInsegnante_hex` varchar(36) GENERATED ALWAYS AS (bin_to_uuid(`idInsegnante`,1)) VIRTUAL,
  `timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`idInsegnante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insegnanti`
--

LOCK TABLES `insegnanti` WRITE;
/*!40000 ALTER TABLE `insegnanti` DISABLE KEYS */;
INSERT INTO `insegnanti` (`idInsegnante`, `Nome`, `Cognome`, `Indirizzo`, `Mail`, `Nazione`, `timestamp`) VALUES (_binary '\´h~╣ê┤i┤\\ùÿò\ý]','John','Smith','Via Garibaldi 123, Roma','john.smith@example.com','United Kingdom','2024-09-04 14:56:50.116286'),(_binary '\´i, Ziú\õùÿò\ý]','Liam','Johnson','Via dei Mille 789, Roma','liam.johnson@example.com','Canada','2024-09-04 14:56:50.116286'),(_binary '\´iy%\0öú\õùÿò\ý]','Emma','Brown','Corso Vittorio Emanuele 456, Roma','emma.brown@example.com','United States','2024-09-04 14:56:50.116286'),(_binary '\´iîX`ú\õùÿò\ý]','Olivia','Williams','Piazza del Duomo 101, Roma','olivia.williams@example.com','Australia','2024-09-04 14:56:50.116286'),(_binary '\´iá= ú\õùÿò\ý]','Sophia','Miller','Via Dante Alighieri 303, Roma','sophia.miller@example.com','Ireland','2024-09-11 15:09:02.000000'),(_binary '\´i#5b/êú\õùÿò\ý]','James','Davis','Via Mazzini 404, Bologna','james.davis@example.com','South Africa','2024-09-04 14:56:50.116286'),(_binary '\´j1ç\n/ÅIùÿò\ý]','Nate','Jackson','Via Fratelli Poggini, Roma','natejackson01@gmail.com','Canada','2024-09-04 14:56:50.116286'),(_binary '\´lÄ╚üQ¥É*ùÿò\ý]','Shila','Reyes','Via dei Giardinetti 1, Roma','shilareyes@gmail.com','philippines','2024-09-19 09:07:44.000000');
/*!40000 ALTER TABLE `insegnanti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscrizioni`
--

DROP TABLE IF EXISTS `iscrizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iscrizioni` (
  `Studente` varbinary(16) NOT NULL,
  `LivelloCorso` enum('A1','A2','B1','B2','C1','C2') NOT NULL,
  `Corso` smallint unsigned NOT NULL,
  `DataIscrizione` date NOT NULL,
  PRIMARY KEY (`Studente`,`LivelloCorso`,`Corso`),
  KEY `fk_iscrizione_corso_idx` (`Corso`,`LivelloCorso`),
  KEY `in_livello_corso` (`LivelloCorso`,`Corso`),
  CONSTRAINT `fk_iscrizione_corso` FOREIGN KEY (`Corso`, `LivelloCorso`) REFERENCES `corsi` (`idCorso`, `Livello`),
  CONSTRAINT `fk_iscrizione_studente` FOREIGN KEY (`Studente`) REFERENCES `studenti` (`idStudente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscrizioni`
--

LOCK TABLES `iscrizioni` WRITE;
/*!40000 ALTER TABLE `iscrizioni` DISABLE KEYS */;
INSERT INTO `iscrizioni` VALUES (_binary '\´ih)┤ú\õùÿò\ý]','A1',1,'2024-09-10'),(_binary '\´ih)┤ú\õùÿò\ý]','A2',1,'2024-08-25'),(_binary '\´i\┼]\├Aú\õùÿò\ý]','A1',1,'2024-09-10'),(_binary '\´i\┼aBYú\õùÿò\ý]','A2',1,'2024-09-10'),(_binary '\´i\┼a©uú\õùÿò\ý]','A2',1,'2024-09-10'),(_binary '\´i\┼b8ú\õùÿò\ý]','A1',2,'2024-08-25'),(_binary '\´i\┼b8ú\õùÿò\ý]','B1',1,'2024-09-10'),(_binary '\´i\┼b└\Zú\õùÿò\ý]','B1',1,'2024-09-10'),(_binary '\´i\┼c[8ú\õùÿò\ý]','B2',1,'2024-09-10'),(_binary '\´i\┼dëú\õùÿò\ý]','B2',1,'2024-09-10'),(_binary '\´i\┼d£2ú\õùÿò\ý]','C1',1,'2024-09-10'),(_binary '\´i\┼eG\ßú\õùÿò\ý]','C2',1,'2024-09-10'),(_binary '\´oçî\ÏTøùÿò\ý]','C1',2,'2024-09-10'),(_binary '\´oçî\ÏTøùÿò\ý]','C2',2,'2024-09-18');
/*!40000 ALTER TABLE `iscrizioni` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `iscrizioni_BEFORE_INSERT` BEFORE INSERT ON `iscrizioni` FOR EACH ROW BEGIN
	declare var_data_fine_corso date;
    
    select DataFine
    from corsi
    where Livello = new.LivelloCorso and idCorso = new.Corso
    into var_data_fine_corso;
    
    if var_data_fine_corso < new.DataIscrizione then 
		signal sqlstate '45013' set message_text = 'Corso gi├á finito.';
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `lezioni`
--

DROP TABLE IF EXISTS `lezioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lezioni` (
  `Insegnante` varbinary(16) NOT NULL,
  `DataLezione` date NOT NULL,
  `OraInizio` time NOT NULL,
  `OraFine` time NOT NULL,
  `LivelloCorso` enum('A1','A2','B1','B2','C1','C2') NOT NULL,
  `Corso` smallint unsigned NOT NULL,
  `Insegnante_hex` varchar(36) GENERATED ALWAYS AS (bin_to_uuid(`Insegnante`,1)) VIRTUAL,
  PRIMARY KEY (`Insegnante`,`DataLezione`,`OraInizio`),
  KEY `fk_lezione_corso_idx` (`LivelloCorso`,`Corso`),
  KEY `in_ins_data_ora` (`Insegnante`,`DataLezione`,`OraInizio`),
  CONSTRAINT `fk_lezione_corso` FOREIGN KEY (`LivelloCorso`, `Corso`) REFERENCES `corsi` (`Livello`, `idCorso`),
  CONSTRAINT `fk_lezione_insegnante` FOREIGN KEY (`Insegnante`) REFERENCES `insegnanti` (`idInsegnante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lezioni`
--

LOCK TABLES `lezioni` WRITE;
/*!40000 ALTER TABLE `lezioni` DISABLE KEYS */;
INSERT INTO `lezioni` (`Insegnante`, `DataLezione`, `OraInizio`, `OraFine`, `LivelloCorso`, `Corso`) VALUES (_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-01','09:30:00','11:00:00','A1',2),(_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-02','09:30:00','11:00:00','A1',2),(_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-09','09:30:00','11:00:00','A1',2),(_binary '\´h~╣ê┤i┤\\ùÿò\ý]','2024-09-20','09:30:00','11:00:00','A1',1),(_binary '\´i, Ziú\õùÿò\ý]','2024-09-20','09:30:00','11:00:00','A2',1),(_binary '\´i, Ziú\õùÿò\ý]','2024-09-21','09:30:00','11:00:00','A2',1),(_binary '\´i, Ziú\õùÿò\ý]','2024-09-27','09:30:00','11:00:00','A2',1),(_binary '\´iy%\0öú\õùÿò\ý]','2024-09-20','09:30:00','11:00:00','B1',1),(_binary '\´iîX`ú\õùÿò\ý]','2024-09-20','09:30:00','11:00:00','B2',1),(_binary '\´iá= ú\õùÿò\ý]','2024-09-20','09:30:00','11:00:00','C1',1),(_binary '\´iá= ú\õùÿò\ý]','2024-09-27','09:30:00','11:00:00','C1',2),(_binary '\´i#5b/êú\õùÿò\ý]','2024-09-20','09:30:00','11:00:00','C2',1);
/*!40000 ALTER TABLE `lezioni` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `lezioni_BEFORE_INSERT` BEFORE INSERT ON `lezioni` FOR EACH ROW BEGIN
	declare var_dataInizio date;
    declare var_dataFine date;
    DECLARE done boolean default false;
    declare var_ora_inizio time;
    declare var_ora_fine time;
    
    DECLARE cur_ins CURSOR FOR 
    SELECT OraInizio, OraFine
    FROM lezioni
    WHERE Insegnante = new.Insegnante and DataLezione = new.DataLezione;
    
    DECLARE cur_cor CURSOR FOR
    SELECT OraInizio, OraFine
    FROM lezioni
    WHERE LivelloCorso = new.LivelloCorso and Corso = new.Corso and DataLezione = new.DataLezione;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
    
    select DataInizio, DataFine
    from corsi
    where idCorso = new.Corso and Livello = new.LivelloCorso
    into var_dataInizio, var_dataFine;
    
    if(new.DataLezione < var_dataInizio or new.DataLezione > var_dataFine) then SIGNAL SQLSTATE '45010' SET MESSAGE_TEXT = 'Data lezione non appartiene al periodo in cui si tiene il corso.';
    end if;
    
	IF new.oraInizio >= new.oraFine then signal sqlstate '45001' set message_text = 'Orari lezione incongruenti.';
    END IF;

    OPEN cur_ins;
    
    loop_ins: LOOP
        
        FETCH cur_ins INTO var_ora_inizio, var_ora_fine;
        
        IF done = true THEN
            LEAVE loop_ins;
        END IF;

        IF (var_ora_inizio <= new.OraInizio and var_ora_fine >= new.OraInizio) THEN signal sqlstate '45002' set message_text = 'Orario lezione in conflitto con lezioni precedenti insegnante.';
        ELSEIF (var_ora_inizio >= new.OraInizio and var_ora_inizio <= new.OraFine) THEN signal sqlstate '45003' set message_text = 'Orario lezione in conflitto con lezioni successive insegnante.';
        ELSEIF (var_ora_inizio <= new.OraInizio and var_ora_fine >= new.OraFine) THEN signal sqlstate '45004' set message_text = 'Orario lezione in sovrapposizione a lezione precedente insegnante.';
        ELSEIF (var_ora_inizio >= new.OraInizio and var_ora_fine <= new.OraFine) THEN signal sqlstate '45005' set message_text = 'Orario lezione in sovrapposizione a lezione precedente insegnante.';
        END IF;

	END LOOP loop_ins;

    CLOSE cur_ins;
    
    set done = false;
    OPEN cur_cor;
    
     loop_cor: LOOP
        
        FETCH cur_cor INTO var_ora_inizio, var_ora_fine;
        
        IF done = true THEN
            LEAVE loop_cor;
        END IF;

        IF (var_ora_inizio <= new.OraInizio and var_ora_fine >= new.OraInizio) THEN signal sqlstate '45006' set message_text = 'Orario lezione in conflitto con lezioni precedenti corso.';
        ELSEIF (var_ora_inizio >= new.OraInizio and var_ora_inizio <= new.OraFine) THEN signal sqlstate '45007' set message_text = 'Orario lezione in conflitto con lezioni successive corso.';
        ELSEIF (var_ora_inizio <= new.OraInizio and var_ora_fine >= new.OraFine) THEN signal sqlstate '45008' set message_text = 'Orario lezione in sovrapposizione a lezione precedente corso.';
        ELSEIF (var_ora_inizio >= new.OraInizio and var_ora_fine <= new.OraFine) THEN signal sqlstate '45009' set message_text = 'Orario lezione in sovrapposizione a lezione precedente corso.';
        END IF;

	END LOOP loop_cor;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `livelli`
--

DROP TABLE IF EXISTS `livelli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livelli` (
  `Nome` enum('A1','A2','B1','B2','C1','C2') NOT NULL,
  `Libro` varchar(45) NOT NULL,
  `Esame` tinyint NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livelli`
--

LOCK TABLES `livelli` WRITE;
/*!40000 ALTER TABLE `livelli` DISABLE KEYS */;
INSERT INTO `livelli` VALUES ('A1','Ready for A1',1),('A2','Ready for A2',1),('B1','Ready for B1',1),('B2','Ready for B2',1),('C1','Ready for C1',1),('C2','Ready for C2',1);
/*!40000 ALTER TABLE `livelli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studenti`
--

DROP TABLE IF EXISTS `studenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studenti` (
  `idStudente` varbinary(16) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Cognome` varchar(45) NOT NULL,
  `Indirizzo` varchar(45) DEFAULT NULL,
  `Mail` varchar(45) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `idStudente_hex` varchar(36) GENERATED ALWAYS AS (bin_to_uuid(`idStudente`,1)) VIRTUAL,
  `timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`idStudente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studenti`
--

LOCK TABLES `studenti` WRITE;
/*!40000 ALTER TABLE `studenti` DISABLE KEYS */;
INSERT INTO `studenti` (`idStudente`, `Nome`, `Cognome`, `Indirizzo`, `Mail`, `Telefono`, `timestamp`) VALUES (_binary '\´ih)┤ú\õùÿò\ý]','Andrea','Rossi','Via Roma 1, Roma','andrea.rossi@example.com','3331234567','2024-09-04 14:54:28.221307'),(_binary '\´i\┼]\├Aú\õùÿò\ý]','Maria','Bianchi','Corso Italia 2, Roma','maria.bianchi@example.com','3332345678','2024-09-04 14:54:28.221307'),(_binary '\´i\┼aBYú\õùÿò\ý]','Giovanni','Esposito','Via Garibaldi 3, Roma','giovanni.esposito@example.com','3333456789','2024-09-04 14:54:28.221307'),(_binary '\´i\┼a©uú\õùÿò\ý]','Marco','Ferrari','Via Veneto 6, Roma','marco.ferrari@example.com','3336789012','2024-09-04 14:54:28.221307'),(_binary '\´i\┼b8ú\õùÿò\ý]','Elisa','Russo','Via Manzoni 7, Roma','elisa.russo@example.com','3337890123','2024-09-04 14:54:28.221307'),(_binary '\´i\┼b└\Zú\õùÿò\ý]','Laura','Conti','Via Verdi 9, Roma','laura.conti@example.com','3339012345','2024-09-04 14:54:28.221307'),(_binary '\´i\┼c[8ú\õùÿò\ý]','Giulia','Romano','Viale Europa 10, Roma','giulia.romano@example.com','3330123456','2024-09-04 14:54:28.221307'),(_binary '\´i\┼dëú\õùÿò\ý]','Serena','Bruno','Corso Italia 12, Roma','serena.bruno@example.com','3332345002','2024-09-04 14:54:28.221307'),(_binary '\´i\┼d£2ú\õùÿò\ý]','Michele','Rinaldi','Via Garibaldi 13, Roma','michele.rinaldi@example.com','3333456003','2024-09-04 14:54:28.221307'),(_binary '\´i\┼eG\ßú\õùÿò\ý]','Giada','Colombo','Piazza Duomo 14, Roma','giada.colombo@example.com','3334567004','2024-09-04 14:54:28.221307'),(_binary '\´j2\÷ÍÅIùÿò\ý]','Zoe','Fanciullo','Via cambridge 2, Roma','zoefanciullo@gmail.com','3334586977','2024-09-04 14:54:28.221307'),(_binary '\´lÅ\Ò\0\¸É*ùÿò\ý]','Beatrice','Cialini','Via di Capannelle 45, Roma','beatricecialini@gmail.com','3356124890','2024-09-06 20:47:34.000000'),(_binary '\´oçî\ÏTøùÿò\ý]','Aurora','Chiodi','Via di capannelle 84, Roma','aurorachiodi@gmail.com','33626842684','2024-09-19 09:06:24.000000');
/*!40000 ALTER TABLE `studenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utenti`
--

DROP TABLE IF EXISTS `utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utenti` (
  `username` varbinary(16) NOT NULL,
  `password` varchar(32) NOT NULL,
  `ruolo` enum('segreteria','insegnante') NOT NULL,
  `username_hex` varchar(36) GENERATED ALWAYS AS (bin_to_uuid(`username`,1)) VIRTUAL,
  `timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti`
--

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` (`username`, `password`, `ruolo`, `timestamp`) VALUES (_binary '\´h~╣ê┤i┤\\ùÿò\ý]','46b1cae3464a4bc407a9e97873ec3210','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´i\Ó#UËú\õùÿò\ý]','d562ce4310ba00d35f113262d186fd8a','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´i\­┤C®ú\õùÿò\ý]','66310af7e97ca3a9184d37d269b4a6c8','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´i, Ziú\õùÿò\ý]','743a80dbc988f698096d574e326b0373','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´iHù▓·ú\õùÿò\ý]','dc2dd992491dc5640deddce9b945d4cf','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´iy%\0öú\õùÿò\ý]','14b2b71ad44c500fe152c3acc861b9f8','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´iîX`ú\õùÿò\ý]','fcfc49567d986cd9ce674cf600f74d57','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´iá= ú\õùÿò\ý]','78d1732d01c912ef57622466d579a4b8','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´i#5b/êú\õùÿò\ý]','03373de8e8968b2c79a0932e38cda8b7','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´j\0ù\Î_Ì£¡ùÿò\ý]','6b89bed921ae1ec22af13305dafed935','segreteria','2024-09-09 15:57:01.000000'),(_binary '\´j1ç\n/ÅIùÿò\ý]','929ebb6dd35e47ef4bc08131e0a2f524','insegnante','2024-09-04 14:57:17.455692'),(_binary '\´lÄ╚üQ¥É*ùÿò\ý]','36aa45cc751e6edb07bc6961496fe919','insegnante','2024-09-06 20:29:57.688965');
/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'gestione_corsi_inglese'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `aggiorna_cred_segreteria` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `aggiorna_cred_segreteria` ON SCHEDULE EVERY 5 YEAR STARTS '2024-09-09 17:57:01' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE utenti
  SET timestamp = current_timestamp()
  WHERE ruolo = 'segreteria' */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `cancella_entries` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `cancella_entries` ON SCHEDULE EVERY 4 MONTH STARTS '2024-09-09 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL elimina_vecchie_entries() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'gestione_corsi_inglese'
--
/*!50003 DROP PROCEDURE IF EXISTS `aggiorna_data_fine_corso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiorna_data_fine_corso`(in var_livelloCorso ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint, in var_nuova_data date)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

	set transaction isolation level repeatable read;
    start transaction;
    
		UPDATE corsi set DataFine = var_nuova_data where Livello = var_livelloCorso and idCorso = var_corso;
    
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `aggiungi_corso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_corso`(in var_livello ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_dataInizio date, in var_dataFine date, out var_idCorso smallint)
BEGIN
	declare var_id smallint;
    
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
	set transaction isolation level serializable;
    start transaction;
    
		select max(idCorso)
        from corsi
        where Livello = var_livello 
        into var_id;
        
        set var_idCorso = var_id;
		
        if var_idCorso is null then set var_idCorso = 1;
		else set var_idCorso = var_idCorso + 1;
        end if;
        
		insert into corsi(idCorso, Livello, DataInizio, DataFine) values (var_idCorso, var_livello, var_dataInizio, var_dataFine);
    
    commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `aggiungi_insegnante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_insegnante`(in var_nome varchar(45), in var_cognome varchar(45), in var_indirizzo varchar(45), in var_mail varchar(45), in var_nazione varchar(45), out var_idInsegnante varchar(36))
BEGIN
	declare var_idBin varbinary(16);
    
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set var_idInsegnante = uuid();
    set var_idBin = uuid_to_bin(var_idInsegnante, 1);
    
    set transaction isolation level repeatable read;
    start transaction;
    
		insert into insegnanti(idInsegnante, Nome, Cognome, Indirizzo, Mail, Nazione) values (var_idBin, var_nome, var_cognome, var_indirizzo, var_mail, var_nazione);
		insert into utenti(username, password, ruolo) values (var_idBin, md5(var_idInsegnante), 'insegnante');
        
	commit;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `aggiungi_lezione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_lezione`(in var_insegnante varchar(36), in var_dataLezione date, in var_oraInizio time, in var_oraFine time, in var_livelloCorso ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

	set transaction isolation level serializable;
    start transaction;
    
		insert into lezioni(Insegnante, DataLezione, OraInizio, OraFine, LivelloCorso, Corso) values (uuid_to_bin(var_insegnante,1), var_dataLezione, var_oraInizio, var_oraFine, var_livelloCorso, var_corso);

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `aggiungi_studente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `aggiungi_studente`(in var_nome varchar(45), in var_cognome varchar(45), in var_indirizzo varchar(45), in var_mail varchar(45), in var_telefono varchar(15), out var_idStudente varchar(36))
BEGIN    
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
	
    set var_idStudente = uuid();
    
	set transaction isolation level repeatable read;
    start transaction;
    
		insert into studenti(idStudente, Nome, Cognome, Indirizzo, Mail, Telefono) values (uuid_to_bin(var_idStudente, 1), var_nome, var_cognome, var_indirizzo, var_mail, var_telefono);
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assegna_corso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assegna_corso`(in var_insegnante varchar(36), in var_livelloCorso ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint)
BEGIN
		declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
	set transaction isolation level repeatable read;
    start transaction;
        
		insert into docenza(Insegnante, LivelloCorso, Corso) values (uuid_to_bin(var_insegnante,1), var_livelloCorso, var_corso);
		update insegnanti set timestamp = current_timestamp() where idInsegnante = uuid_to_bin(var_insegnante,1);
        
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `elimina_vecchie_entries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `elimina_vecchie_entries`()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
    
	SET SQL_SAFE_UPDATES = 0;
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	START TRANSACTION;
		DELETE FROM assenze WHERE DataLezione < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);
		DELETE FROM iscrizioni WHERE DataIscrizione < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);
		DELETE FROM docenza WHERE timestamp < NOW() - INTERVAL 10 YEAR;
	COMMIT;

	START TRANSACTION;
		DELETE FROM lezioni WHERE DataLezione < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);
		DELETE FROM corsi WHERE DataFine < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);
	COMMIT;

	START TRANSACTION;
		DELETE FROM insegnanti WHERE timestamp < NOW() - INTERVAL 10 YEAR;
		DELETE FROM studenti WHERE timestamp < NOW() - INTERVAL 10 YEAR;
		DELETE FROM utenti WHERE timestamp < NOW() - INTERVAL 10 YEAR;
	COMMIT;
    
    SET SQL_SAFE_UPDATES = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista studenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista studenti`()
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select idStudente_hex, Nome, Cognome, Indirizzo, Mail, Telefono
		from studenti
        where timestamp >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_assenze_studente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_assenze_studente`(in var_idStudente varchar(36), in var_livello ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select assenze.DataLezione, OraInizioLezione 
		from assenze join lezioni on assenze.Insegnante=lezioni.Insegnante and assenze.DataLezione=lezioni.DataLezione and OraInizioLezione=OraInizio
		where Studente = uuid_to_bin(var_idStudente, 1) and LivelloCorso = var_livello and Corso = var_corso
        order by DataLezione, OraInizioLezione;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_corsi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_corsi`()
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select Livello, idCorso, DataInizio, DataFine, NumIscr
		from corsi
		where DataFine >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
        order by DataInizio; 
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_corsi_insegnante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_corsi_insegnante`(in var_idInsegnante varchar(36))
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select LivelloCorso, Corso, DataInizio, DataFine, NumIscr
		from docenza join corsi on LivelloCorso=Livello and Corso=idCorso
		where Insegnante = uuid_to_bin(var_idInsegnante, 1) ;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_insegnanti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_insegnanti`()
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select idInsegnante_hex, Nome, Cognome, Indirizzo, Mail, Nazione
		from insegnanti
        where timestamp >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_iscrizioni_studente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_iscrizioni_studente`(in var_studente varchar(36))
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select LivelloCorso, Corso, DataIscrizione
		from iscrizioni
		where Studente = uuid_to_bin(var_studente,1);
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_lezioni_corso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_lezioni_corso`(in var_livelloCorso ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select bin_to_uuid(Insegnante, 1), DataLezione, OraInizio, OraFine
		from lezioni
		where LivelloCorso = var_livelloCorso and Corso = var_corso;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_livelli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_livelli`()
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select *
		from livelli
        order by Nome;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_studenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_studenti`()
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select idStudente_hex, Nome, Cognome, Indirizzo, Mail, Telefono
		from studenti
        where timestamp >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lista_studenti_corso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_studenti_corso`(in var_livello ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select idStudente_hex, Nome, Cognome, Indirizzo, Mail, Telefono
        from iscrizioni join studenti on Studente = idStudente
        where LivelloCorso = var_livello and Corso = var_corso
        order by Cognome, Nome;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login`(in var_username varchar(36), in var_pass varchar(45), out var_role INT)
BEGIN
	declare var_user_role ENUM('segreteria', 'insegnante');
    
    select ruolo from Utenti
		where username = uuid_to_bin(var_username,1)
        and password = md5(var_pass)
        into var_user_role;
        
	-- See the corresponding enum in the client
		if var_user_role = 'segreteria' then
			set var_role = 1;
		elseif var_user_role = 'insegnante' then
			set var_role = 2;
		else
			set var_role = 3;
		end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ottieni_info_corso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ottieni_info_corso`(
    IN var_livelloCorso ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'),
    IN var_corso smallint
)
BEGIN
	DECLARE var_iscr INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    START TRANSACTION;

    SELECT DataInizio, DataFine, Libro, Esame, NumIscr, insegnanti.Nome, Cognome, idInsegnante_hex
    FROM corsi 
    JOIN docenza ON Livello = LivelloCorso AND idCorso = Corso 
    JOIN insegnanti ON Insegnante = idInsegnante
    JOIN livelli on Livello = livelli.Nome
    WHERE LivelloCorso = var_livelloCorso AND Corso = var_corso;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ottieni_info_insegnante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ottieni_info_insegnante`(in var_idInsegnante varchar(36))
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select Nome, Cognome, Indirizzo, Mail, Nazione 
		from insegnanti
		where idInsegnante = uuid_to_bin(var_idInsegnante, 1) ;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ottieni_info_studente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ottieni_info_studente`(in var_idStudente varchar(36))
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    set transaction read only;
    start transaction;
    
		select Nome, Cognome, Indirizzo, Mail, Telefono 
		from studenti
		where idStudente = uuid_to_bin(var_idStudente, 1) ;
	
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_assenza` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_assenza`(in var_studente varchar(36), in var_insegnante varchar(36), in var_dataLezione date, in var_oraInizioLezione time)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level repeatable read;
    start transaction;
    
		insert into assenze(Studente, Insegnante, DataLezione, OraInizioLezione) values (uuid_to_bin(var_studente,1), uuid_to_bin(var_insegnante,1), var_dataLezione, var_oraInizioLezione);

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_iscrizione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_iscrizione`(in var_studente varchar(36), in var_livelloCorso ENUM('A1', 'A2', 'B1', 'B2', 'C1', 'C2'), in var_corso smallint, in var_dataIscrizione date)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level serializable;
    start transaction;
    
		insert into iscrizioni(Studente, LivelloCorso, Corso, DataIscrizione) values (uuid_to_bin(var_studente,1), var_livelloCorso, var_corso, var_dataIscrizione);
		update studenti set timestamp = current_timestamp() where idStudente = uuid_to_bin(var_studente,1);
        update corsi set NumIscr = NumIScr + 1 where Livello = var_livelloCorso and idCorso = var_corso;
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `report_mensile_lezioni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_mensile_lezioni`(in var_date date)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level serializable;
    set transaction read only;
    start transaction;
    
		select Insegnante_hex, DataLezione, OraInizio, OraFine, LivelloCorso, Corso
		from lezioni
		where 
			DataLezione >= DATE_FORMAT(var_date, '%Y-%m-01')
			and DataLezione < DATE_ADD(DATE_FORMAT(var_date, '%Y-%m-01'), INTERVAL 1 MONTH)
		order by Insegnante_hex, DataLezione, OraInizio;
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `report_mensile_lezioni_insegnante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_mensile_lezioni_insegnante`(in var_insegnante varchar(36), in var_date date)
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level serializable;
    set transaction read only;
    start transaction;
    
		select DataLezione, OraInizio, OraFine, LivelloCorso, Corso
		from lezioni
		where 
			Insegnante = uuid_to_bin(var_insegnante,1)
			and DataLezione >= DATE_FORMAT(var_date, '%Y-%m-01')
			and DataLezione < DATE_ADD(DATE_FORMAT(var_date, '%Y-%m-01'), INTERVAL 1 MONTH)
		order by DataLezione, OraInizio;
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `report_settimana_corrente_lezioni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_settimana_corrente_lezioni`(in var_insegnante varchar(36))
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level serializable;
    set transaction read only;
    start transaction;
    
		select DataLezione, OraInizio, OraFine, LivelloCorso, Corso
		from lezioni
		where 
			Insegnante = uuid_to_bin(var_insegnante,1)
			and DataLezione >= DATE_SUB(CURDATE(), INTERVAL WEEKDAY(CURDATE()) DAY) 
			and DataLezione < DATE_ADD(DATE_SUB(CURDATE(), INTERVAL WEEKDAY(CURDATE()) DAY), INTERVAL 7 DAY)
		order by DataLezione, OraInizio;
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `report_settimana_prossima_lezioni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_settimana_prossima_lezioni`(in var_insegnante varchar(36))
BEGIN
	declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;
    
    set transaction isolation level serializable;
    set transaction read only;
    start transaction;
    
		select DataLezione, OraInizio, OraFine, LivelloCorso, Corso
		from lezioni
		where 
			Insegnante = uuid_to_bin(var_insegnante,1)
			and DataLezione >= CURDATE() + INTERVAL (7 - WEEKDAY(CURDATE())) DAY
			and DataLezione < CURDATE() + INTERVAL (14 - WEEKDAY(CURDATE())) DAY
		order by DataLezione, OraInizio;
        
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

DROP USER IF EXISTS 'login';
CREATE USER 'login' IDENTIFIED BY 'login';
DROP USER IF EXISTS 'segreteria';
CREATE USER 'segreteria' IDENTIFIED BY 'segreteria';
DROP USER IF EXISTS 'insegnante';
CREATE USER 'insegnante' IDENTIFIED BY 'insegnante';

GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.aggiungi_corso to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.aggiungi_insegnante to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.aggiungi_lezione to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.aggiungi_studente to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.assegna_corso to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_assenze_studente to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_corsi_insegnante to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_iscrizioni_studente to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_lezioni_corso to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.ottieni_info_corso to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.ottieni_info_insegnante to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.ottieni_info_studente to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.registra_assenza to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.registra_iscrizione to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.report_mensile_lezioni to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.report_mensile_lezioni_insegnante to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.aggiorna_data_fine_corso to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_corsi to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_insegnanti to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_studenti to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_livelli to 'segreteria';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.lista_studenti_corso to 'segreteria';

GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.report_settimana_corrente_lezioni to 'insegnante';
GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.report_settimana_prossima_lezioni to 'insegnante';

GRANT EXECUTE ON PROCEDURE gestione_corsi_inglese.login to 'login';
-- Dump completed on 2024-09-19 14:55:06
