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
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id_order_item` int NOT NULL AUTO_INCREMENT COMMENT 'ID позиции',
  `id_order` int NOT NULL COMMENT 'Ссылка на заказ',
  `id_Product` int NOT NULL COMMENT 'Ссылка на товар',
  `quantity` int DEFAULT '1' COMMENT 'Количество товара в заказе',
  `price_at_order` decimal(10,2) DEFAULT NULL COMMENT 'Цена на момент заказа',
  PRIMARY KEY (`id_order_item`),
  KEY `id_order` (`id_order`),
  KEY `id_Product` (`id_Product`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`id_Product`) REFERENCES `product` (`id_Product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Состав заказа - какие товары и в каком количестве';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,2,45000.00),(2,1,7,1,15000.00),(3,2,9,50,450.00),(4,2,10,10,3500.00),(5,3,4,1,8500.00),(6,3,4,1,35000.00),(7,4,15,3,2200.00),(8,4,16,2,1800.00),(9,5,2,1,28000.00),(10,5,1,1,45000.00),(11,6,8,50,1500.00),(12,7,21,2,7800.00),(13,7,22,5,950.00),(14,8,5,10,12000.00),(15,8,6,5,18000.00),(16,9,17,10,3200.00),(17,9,18,15,1500.00),(18,10,19,10,2100.00),(19,10,20,2,6500.00),(20,11,11,30,380.00),(21,11,12,50,250.00),(22,12,1,5,45000.00),(23,12,7,3,15000.00),(24,12,5,20,12000.00),(26,13,7,1,16500.00),(27,14,2,1,30800.00),(28,14,26,2,2500.00),(29,15,8,5,1500.00),(30,15,27,1,14000.00),(31,16,25,1,24200.00),(32,16,26,1,2500.00),(33,17,4,1,35000.00),(34,17,11,3,380.00),(35,18,5,2,12000.00),(36,18,6,1,18000.00),(37,19,27,2,14000.00),(38,19,26,3,2500.00),(39,20,7,1,16500.00),(40,20,8,10,1500.00),(41,21,1,1,90000.00),(42,21,2,1,30800.00),(43,22,25,2,24200.00),(44,22,27,1,14000.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
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
