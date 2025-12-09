-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: warehouse
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'ffe63c2d-c6f2-11f0-8c41-00ff3de45216:1-172';

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id_employees` int NOT NULL AUTO_INCREMENT COMMENT 'ID сотрудника',
  `FIO` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ФИО сотрудника',
  `experience` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Стаж работы',
  `number_emp` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Рабочий телефон',
  `id_position` int DEFAULT NULL COMMENT 'Ссылка на должность',
  `hire_date` date DEFAULT NULL COMMENT 'Дата приема на работу',
  PRIMARY KEY (`id_employees`),
  KEY `id_position` (`id_position`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`id_position`) REFERENCES `position` (`id_position`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Сотрудники компании';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Петров Сергей Владимирович','5 лет','+74951111111',5,'2019-03-15'),(2,'Иванова Марина Александровна','3 года','+74952222222',1,'2021-06-01'),(3,'Смирнов Андрей Петрович','7 лет','+74953333333',2,'2017-09-10'),(4,'Кузнецова Елена Игоревна','4 года','+74954444444',4,'2020-02-20'),(5,'Соколов Михаил Дмитриевич','2 года','+74955555555',3,'2022-05-12'),(6,'Морозова Анастасия Сергеевна','6 лет','+74956666666',1,'2018-11-05'),(7,'Новиков Дмитрий Александрович','1 год','+74957777777',6,'2023-08-22'),(8,'Федорова Ольга Владимировна','8 лет','+74958888888',7,'2016-04-18'),(9,'Волков Алексей Иванович','3 года','+74959999999',9,'2021-10-30'),(10,'Павлова Светлана Николаевна','4 года','+74950000000',8,'2020-07-14'),(11,'Козлов Николай Петрович','5 лет','+74951010101',10,'2019-01-25'),(12,'Зайцева Виктория Дмитриевна','2 года','+74952020202',1,'2022-03-08');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-10  0:42:21
