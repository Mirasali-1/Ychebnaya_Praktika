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
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id_supplier` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор поставщика',
  `Name_sup` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название компании поставщика',
  `adress_sup` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Адрес поставщика',
  `number_sup` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Контактный телефон',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email для связи',
  `rating` decimal(3,2) DEFAULT '5.00' COMMENT 'Рейтинг поставщика от 0 до 10',
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Справочник поставщиков товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'ООО \"ТехноСнаб\"','Москва, ул. Ленина, д. 15','+74951234567','info@tehnosnab.ru',8.50),(2,'ЗАО \"МетроОпт\"','Санкт-Петербург, пр. Невский, д. 88','+78123456789','sales@metroopt.ru',9.20),(3,'ИП Иванов А.С.','Казань, ул. Баумана, д. 44','+78432567890','ivanov@mail.ru',7.80),(4,'ООО \"ГлобалТрейд\"','Новосибирск, ул. Красный проспект, д. 12','+73832345678','contact@globaltrade.ru',8.90),(5,'Компания \"Восток-Запад\"','Екатеринбург, ул. Малышева, д. 33','+73432456789','vostok@west.ru',8.00),(6,'ООО \"СтройМатериалы+\"','Краснодар, ул. Красная, д. 77','+78612678901','stroi@materials.ru',7.50),(7,'ЗАО \"ПродТорг\"','Челябинск, пр. Ленина, д. 55','+73512789012','prod@torg.ru',8.30),(8,'ИП Петров С.Н.','Омск, ул. Маркса, д. 21','+73812890123','petrov.sn@yandex.ru',7.20),(9,'ООО \"МегаПоставка\"','Ростов-на-Дону, ул. Большая Садовая, д. 99','+78632901234','mega@postavka.com',9.00),(10,'Компания \"Альфа-Дистрибуция\"','Уфа, ул. Ленина, д. 11','+73472012345','alfa@distrib.ru',8.70),(11,'ООО \"БизнесЛайн\"','Волгоград, пр. Ленина, д. 66','+78442123456','business@line.ru',7.90),(12,'ЗАО \"Партнер Групп\"','Пермь, ул. Комсомольский проспект, д. 45','+73422234567','partner@group.ru',8.40),(13,'ООО \"НовыйПоставщик\"','Москва, ул. Новая, д. 1','+79991234567','new@supplier.ru',7.50);
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
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
