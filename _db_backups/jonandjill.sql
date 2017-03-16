-- MySQL dump 10.13  Distrib 5.5.19, for Linux (x86_64)
--
-- Host: 50.63.232.105    Database: jonandjill
-- ------------------------------------------------------
-- Server version	5.0.96-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `AttendanceType` int(10) unsigned NOT NULL,
  `RSVP` int(10) unsigned NOT NULL default '0',
  `NumAttending` int(10) unsigned NOT NULL default '0',
  `FoodChoice` int(10) unsigned NOT NULL default '0',
  `PhysicalAddress` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,0,0,0,0,'6726 Holly Farm Lane/Warrenton, VA 20187','Jon\'s Parents'),(2,0,1,2,0,'2549 Bryant Ave S #1, Minneapolis, MN 55405','Bride and Groom'),(3,0,0,0,0,'','Kristy Reid'),(4,0,0,0,0,'','Jill\'s Parents'),(5,0,0,0,0,'','Max Slater'),(6,1,0,0,0,'','Slater Grandparents'),(7,0,0,0,0,'','Grandma Morfit'),(8,0,0,0,0,'','Aunt Kathy and Linda'),(9,1,0,0,0,'','Aunt Debby and Dan'),(10,1,0,0,0,'','Scott and Krista Say'),(11,1,0,0,0,'','Mike and Vip'),(12,1,0,0,0,'','Tammy and Kurt'),(13,1,0,0,0,'','Jenni and Raymudo'),(14,1,0,0,0,'','Mickey and Pat'),(15,1,0,0,0,'','Molly and Chris'),(16,1,0,0,0,'','Becca and Tavis'),(17,1,0,0,0,'','Patty and Clay'),(18,1,0,0,0,'','Adam and Rose'),(19,1,0,0,0,'','Jason plus 1'),(20,0,0,0,0,'','Gordon and Jan'),(21,0,0,0,0,'','Carly and Frank'),(22,0,0,0,0,'','Mark and Wendy and family'),(23,0,0,0,0,'','Danny and Naomi'),(24,1,0,0,0,'','Mary and Joe LAconic'),(25,1,0,0,0,'','Darcy and Ole Olson'),(26,1,0,0,0,'','Barb and Rob McIntosh'),(27,1,0,0,0,'','Cathie and Fish Fischer'),(28,1,0,0,0,'','Nancy Hook plus 1'),(29,1,0,0,0,'','Dianne and Gary Thompson'),(30,1,0,0,0,'','Barb and Rob Auer'),(31,1,0,0,0,'','Laurie and Greg Parker'),(32,1,0,0,0,'','Anton\'s Parents'),(33,1,0,0,0,'','Tom Friant plus 1'),(34,1,0,0,0,'','Matt and Em Rengo'),(35,0,0,0,0,'','Laura and Anton'),(36,0,0,0,0,'','Grandma Kruschke'),(37,0,0,0,0,'','Peter Voth and family'),(38,0,0,0,0,'','Matt and Katherine'),(39,1,0,0,0,'','Uncle pete plus 1'),(40,1,0,0,0,'','Aunt Sue'),(41,1,0,0,0,'','Rosalie and Jerry'),(42,1,0,0,0,'','Aunt Becky'),(43,1,0,0,0,'','Vic and Sheryl'),(44,1,0,0,0,'','Aunt Kay'),(45,1,0,0,0,'','Dave and Kristine'),(46,1,0,0,0,'','Dan and Crystal'),(47,1,0,0,0,'','Benji and Janine'),(48,1,0,0,0,'','Jamie Kohn'),(49,1,0,0,0,'','Katie and Matt Langer'),(50,1,0,0,0,'','Calie and Steve Vera'),(51,1,0,0,0,'','Tressa and Drew'),(52,1,0,0,0,'','Jess and Ken'),(53,1,0,0,0,'','Mandi and Kriby'),(54,1,0,0,0,'','Eric and Cheryl'),(55,1,0,0,0,'','Kristi Voth'),(56,0,0,0,0,'','George Detrick and Pam'),(57,1,0,0,0,'','Cindy Rollins'),(58,1,0,0,0,'','Bierleins'),(59,1,0,0,0,'','Poggenburgs'),(60,1,0,0,0,'','Irene Hansen and Lori'),(61,1,0,0,0,'','Tom and Glenda Bjungstad'),(62,1,0,0,0,'','Esther Hansen'),(63,1,0,0,0,'','Alice and Wally Sayles and Brenda'),(64,1,0,0,0,'','Matt Kroll\'s Parents'),(65,1,0,0,0,'','Maria\'s Mom and Warren'),(66,1,0,0,0,'','Maria\'s Dad and Gladys'),(67,1,0,0,0,'','Pat Norine'),(68,1,0,0,0,'','Sabrina plus 1'),(69,2,0,0,0,'','Nicole and Eric Sottlemyre'),(70,2,0,0,0,'','Jeanna and Brad Passmore'),(71,1,0,0,0,'','Lori and Al Barnett'),(72,1,0,0,0,'','Gabe and Erin Watson'),(73,2,0,0,0,'','May and Hao Troung'),(74,1,0,0,0,'','Danny and Lizzy'),(75,1,0,0,0,'','Brian Casey and Nikki'),(76,1,0,0,0,'','Matt and Molly Mons'),(77,1,0,0,0,'','Charlie Kepke plus 1'),(78,1,0,0,0,'','The Mechelkes'),(79,0,0,0,0,'','Adam Charmichael'),(80,0,0,0,0,'','Ricky Coles'),(81,0,0,0,0,'','Draeke and Adina'),(82,1,0,0,0,'','Ben and Tina'),(83,2,0,0,0,'','Seth and Angela'),(84,1,0,0,0,'','Justin and Erin Ley'),(85,1,0,0,0,'','Tanya and Garth'),(86,1,0,0,0,'','Vanessa and Brian'),(87,1,0,0,0,'','Jacci and Kent'),(88,2,0,0,0,'','Kelly and Joe Swanson'),(89,2,0,0,0,'','Natalie Wanger and Matt'),(90,2,0,0,0,'','Holzemers'),(91,2,0,0,0,'','Josh and Laura Enrst'),(92,1,0,0,0,'','Bobby and Emily Broneak'),(93,2,0,0,0,'','Holly Shwewood'),(94,2,0,0,0,'','Justin Delong'),(95,1,0,0,0,'','Jennifer Thompson plus 1'),(98,2,0,0,0,'','Justin Skjelbostad'),(97,1,0,0,0,'','Andrew and Janelle Vick');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guests` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `EmailAddress` varchar(255) NOT NULL,
  `GroupID` int(10) unsigned NOT NULL,
  `HasPlusOne` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES (1,'Marcus','Voth','marcusvoth@yahoo.com',1,0),(2,'Karen','Voth','karenvoth@gmail.com',1,0),(3,'Jon','Voth','jonvoth@gmail.com',2,0),(4,'Jillian','Slater','jillian.audrey@gmail.com',2,0),(5,'Kristy','Ried','',3,1),(6,'Tony','Slater','',4,0),(7,'Jane','Slater','',4,0),(8,'Max','Slater','',5,1),(9,'Roy','Slater','',6,0),(10,'Audrey','Slater','',6,0),(11,'Mary','Morfit','',7,0),(12,'Kathy','Say','',8,0),(13,'Linda','Bergman','',8,0),(14,'Debby','Minell','',9,0),(15,'Dan','Minell','',9,0),(16,'Scott','Say','',10,0),(17,'Krista','Say','',10,0),(18,'Tammy','Klenzman','',12,0),(19,'Kurt','Klenzman','',12,0),(20,'Jenni','Say','',13,0),(21,'Raymudo','Tapia-meza','',13,0),(22,'Mike','Say','',11,0),(23,'Vip','Say','',11,0),(24,'Mickey','Keener','',14,0),(25,'Pat','Keener','',14,0),(26,'Molly','Nelson','',15,0),(27,'Chris','Nelson','',15,0),(28,'Becca','King','',16,0),(29,'Tavis','King','',16,0),(30,'Patty','Pecore','',17,0),(31,'Clay','Pecore','',17,0),(32,'Adam','Pecore','',18,0),(33,'Rose','Pecore','',18,0),(34,'Jason','Pecore','',19,1),(35,'Gordon','Slater','',20,0),(36,'Jan','Slater','',20,0),(37,'Carly','Slater','',0,0),(38,'Frank','Carly','',21,0),(39,'Mark','Slater','',21,0),(40,'Wendy','Slater','',22,0),(41,'Karl','Slater','',22,0),(42,'Nicole','Slater','',22,0),(43,'Danny','Slater','',23,0),(44,'Naomi','Danny','',23,0),(45,'Mary','Laconic','',24,0),(46,'Joe','Laconic','',24,0),(47,'Darcy','Olson','',25,0),(48,'Ole','Olson','',25,0),(49,'Barb','McIntosh','',26,0),(50,'Rob','McIntosh','',26,0),(51,'Cathie','Fischer','',27,0),(52,'Fish','Fischer','',27,0),(53,'Nancy','Hook','',28,1),(54,'Dianne','Thompson','',29,0),(55,'Gary','Thompson','',29,0),(56,'Barb','Auer','',30,0),(57,'Steve','Auer','',30,0),(58,'Laurie','Parker','',31,0),(59,'Greg','Parker','',31,0),(60,'Joan','Demarais','',32,0),(61,'Paul','Friant','',32,0),(62,'Tom','Friant','',33,1),(63,'Emily','Rengo','',34,0),(64,'Matt','Rengo','',34,0),(65,'Laura','Friant','',35,0),(66,'Anton','Friant','',35,0),(67,'Ethel','Kruschke','',36,0),(68,'Peter','Voth','',37,0),(69,'Maria','Voth','',37,0),(70,'Madeleine','Voth','',37,0),(71,'Nicholas','Voth','',37,0),(72,'Tabitha','Voth','',37,0),(73,'Matt','Kroll','',38,0),(74,'Katherine','Kroll','',38,0),(75,'Pete','Voth','',39,1),(76,'Sue','Seitzer','',40,0),(77,'Rosalie','Kohn','',41,0),(78,'Jerry','Kohn','',41,0),(79,'Becky','Voth','',42,0),(80,'Vic','Voth','',43,0),(81,'Sheryl','Voth','',43,0),(82,'Kay','Voth','',44,0),(83,'Dave','Voth','',45,0),(84,'Kristine','Voth','',45,0),(85,'Dan','Voth','',46,0),(86,'Crystal','Voth','',46,0),(87,'Benji','Kohn','',47,0),(88,'Janine','Kohn','',47,0),(89,'Jamie','Kohn','',48,0),(90,'Katie','Langer','',49,0),(91,'Matt','Langer','',49,0),(92,'Calie','Vera','',50,0),(93,'Steve','Vera','',50,0),(94,'Tressa','Lemler','',51,0),(95,'Drew','Lemler','',51,0),(96,'Jess','Organ','',52,0),(97,'Ken','Organ','',52,0),(98,'Mandi','Dupree','',53,0),(99,'Kirby','Dupree','',53,0),(100,'Eric','Voth','',54,0),(101,'Cheryl','Voth','',54,0),(102,'Kristi','Voth','',55,0),(103,'George','Detrick','',56,0),(104,'Pam','Seagle','',56,0),(105,'Todd','Seagle','',56,0),(106,'Cindy','Rollins','',57,1),(107,'Lisa','Bierlein','',58,0),(108,'Chuck','Bierlein','',58,0),(109,'Ken','Poggenburg','',59,0),(110,'Shelia','Poggenburg','',59,0),(111,'Irene','Hansen','',60,0),(112,'Lori','Hansen','',60,0),(113,'Glenda','Bjugstad','',61,0),(114,'Tom','Bjugstad','',61,0),(115,'Esther','Hansen','',62,0),(116,'Brian','Hansen','',61,0),(117,'Alice','Sayles','',63,0),(118,'Wally','Sayles','',63,0),(119,'Brenda','Zahrbock','',63,0),(120,'Dave','Kroll','',64,0),(121,'Sue','Kroll','',64,0),(122,'Jennifer','Calomiris','',65,0),(123,'Warren','Miller','',65,0),(124,'Michael','Datch','',66,0),(125,'Gladys','Datch','',66,0),(126,'Pat','Norine','',67,0),(127,'Sabrina','Skjelbostad','',68,1),(128,'Nicole','Stottlemyre','',69,0),(129,'Eric','Stottlemyre','',69,0),(130,'Jeanna','Passmore','',70,0),(131,'Brad','Passmore','',70,0),(132,'Lori','Barnett','',71,0),(133,'Al','Barnett','',71,0),(134,'Gabe','Watson','',72,0),(135,'Erin','Watson','',72,0),(136,'Mary','Truong','',73,0),(137,'Hao','Truong','',73,0),(138,'Danny','Burke','',74,0),(139,'Lizzy','Burke','',74,0),(140,'Brian','Casey','',75,0),(141,'Nikki','Goergen','',75,0),(142,'Matt','Mons','',76,0),(143,'Molly','Mons','',76,0),(144,'Charlie','Kepke','',77,1),(145,'Shane','Mechelke','',78,0),(146,'Janine','Mechelke','',78,0),(147,'Adam','Charmichael','',79,1),(148,'Ricky','Coles','',80,1),(149,'Draeke','Weseman','',81,0),(150,'Adina','Weseman','',81,0),(151,'Ben','Canine','',82,0),(152,'Tina','Spurr','',82,0),(153,'Seth','Walker','',83,0),(154,'Angela','Dalton','',83,0),(155,'Erin','Ley','',84,0),(156,'Justin','Ley','',84,0),(157,'Tanya','Teske','',85,0),(158,'Garth','Teske','',85,0),(159,'Brian','Driscoll','',86,0),(160,'Vanessa','Driscoll','',86,0),(161,'Jacci','Clark','',87,0),(162,'Kent','Clark','',87,0),(163,'Kelly','Swanson','',88,0),(164,'Joe','Swanson','',88,0),(165,'Natalie','Wagner','',89,0),(166,'Matt','Lewis','',89,0),(167,'Lisa','Holzemer','',90,0),(168,'Adam','Holzemer','',90,0),(169,'Josh','Ernst','',91,0),(170,'Laura','Ernst','',91,0),(171,'Robert','Broneak','',92,0),(172,'Emily','Broneak','',92,0),(173,'Holly','Sherwood','',93,0),(174,'Justin','Delong','',94,0),(175,'Jennifer','Thompson','',95,1),(180,'Janelle','Vick','',97,0),(181,'Andrew','Vick','',97,0),(182,'Justin','Skjelbostad','',98,0);
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-23 12:43:01
