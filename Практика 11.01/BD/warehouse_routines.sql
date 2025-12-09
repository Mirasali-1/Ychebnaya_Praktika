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
-- Temporary view structure for view `v_supplier_rating`
--

DROP TABLE IF EXISTS `v_supplier_rating`;
/*!50001 DROP VIEW IF EXISTS `v_supplier_rating`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_supplier_rating` AS SELECT 
 1 AS `поставщик`,
 1 AS `рейтинг`,
 1 AS `количество товаров`,
 1 AS `общий остаток`,
 1 AS `средняя цена`,
 1 AS `общая стоимость`,
 1 AS `телефон`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_top_expensive_products`
--

DROP TABLE IF EXISTS `v_top_expensive_products`;
/*!50001 DROP VIEW IF EXISTS `v_top_expensive_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_top_expensive_products` AS SELECT 
 1 AS `товар`,
 1 AS `цена`,
 1 AS `категория`,
 1 AS `поставщик`,
 1 AS `общая стоимость`,
 1 AS `на складе`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_urgent_restock`
--

DROP TABLE IF EXISTS `v_urgent_restock`;
/*!50001 DROP VIEW IF EXISTS `v_urgent_restock`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_urgent_restock` AS SELECT 
 1 AS `товар`,
 1 AS `текущий остаток`,
 1 AS `минимальный остаток`,
 1 AS `нужно заказать`,
 1 AS `поставщик`,
 1 AS `телефон поставщика`,
 1 AS `категория`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_details`
--

DROP TABLE IF EXISTS `v_order_details`;
/*!50001 DROP VIEW IF EXISTS `v_order_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_details` AS SELECT 
 1 AS `код заказа`,
 1 AS `покупатель`,
 1 AS `телефон`,
 1 AS `менеджер`,
 1 AS `дата заказа`,
 1 AS `статус`,
 1 AS `позиций в заказе`,
 1 AS `сумма заказа`,
 1 AS `скидка %`,
 1 AS `итого к оплате`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sales_by_category`
--

DROP TABLE IF EXISTS `v_sales_by_category`;
/*!50001 DROP VIEW IF EXISTS `v_sales_by_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_sales_by_category` AS SELECT 
 1 AS `категория`,
 1 AS `товаров в категории`,
 1 AS `заказов`,
 1 AS `продано единиц`,
 1 AS `общая выручка`,
 1 AS `средняя цена продажи`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_supplier_rating`
--

/*!50001 DROP VIEW IF EXISTS `v_supplier_rating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_supplier_rating` AS select `s`.`Name_sup` AS `поставщик`,`s`.`rating` AS `рейтинг`,count(`p`.`id_Product`) AS `количество товаров`,sum(`p`.`quantity`) AS `общий остаток`,avg(`p`.`price`) AS `средняя цена`,sum((`p`.`price` * `p`.`quantity`)) AS `общая стоимость`,`s`.`number_sup` AS `телефон`,`s`.`email` AS `email` from (`supplier` `s` left join `product` `p` on((`s`.`id_supplier` = `p`.`id_supplier`))) group by `s`.`id_supplier`,`s`.`Name_sup`,`s`.`rating`,`s`.`number_sup`,`s`.`email` order by `s`.`rating` desc,count(`p`.`id_Product`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_top_expensive_products`
--

/*!50001 DROP VIEW IF EXISTS `v_top_expensive_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_top_expensive_products` AS select `p`.`Name_tov` AS `товар`,`p`.`price` AS `цена`,`c`.`name_category` AS `категория`,`s`.`Name_sup` AS `поставщик`,(`p`.`price` * `p`.`quantity`) AS `общая стоимость`,`p`.`quantity` AS `на складе` from ((`product` `p` left join `category` `c` on((`p`.`id_category` = `c`.`id_category`))) left join `supplier` `s` on((`p`.`id_supplier` = `s`.`id_supplier`))) order by `p`.`price` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_urgent_restock`
--

/*!50001 DROP VIEW IF EXISTS `v_urgent_restock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_urgent_restock` AS select `p`.`Name_tov` AS `товар`,`p`.`quantity` AS `текущий остаток`,`p`.`min_stock` AS `минимальный остаток`,(`p`.`min_stock` - `p`.`quantity`) AS `нужно заказать`,`s`.`Name_sup` AS `поставщик`,`s`.`number_sup` AS `телефон поставщика`,`c`.`name_category` AS `категория` from ((`product` `p` left join `supplier` `s` on((`p`.`id_supplier` = `s`.`id_supplier`))) left join `category` `c` on((`p`.`id_category` = `c`.`id_category`))) where (`p`.`quantity` < `p`.`min_stock`) order by (`p`.`min_stock` - `p`.`quantity`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_details`
--

/*!50001 DROP VIEW IF EXISTS `v_order_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_details` AS select `o`.`Code` AS `код заказа`,`b`.`Buyer_name` AS `покупатель`,`b`.`number_buy` AS `телефон`,`e`.`FIO` AS `менеджер`,date_format(`o`.`order_date`,'%d.%m.%y') AS `дата заказа`,`o`.`status` AS `статус`,count(`oi`.`id_order_item`) AS `позиций в заказе`,sum((`oi`.`quantity` * `oi`.`price_at_order`)) AS `сумма заказа`,`b`.`discount` AS `скидка %`,(sum((`oi`.`quantity` * `oi`.`price_at_order`)) * (1 - (coalesce(`b`.`discount`,0) / 100))) AS `итого к оплате` from (((`orders` `o` join `buyers` `b` on((`o`.`id_buyers` = `b`.`id_buyers`))) join `employees` `e` on((`o`.`id_employees` = `e`.`id_employees`))) left join `order_items` `oi` on((`o`.`id_order` = `oi`.`id_order`))) group by `o`.`id_order`,`o`.`Code`,`b`.`Buyer_name`,`b`.`number_buy`,`e`.`FIO`,`o`.`order_date`,`o`.`status`,`b`.`discount` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sales_by_category`
--

/*!50001 DROP VIEW IF EXISTS `v_sales_by_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_sales_by_category` AS select `c`.`name_category` AS `категория`,count(distinct `p`.`id_Product`) AS `товаров в категории`,count(distinct `oi`.`id_order`) AS `заказов`,sum(`oi`.`quantity`) AS `продано единиц`,sum((`oi`.`quantity` * `oi`.`price_at_order`)) AS `общая выручка`,avg(`oi`.`price_at_order`) AS `средняя цена продажи` from ((`category` `c` left join `product` `p` on((`c`.`id_category` = `p`.`id_category`))) left join `order_items` `oi` on((`p`.`id_Product` = `oi`.`id_Product`))) group by `c`.`id_category`,`c`.`name_category` order by sum((`oi`.`quantity` * `oi`.`price_at_order`)) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
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
