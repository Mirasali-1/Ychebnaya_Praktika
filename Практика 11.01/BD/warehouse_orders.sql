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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id_order` int NOT NULL AUTO_INCREMENT COMMENT 'ID заказа',
  `Code` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Уникальный код заказа',
  `id_employees` int DEFAULT NULL COMMENT 'Ответственный сотрудник',
  `id_buyers` int DEFAULT NULL COMMENT 'Покупатель',
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания заказа',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'В обработке' COMMENT 'Статус заказа',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Дополнительная информация',
  PRIMARY KEY (`id_order`),
  UNIQUE KEY `Code` (`Code`),
  KEY `id_employees` (`id_employees`),
  KEY `id_buyers` (`id_buyers`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_employees`) REFERENCES `employees` (`id_employees`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id_buyers`) REFERENCES `buyers` (`id_buyers`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Заказы клиентов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORD2024001',2,1,'2024-11-01 10:30:00','Доставлен','Заказ на офисную технику'),(2,'ORD2024002',2,3,'2024-11-02 14:15:00','Доставлен','Крупный заказ стройматериалов'),(3,'ORD2024003',6,2,'2024-11-03 09:45:00','Отправлен','Товары для дома'),(4,'ORD2024004',12,4,'2024-11-05 16:20:00','Подтвержден','Спортивные товары'),(5,'ORD2024005',2,5,'2024-11-06 11:00:00','В обработке','Электроника'),(6,'ORD2024006',6,6,'2024-11-07 13:30:00','Подтвержден','Оптовая закупка канцелярии'),(7,'ORD2024007',12,7,'2024-11-08 10:15:00','Отправлен','Инструменты'),(8,'ORD2024008',2,8,'2024-11-10 15:45:00','Доставлен','Мебель для офиса'),(9,'ORD2024009',6,9,'2024-11-12 12:20:00','В обработке','Игрушки'),(10,'ORD2024010',12,10,'2024-11-14 09:00:00','Подтвержден','Автотовары'),(11,'ORD2024011',2,11,'2024-11-15 14:30:00','В обработке','Продукты питания'),(12,'ORD2024012',6,12,'2024-11-16 11:45:00','Подтвержден','Крупный корпоративный заказ');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
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
