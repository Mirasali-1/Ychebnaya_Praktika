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
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id_Product` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID товара',
  `Name_tov` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название товара',
  `price` decimal(10,2) NOT NULL COMMENT 'Цена за единицу товара',
  `quantity` int DEFAULT '0' COMMENT 'Количество на складе',
  `id_supplier` int DEFAULT NULL COMMENT 'Ссылка на поставщика',
  `id_category` int DEFAULT NULL COMMENT 'Ссылка на категорию товара',
  `min_stock` int DEFAULT '10' COMMENT 'Минимальный остаток для оповещения',
  PRIMARY KEY (`id_Product`),
  KEY `id_supplier` (`id_supplier`),
  KEY `id_category` (`id_category`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Товары на складе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Ноутбук Lenovo IdeaPad',49500.00,25,1,1,5),(2,'Смартфон Samsung Galaxy A52',30800.00,40,1,1,10),(4,'Холодильник Samsung',35000.00,12,2,2,3),(5,'Офисное кресло Comfort Pro',12000.00,30,3,3,8),(6,'Письменный стол Монако',18000.00,20,3,3,5),(7,'Принтер HP LaserJet',16500.00,18,4,1,5),(8,'Набор ручек Parker 10шт',1500.00,100,4,4,20),(9,'Цемент М500 (мешок 50кг)',450.00,200,5,5,50),(10,'Кирпич красный (поддон)',3500.00,80,5,5,20),(11,'Кофе Jacobs Monarch 250г',380.00,150,6,6,30),(12,'Чай Greenfield 100пак',250.00,200,1,6,40),(13,'Джинсы мужские Levi\'s',5500.00,45,7,7,15),(14,'Кроссовки Nike Air Max',8900.00,35,7,7,10),(15,'Футбольный мяч Adidas',2200.00,50,8,8,15),(16,'Гантели 5кг (пара)',1800.00,40,8,8,10),(17,'Конструктор LEGO Classic',3200.00,60,9,9,20),(18,'Кукла Barbie',1500.00,70,9,9,25),(19,'Моторное масло 5W-40 4л',2100.00,90,10,10,30),(20,'Автомобильный аккумулятор',6500.00,25,10,10,8),(21,'Дрель электрическая Bosch',7800.00,22,11,11,5),(22,'Набор отверток 12шт',950.00,80,11,11,20),(23,'Лопата штыковая',850.00,45,12,12,15),(24,'Грабли садовые',650.00,50,12,12,15),(25,'Телефон Realme neo 3t',24200.00,1,NULL,1,10);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
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
