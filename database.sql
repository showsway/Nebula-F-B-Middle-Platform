-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: sky_take_out
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `address_book`
--

DROP TABLE IF EXISTS `address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='地址簿';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_book`
--

LOCK TABLES `address_book` WRITE;
/*!40000 ALTER TABLE `address_book` DISABLE KEYS */;
INSERT INTO `address_book` VALUES (3,4,'91邰先僧','0','18333126609','32','江苏省','3201','南京市','320111','浦口区','超级无敌大地方3楼601','3',1);
/*!40000 ALTER TABLE `address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `status` int DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品及套餐分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (11,1,'酒水饮料',10,1,'2022-06-09 22:09:18','2022-06-09 22:09:18',1,1),(12,1,'传统主食',9,1,'2022-06-09 22:09:32','2022-06-09 22:18:53',1,1),(13,2,'人气套餐',12,1,'2022-06-09 22:11:38','2022-06-10 11:04:40',1,1),(15,2,'商务套餐',13,1,'2022-06-09 22:14:10','2022-06-10 11:04:48',1,1),(16,1,'蜀味烤鱼',4,1,'2022-06-09 22:15:37','2025-03-31 21:07:50',1,1),(17,1,'蜀味牛蛙',5,1,'2022-06-09 22:16:14','2025-03-31 21:07:51',1,1),(18,1,'特色蒸菜',6,1,'2022-06-09 22:17:42','2022-06-09 22:17:42',1,1),(19,1,'新鲜时蔬',7,1,'2022-06-09 22:18:12','2022-06-09 22:18:28',1,1),(20,1,'水煮鱼',8,1,'2022-06-09 22:22:29','2022-06-09 22:23:45',1,1),(21,1,'汤类',11,1,'2022-06-10 10:51:47','2022-06-10 10:51:47',1,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish`
--

DROP TABLE IF EXISTS `dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `status` int DEFAULT '1' COMMENT '0 停售 1 起售',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dish_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish`
--

LOCK TABLES `dish` WRITE;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
INSERT INTO `dish` VALUES (46,'王老吉',11,6.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/34adc7fb-79e0-4ec2-8494-cea37ca432e5.png','',1,'2022-06-09 22:40:47','2025-04-03 20:10:47',1,1),(47,'北冰洋',11,4.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/9ee5df66-3297-4d48-8962-291de8dfb0de.png','还是小时候的味道',1,'2022-06-10 09:18:49','2025-04-03 20:10:39',1,1),(48,'雪花啤酒',11,4.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/45f55282-30d6-47df-915c-a0d5ef8379f4.png','',1,'2022-06-10 09:22:54','2025-04-03 20:10:33',1,1),(49,'米饭',12,2.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/7488ccdc-2496-448b-af82-fe4d6a4a6913.png','精选五常大米',1,'2022-06-10 09:30:17','2025-04-03 20:10:25',1,1),(50,'馒头',12,1.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/48a78c32-a7b3-44b6-8277-19a3d7f8ab8d.png','优质面粉',1,'2022-06-10 09:34:28','2025-04-03 20:10:17',1,1),(51,'老坛酸菜鱼',20,56.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/f37ff902-ff87-4c95-aab3-fe3fdb6f7a2a.png','原料：汤，草鱼，酸菜',1,'2022-06-10 09:40:51','2025-04-03 20:09:59',1,1),(52,'经典酸菜鮰鱼',20,66.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/8f1522f9-8d91-4203-8fec-a9fc536ee391.png','原料：酸菜，江团，鮰鱼',1,'2022-06-10 09:46:02','2025-04-03 20:09:37',1,1),(53,'蜀味水煮草鱼',20,38.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/3131de99-4a68-46b6-9fd3-477d2b7004a5.png','原料：草鱼，汤',1,'2022-06-10 09:48:37','2025-04-03 20:09:28',1,1),(54,'清炒小油菜',19,18.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/40ec3b3f-8192-44e6-bab1-f7fdc71ffe84.png','原料：小油菜',1,'2022-06-10 09:51:46','2025-04-03 20:09:18',1,1),(55,'蒜蓉娃娃菜',19,18.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/287406c0-3a19-4475-ba0c-f0cfdeaef74a.png','原料：蒜，娃娃菜',1,'2022-06-10 09:53:37','2025-04-03 20:09:06',1,1),(56,'清炒西兰花',19,18.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/3f75742c-ce2e-4fbc-bdc3-aeb7a3d9231f.png','原料：西兰花',1,'2022-06-10 09:55:44','2025-04-03 20:08:55',1,1),(57,'炝炒圆白菜',19,18.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/a1053592-ce35-4b49-b73f-72b9652daed3.png','原料：圆白菜',1,'2022-06-10 09:58:35','2025-04-03 20:08:44',1,1),(58,'清蒸鲈鱼',18,98.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/26dc942e-517f-4be1-9046-6ea9cbfe883a.png','原料：鲈鱼',1,'2022-06-10 10:12:28','2025-04-03 20:08:24',1,1),(59,'东坡肘子',18,138.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/af01c7f6-c96f-44a7-ab81-fce35b7a3d03.png','原料：猪肘棒',1,'2022-06-10 10:24:03','2025-04-03 20:08:13',1,1),(60,'梅菜扣肉',18,58.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/39dd9dff-8dbb-4b43-8eaf-4679a4007ec4.png','原料：猪肉，梅菜',1,'2022-06-10 10:26:03','2025-04-03 20:08:03',1,1),(61,'剁椒鱼头',18,66.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/34ad766e-6fd9-4542-bea1-e2f7a5626386.png','原料：鲢鱼，剁椒',1,'2022-06-10 10:28:54','2025-04-03 20:07:52',1,1),(62,'金汤酸菜牛蛙',17,88.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/35d351b8-4ffd-4db0-a29f-1a78d6eb54bf.png','原料：鲜活牛蛙，酸菜',1,'2022-06-10 10:33:05','2025-04-03 20:07:43',1,1),(63,'香锅牛蛙',17,88.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/33e5f8c0-0e78-4a82-acbe-1653a2c2b11b.png','配料：鲜活牛蛙，莲藕，青笋',1,'2022-06-10 10:35:40','2025-04-03 20:07:29',1,1),(64,'馋嘴牛蛙',17,88.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/f5344df9-620d-4881-a7ea-6800f61295d5.png','配料：鲜活牛蛙，丝瓜，黄豆芽',1,'2022-06-10 10:37:52','2025-04-03 20:07:12',1,1),(65,'草鱼2斤',16,68.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/4340aefe-6bf9-454e-9fd1-e36466566f52.png','原料：草鱼，黄豆芽，莲藕',1,'2022-06-10 10:41:08','2025-04-03 20:06:53',1,1),(66,'江团鱼2斤',16,119.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/db12319d-1098-4139-98b2-778928dca481.png','配料：江团鱼，黄豆芽，莲藕',1,'2022-06-10 10:42:42','2025-04-03 20:06:43',1,1),(67,'鮰鱼2斤',16,72.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/1dfbb054-0059-4b2b-adc9-7fec6b80fe6a.png','原料：鮰鱼，黄豆芽，莲藕',1,'2022-06-10 10:43:56','2025-04-03 20:06:34',1,1),(68,'鸡蛋汤',21,4.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/44ab37ef-8326-4a2d-a60c-5785574acaae.png','配料：鸡蛋，紫菜',1,'2022-06-10 10:54:25','2025-04-03 20:06:20',1,1),(69,'平菇豆腐汤nb',21,10.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/6bed1e07-3f8f-4733-86db-76b816ccf955.png','配料：豆腐，平菇',1,'2022-06-10 10:55:02','2025-03-31 21:07:53',1,1),(75,'测试菜品',19,66.00,'https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/48e3d5b0-8900-4a00-a378-f09df3f7d2d6.png','',1,'2025-04-04 11:18:20','2025-04-04 11:18:28',1,1);
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish_flavor`
--

DROP TABLE IF EXISTS `dish_flavor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='菜品口味关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish_flavor`
--

LOCK TABLES `dish_flavor` WRITE;
/*!40000 ALTER TABLE `dish_flavor` DISABLE KEYS */;
INSERT INTO `dish_flavor` VALUES (40,10,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(41,7,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(42,7,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(45,6,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(46,6,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(47,5,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(48,5,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(49,2,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(50,4,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(51,3,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]'),(52,3,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(112,69,'温度','[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]'),(113,69,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(114,67,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(115,66,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(116,65,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(117,60,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(118,57,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(119,56,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(120,54,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\"]'),(121,53,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(122,53,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(123,52,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(124,52,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(127,51,'忌口','[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]'),(128,51,'辣度','[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]'),(129,75,'甜味','[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
/*!40000 ALTER TABLE `dish_flavor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='员工信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'管理员','admin','e10adc3949ba59abbe56e057f20f883e','13812312312','1','110101199001010047',1,'2022-02-15 15:51:20','2022-02-17 09:16:20',10,1),(2,'张三','zhangsan','e10adc3949ba59abbe56e057f20f883e','17761617512','1','360123200000016666',1,'2025-03-27 20:54:29','2025-03-31 20:27:19',10,1),(23,'李七','liqi','e10adc3949ba59abbe56e057f20f883e','17761617513','0','360123200000016667',1,'2025-03-29 11:09:57','2025-03-31 11:10:25',1,1);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '名字',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='订单明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (5,'鸡蛋汤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/44ab37ef-8326-4a2d-a60c-5785574acaae.png',4,68,NULL,NULL,1,4.00),(6,'无敌套餐','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/da6df95f-954c-48f9-bd47-87a27fac51d8.png',4,NULL,33,NULL,1,300.00),(7,'江团鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/db12319d-1098-4139-98b2-778928dca481.png',5,66,NULL,'不辣',1,119.00),(8,'北冰洋','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/9ee5df66-3297-4d48-8962-291de8dfb0de.png',5,47,NULL,NULL,1,4.00),(9,'超级套餐','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/0b8e6953-f513-4c59-9e11-bc8be35ff949.png',5,NULL,34,NULL,1,100.00),(10,'蒜蓉娃娃菜','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/287406c0-3a19-4475-ba0c-f0cfdeaef74a.png',6,55,NULL,NULL,2,18.00),(11,'清炒西兰花','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/3f75742c-ce2e-4fbc-bdc3-aeb7a3d9231f.png',6,56,NULL,'不要葱',1,18.00),(12,'测试菜品','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/48e3d5b0-8900-4a00-a378-f09df3f7d2d6.png',6,75,NULL,'多糖',1,66.00),(13,'草鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/4340aefe-6bf9-454e-9fd1-e36466566f52.png',7,65,NULL,'中辣',1,68.00),(14,'江团鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/db12319d-1098-4139-98b2-778928dca481.png',7,66,NULL,'重辣',2,119.00),(15,'鸡蛋汤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/44ab37ef-8326-4a2d-a60c-5785574acaae.png',8,68,NULL,NULL,1,4.00),(16,'无敌套餐','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/da6df95f-954c-48f9-bd47-87a27fac51d8.png',8,NULL,33,NULL,1,300.00),(17,'蒜蓉娃娃菜','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/287406c0-3a19-4475-ba0c-f0cfdeaef74a.png',9,55,NULL,NULL,2,18.00),(18,'清炒西兰花','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/3f75742c-ce2e-4fbc-bdc3-aeb7a3d9231f.png',9,56,NULL,'不要葱',1,18.00),(19,'测试菜品','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/48e3d5b0-8900-4a00-a378-f09df3f7d2d6.png',9,75,NULL,'多糖',1,66.00),(20,'江团鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/db12319d-1098-4139-98b2-778928dca481.png',10,66,NULL,'重辣',1,119.00),(21,'草鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/4340aefe-6bf9-454e-9fd1-e36466566f52.png',11,65,NULL,'中辣',1,68.00),(22,'江团鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/db12319d-1098-4139-98b2-778928dca481.png',11,66,NULL,'重辣',2,119.00),(23,'草鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/4340aefe-6bf9-454e-9fd1-e36466566f52.png',12,65,NULL,'中辣',1,68.00),(24,'江团鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/db12319d-1098-4139-98b2-778928dca481.png',12,66,NULL,'重辣',2,119.00),(25,'草鱼2斤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/4340aefe-6bf9-454e-9fd1-e36466566f52.png',13,65,NULL,'重辣',1,68.00),(26,'米饭','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/7488ccdc-2496-448b-af82-fe4d6a4a6913.png',14,49,NULL,NULL,3,2.00),(27,'蒜蓉娃娃菜','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/287406c0-3a19-4475-ba0c-f0cfdeaef74a.png',15,55,NULL,NULL,2,18.00),(28,'清炒西兰花','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/3f75742c-ce2e-4fbc-bdc3-aeb7a3d9231f.png',15,56,NULL,'不要葱',1,18.00),(29,'测试菜品','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/48e3d5b0-8900-4a00-a378-f09df3f7d2d6.png',15,75,NULL,'多糖',1,66.00),(30,'东坡肘子','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/af01c7f6-c96f-44a7-ab81-fce35b7a3d03.png',16,59,NULL,NULL,1,138.00),(31,'北冰洋','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/9ee5df66-3297-4d48-8962-291de8dfb0de.png',16,47,NULL,NULL,1,4.00),(32,'雪花啤酒','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/45f55282-30d6-47df-915c-a0d5ef8379f4.png',16,48,NULL,NULL,1,4.00),(33,'鸡蛋汤','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/44ab37ef-8326-4a2d-a60c-5785574acaae.png',16,68,NULL,NULL,1,4.00),(34,'平菇豆腐汤nb','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/6bed1e07-3f8f-4733-86db-76b816ccf955.png',16,69,NULL,'热饮,不要香菜',1,10.00),(35,'无敌套餐','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/da6df95f-954c-48f9-bd47-87a27fac51d8.png',16,NULL,33,NULL,1,300.00);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int DEFAULT NULL COMMENT '打包费',
  `tableware_number` int DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (4,'1743841078832',5,4,3,'2025-04-05 16:17:59',NULL,1,0,312.00,'无敌真寂寞','18333126609',NULL,NULL,'91邰先僧','订单超时，自动取消',NULL,'2025-04-06 16:06:00','2025-04-05 17:17:00',0,NULL,2,0,0),(5,'1743841688141',6,4,3,'2025-04-05 16:28:08',NULL,1,0,232.00,'','18333126609',NULL,NULL,'91邰先僧','菜品已销售完，暂时无法接单',NULL,'2025-04-06 11:52:47','2025-04-05 17:28:00',0,NULL,3,0,0),(6,'1743849173428',6,4,3,'2025-04-05 18:32:53','2025-04-05 18:32:56',1,2,130.00,'','18333126609',NULL,NULL,'91邰先僧','订单量较多，暂时无法接单',NULL,'2025-04-06 11:57:35','2025-04-05 19:32:00',0,'2025-04-06 11:57:31',4,0,0),(7,'1743862189670',6,4,3,'2025-04-05 22:09:50','2025-04-05 22:09:51',1,2,315.00,'','18333126609',NULL,NULL,'91邰先僧','用户取消',NULL,'2025-04-05 23:22:41','2025-04-05 23:09:00',0,NULL,3,0,0),(8,'1743911257004',6,4,3,'2025-04-06 11:47:37','2025-04-06 11:47:39',1,2,312.00,'','18333126609',NULL,NULL,'91邰先僧',NULL,'订单量较多，暂时无法接单','2025-04-06 11:47:59','2025-04-06 12:47:00',0,NULL,2,0,0),(9,'1743912566162',5,4,3,'2025-04-06 12:09:26','2025-04-06 12:09:28',1,1,130.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-06 13:09:00',0,NULL,4,0,0),(10,'1743930094583',5,4,3,'2025-04-06 17:01:35','2025-04-06 17:01:36',1,1,126.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-06 18:01:00',0,NULL,1,0,0),(11,'1743930395549',5,4,3,'2025-04-06 17:06:36','2025-04-06 17:06:37',1,1,315.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-06 18:06:00',0,NULL,3,0,0),(12,'1743930624172',5,4,3,'2025-04-06 17:10:24','2025-04-06 17:10:26',1,1,315.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-06 18:10:00',0,NULL,3,0,0),(13,'1743930652776',2,4,3,'2025-04-06 17:10:53','2025-04-06 17:10:54',1,1,75.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-06 18:10:00',0,NULL,1,0,0),(14,'1743930675407',2,4,3,'2025-04-06 17:11:15','2025-04-06 17:11:17',1,1,15.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-06 18:11:00',0,NULL,3,0,0),(15,'1743931621222',2,4,3,'2025-04-06 17:27:01','2025-04-06 17:27:02',1,1,130.00,'','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-07 18:27:00',0,NULL,4,0,0),(16,'1744011672328',5,4,3,'2025-04-07 15:41:12','2025-04-07 15:41:14',1,1,472.00,'LOVE U BABY','18333126609','超级无敌大地方3楼601',NULL,'91邰先僧',NULL,NULL,NULL,'2025-04-07 16:41:00',0,'2025-04-07 15:41:40',6,0,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setmeal`
--

DROP TABLE IF EXISTS `setmeal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setmeal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `status` int DEFAULT '1' COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_setmeal_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='套餐';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setmeal`
--

LOCK TABLES `setmeal` WRITE;
/*!40000 ALTER TABLE `setmeal` DISABLE KEYS */;
INSERT INTO `setmeal` VALUES (33,13,'无敌套餐',300.00,1,'无敌之','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/da6df95f-954c-48f9-bd47-87a27fac51d8.png','2025-04-01 11:29:55','2025-04-01 17:01:58',1,1),(34,15,'超级套餐',100.00,1,'','https://sky-take-out-show.oss-cn-shanghai.aliyuncs.com/0b8e6953-f513-4c59-9e11-bc8be35ff949.png','2025-04-04 13:57:19','2025-04-04 13:58:25',1,1);
/*!40000 ALTER TABLE `setmeal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setmeal_dish`
--

DROP TABLE IF EXISTS `setmeal_dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setmeal_dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='套餐菜品关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setmeal_dish`
--

LOCK TABLES `setmeal_dish` WRITE;
/*!40000 ALTER TABLE `setmeal_dish` DISABLE KEYS */;
INSERT INTO `setmeal_dish` VALUES (64,33,49,'米饭',2.00,3),(65,33,55,'蒜蓉娃娃菜',18.00,1),(66,33,56,'清炒西兰花',18.00,1),(67,33,66,'江团鱼2斤',119.00,1),(72,34,65,'草鱼2斤',68.00,1),(73,34,60,'梅菜扣肉',58.00,1),(74,34,50,'馒头',1.00,1),(75,34,68,'鸡蛋汤',4.00,1);
/*!40000 ALTER TABLE `setmeal_dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='购物车';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'oy6YF7M3Wti7qhs6HBymYvQepBNw',NULL,NULL,NULL,NULL,NULL,'2025-04-03 12:59:34');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08 15:21:17
