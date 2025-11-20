-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: warehouse
-- ------------------------------------------------------
-- Server version	8.0.21

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

--
-- Table structure for table `buyers`
--

DROP TABLE IF EXISTS `buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyers` (
  `id_buyers` int NOT NULL AUTO_INCREMENT COMMENT 'ID покупателя',
  `Buyer_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя покупателя',
  `number_buy` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Телефон покупателя',
  `adress_buy` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Адрес доставки',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email покупателя',
  `discount` decimal(5,2) DEFAULT '0.00' COMMENT 'Персональная скидка в процентах',
  PRIMARY KEY (`id_buyers`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='База данных покупателей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyers`
--

LOCK TABLES `buyers` WRITE;
/*!40000 ALTER TABLE `buyers` DISABLE KEYS */;
INSERT INTO `buyers` VALUES (1,'Сидоров Петр Иванович','+79161234567','Москва, ул. Тверская, д. 10, кв. 5','sidorov@mail.ru',5.00),(2,'Козлова Анна Сергеевна','+79162345678','Санкт-Петербург, Невский пр., д. 22, кв. 15','kozlova@gmail.com',3.00),(3,'ООО \"СтройКомплект\"','+79163456789','Казань, ул. Баумана, д. 50, офис 301','stroikomplekt@biz.ru',10.00),(4,'Морозов Игорь Владимирович','+79164567890','Новосибирск, ул. Ленина, д. 33, кв. 88','morozov.iv@yandex.ru',0.00),(5,'Белова Екатерина Дмитриевна','+79165678901','Екатеринбург, ул. 8 Марта, д. 7, кв. 12','belova.ed@mail.ru',7.00),(6,'ИП Кузнецов М.А.','+79166789012','Краснодар, ул. Красная, д. 100','kuznetsov.ma@gmail.com',8.00),(7,'Николаев Дмитрий Петрович','+79167890123','Челябинск, пр. Победы, д. 15, кв. 44','nikolaev@inbox.ru',2.00),(8,'ООО \"ОфисЦентр\"','+79168901234','Омск, ул. Ленина, д. 18, офис 205','office@center.ru',12.00),(9,'Смирнова Ольга Александровна','+79169012345','Ростов-на-Дону, ул. Пушкинская, д. 66, кв. 3','smirnova@mail.ru',4.00),(10,'Васильев Александр Иванович','+79160123456','Уфа, ул. Ленина, д. 25, кв. 77','vasiliev.ai@yandex.ru',6.00),(11,'Федорова Мария Николаевна','+79161234501','Волгоград, ул. Мира, д. 40, кв. 55','fedorova.mn@gmail.com',5.00),(12,'ЗАО \"ТехПром\"','+79162345612','Пермь, ул. Ленина, д. 88, офис 401','teh@prom.ru',15.00);
/*!40000 ALTER TABLE `buyers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-20 12:06:08
