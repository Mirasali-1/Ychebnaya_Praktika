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
-- Table structure for table `operation_logs`
--

DROP TABLE IF EXISTS `operation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_logs` (
  `id_log` int NOT NULL AUTO_INCREMENT COMMENT 'ID записи лога',
  `operation_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Тип операции (INSERT, UPDATE, DELETE)',
  `table_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Таблица, с которой работали',
  `record_id` int DEFAULT NULL COMMENT 'ID записи',
  `id_employee` int DEFAULT NULL COMMENT 'Кто выполнил операцию',
  `operation_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время операции',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Описание операции',
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Журнал операций в системе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_logs`
--

LOCK TABLES `operation_logs` WRITE;
/*!40000 ALTER TABLE `operation_logs` DISABLE KEYS */;
INSERT INTO `operation_logs` VALUES (1,'INSERT','Product',1,8,'2024-10-01 09:00:00','Добавлен новый товар: Ноутбук Lenovo'),(2,'UPDATE','Product',1,1,'2024-10-15 10:00:00','Изменена цена товара ID 1'),(3,'INSERT','Orders',1,2,'2024-11-01 10:30:00','Создан заказ ORD2024001'),(4,'UPDATE','Orders',1,2,'2024-11-02 15:00:00','Статус заказа изменен на \"Доставлен\"'),(5,'INSERT','Buyers',1,10,'2024-10-20 11:30:00','Зарегистрирован новый покупатель'),(6,'DELETE','Product',100,1,'2024-10-25 14:20:00','Удален устаревший товар'),(7,'UPDATE','Product',5,8,'2024-11-05 13:20:00','Изменена цена офисного кресла'),(8,'INSERT','Orders',12,6,'2024-11-16 11:45:00','Создан корпоративный заказ'),(9,'UPDATE','Employees',7,1,'2024-08-22 09:00:00','Принят на работу новый сотрудник'),(10,'SELECT','Orders',NULL,2,'2024-11-17 10:15:00','Просмотр списка заказов за неделю'),(11,'UPDATE','Buyers',3,10,'2024-11-10 12:30:00','Обновлена скидка для постоянного клиента'),(12,'INSERT','Supplier',12,8,'2024-11-01 08:00:00','Добавлен новый поставщик'),(13,'INSERT','Supplier',1,8,'2025-11-23 22:22:56','Редактирован поставщик'),(14,'update','product',14,NULL,'2025-11-28 22:34:59','внимание! резкое изменение цены: 8900.00 → 18900.00'),(15,'update','product',14,NULL,'2025-11-28 22:35:09','внимание! резкое изменение цены: 18900.00 → 8900.00'),(16,'update','product',1,NULL,'2025-11-28 22:38:56','внимание! резкое изменение цены: 54450.00 → 90000.00'),(17,'update','product',2,NULL,'2025-11-28 22:40:47','внимание! резкое изменение цены: 30800.00 → 50800.00'),(18,'update','product',17,NULL,'2025-11-28 22:41:23','внимание! резкое изменение цены: 3200.00 → 33200.00'),(19,'update','product',17,NULL,'2025-11-28 22:41:40','внимание! резкое изменение цены: 33200.00 → 3200.00'),(20,'update','product',1,NULL,'2025-11-28 22:43:45','внимание! резкое изменение цены: 54450.00 → 90000.00'),(21,'update','product',13,NULL,'2025-11-28 22:52:08','внимание! резкое изменение цены: 5500.00 → 25500.00'),(22,'update','product',13,NULL,'2025-11-28 22:52:19','внимание! резкое изменение цены: 25500.00 → 5500.00'),(23,'update','product',25,NULL,'2025-11-29 02:18:50','критично! товар \"Телефон Realme neo 3t\" закончился на складе!'),(24,'delete','order_items',25,NULL,'2025-11-29 02:33:39','товар возвращен на склад: 1 шт. товара id 1');
/*!40000 ALTER TABLE `operation_logs` ENABLE KEYS */;
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
