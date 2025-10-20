-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: uniapp-wx
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `answer_sheet_id` bigint NOT NULL COMMENT '答卷ID',
  `question_id` bigint NOT NULL COMMENT '题目ID',
  `option_id` bigint DEFAULT NULL COMMENT '选项ID,填空题为空',
  `content` text COMMENT '文本答案内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_sheet` (`answer_sheet_id`),
  KEY `idx_question` (`question_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`answer_sheet_id`) REFERENCES `answer_sheet` (`id`) ON DELETE CASCADE,
  CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='答案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,1,1,2,NULL,'2025-10-20 14:00:10'),(2,1,2,5,NULL,'2025-10-20 14:00:10'),(3,1,2,8,NULL,'2025-10-20 14:00:10'),(4,1,3,NULL,'产品界面设计简洁，易于上手，但希望增加更多高级功能。','2025-10-20 14:00:10'),(5,1,4,NULL,'30','2025-10-20 14:00:10'),(6,2,1,3,NULL,'2025-10-20 14:00:10'),(7,2,2,6,NULL,'2025-10-20 14:00:10'),(8,2,2,7,NULL,'2025-10-20 14:00:10'),(9,2,4,NULL,'25','2025-10-20 14:00:10'),(10,3,5,10,NULL,'2025-10-20 14:00:10'),(11,3,6,13,NULL,'2025-10-20 14:00:10'),(12,3,6,15,NULL,'2025-10-20 14:00:10'),(13,4,1,1,NULL,'2025-10-20 16:11:39'),(14,4,2,5,NULL,'2025-10-20 16:11:39'),(15,4,2,6,NULL,'2025-10-20 16:11:39'),(16,4,2,7,NULL,'2025-10-20 16:11:39'),(17,4,4,NULL,'123','2025-10-20 16:11:39'),(18,5,5,9,NULL,'2025-10-20 16:12:05'),(19,5,6,14,NULL,'2025-10-20 16:12:05'),(20,5,6,15,NULL,'2025-10-20 16:12:05'),(21,6,5,9,NULL,'2025-10-20 16:12:13'),(22,6,6,13,NULL,'2025-10-20 16:12:13'),(23,7,1,1,NULL,'2025-10-20 16:12:33'),(24,7,2,6,NULL,'2025-10-20 16:12:33'),(25,7,2,7,NULL,'2025-10-20 16:12:33'),(26,7,4,NULL,'12','2025-10-20 16:12:33'),(27,8,1,1,NULL,'2025-10-20 16:22:50');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_sheet`
--

DROP TABLE IF EXISTS `answer_sheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_sheet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint NOT NULL COMMENT '问卷ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID,匿名则为空',
  `ip_address` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `submit_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `duration` int DEFAULT NULL COMMENT '答题时长(秒)',
  PRIMARY KEY (`id`),
  KEY `idx_questionnaire` (`questionnaire_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_submit_time` (`submit_time`),
  CONSTRAINT `answer_sheet_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='答卷表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_sheet`
--

LOCK TABLES `answer_sheet` WRITE;
/*!40000 ALTER TABLE `answer_sheet` DISABLE KEYS */;
INSERT INTO `answer_sheet` VALUES (1,1,NULL,'192.168.1.101','2025-10-05 14:30:00',300),(2,1,NULL,'10.0.0.5','2025-10-06 10:15:00',450),(3,2,2,'203.0.113.12','2025-10-20 09:45:00',180),(4,1,3,'0:0:0:0:0:0:0:1','2025-10-20 16:11:39',13),(5,2,3,'0:0:0:0:0:0:0:1','2025-10-20 16:12:05',4),(6,2,3,'0:0:0:0:0:0:0:1','2025-10-20 16:12:13',3),(7,1,3,'0:0:0:0:0:0:0:1','2025-10-20 16:12:33',7),(8,4,NULL,'0:0:0:0:0:0:0:1','2025-10-20 16:22:50',120);
/*!40000 ALTER TABLE `answer_sheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `option`
--

DROP TABLE IF EXISTS `option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `option` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint NOT NULL COMMENT '题目ID',
  `content` varchar(500) NOT NULL COMMENT '选项内容',
  `sort_order` int DEFAULT '0' COMMENT '排序序号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_question` (`question_id`),
  KEY `idx_sort` (`question_id`,`sort_order`),
  CONSTRAINT `option_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='选项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `option`
--

LOCK TABLES `option` WRITE;
/*!40000 ALTER TABLE `option` DISABLE KEYS */;
INSERT INTO `option` VALUES (1,1,'官方网站',1,'2025-10-20 14:00:10'),(2,1,'社交媒体/公众号',2,'2025-10-20 14:00:10'),(3,1,'朋友推荐',3,'2025-10-20 14:00:10'),(4,1,'其他',4,'2025-10-20 14:00:10'),(5,2,'实时通知',1,'2025-10-20 14:00:10'),(6,2,'数据分析报告',2,'2025-10-20 14:00:10'),(7,2,'离线模式',3,'2025-10-20 14:00:10'),(8,2,'个性化推荐',4,'2025-10-20 14:00:10'),(9,5,'非常满意',1,'2025-10-20 14:00:10'),(10,5,'满意',2,'2025-10-20 14:00:10'),(11,5,'一般',3,'2025-10-20 14:00:10'),(12,5,'不满意',4,'2025-10-20 14:00:10'),(13,6,'弹性工作时间',1,'2025-10-20 14:00:10'),(14,6,'健身补贴',2,'2025-10-20 14:00:10'),(15,6,'职业培训',3,'2025-10-20 14:00:10'),(16,7,'满意',1,'2025-10-20 16:20:36'),(17,7,'不满意',2,'2025-10-20 16:20:36');
/*!40000 ALTER TABLE `option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint NOT NULL COMMENT '问卷ID',
  `title` varchar(500) NOT NULL COMMENT '题目标题',
  `type` varchar(20) NOT NULL COMMENT '题目类型:RADIO单选,CHECKBOX多选,TEXT填空,TEXTAREA多行文本',
  `is_required` tinyint DEFAULT '1' COMMENT '是否必填:0否,1是',
  `sort_order` int DEFAULT '0' COMMENT '排序序号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_questionnaire` (`questionnaire_id`),
  KEY `idx_sort` (`questionnaire_id`,`sort_order`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='题目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,'您通常在哪里获取产品信息？','RADIO',1,1,'2025-10-20 14:00:10'),(2,1,'您认为以下哪些功能对您来说是重要的？','CHECKBOX',1,2,'2025-10-20 14:00:10'),(3,1,'请简单描述您对我们产品的整体印象。','TEXTAREA',0,3,'2025-10-20 14:00:10'),(4,1,'您的年龄是？','TEXT',1,4,'2025-10-20 14:00:10'),(5,2,'您对目前的工作环境满意度如何？','RADIO',1,1,'2025-10-20 14:00:10'),(6,2,'您希望公司增加哪些福利？','CHECKBOX',0,2,'2025-10-20 14:00:10'),(7,4,'满意吗？','RADIO',1,1,'2025-10-20 16:20:36');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire`
--

DROP TABLE IF EXISTS `questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL COMMENT '问卷标题',
  `description` text COMMENT '问卷描述',
  `cover_image` varchar(255) DEFAULT NULL COMMENT '封面图',
  `creator_id` bigint NOT NULL COMMENT '创建者ID',
  `status` tinyint DEFAULT '0' COMMENT '状态:0草稿,1发布,2已结束',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `max_answers` int DEFAULT '0' COMMENT '最大答卷数,0表示不限制',
  `answer_count` int DEFAULT '0' COMMENT '已答卷数',
  `is_anonymous` tinyint DEFAULT '1' COMMENT '是否匿名:0否,1是',
  `need_login` tinyint DEFAULT '0' COMMENT '是否需要登录:0否,1是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_creator` (`creator_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='问卷表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,'市场调研问卷','关于新产品功能偏好的市场调研',NULL,3,1,'2025-10-01 09:00:00','2025-11-30 23:59:59',100,4,1,0,'2025-10-20 14:00:10','2025-10-20 15:47:35'),(2,'员工满意度调查','内部员工对公司环境和福利的满意度调查',NULL,3,1,'2025-10-15 08:00:00','2025-10-31 17:00:00',0,3,0,1,'2025-10-20 14:00:10','2025-10-20 15:47:35'),(3,'技术讲座反馈问卷','针对最近一次技术讲座的听众反馈',NULL,3,2,'2025-09-01 09:00:00','2025-09-05 23:59:59',0,0,1,0,'2025-10-20 14:00:10','2025-10-20 15:47:35'),(4,'满意度调查','请填写',NULL,3,1,NULL,NULL,100,1,1,0,'2025-10-20 16:20:36','2025-10-20 16:22:00');
/*!40000 ALTER TABLE `questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_question`
--

DROP TABLE IF EXISTS `tbl_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_question` (
  `uid` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `sex` tinyint DEFAULT NULL COMMENT '性别',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `type` tinyint NOT NULL COMMENT '种类',
  `question` varchar(100) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_question`
--

LOCK TABLES `tbl_question` WRITE;
/*!40000 ALTER TABLE `tbl_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `role` varchar(20) DEFAULT 'USER' COMMENT '角色:USER,ADMIN',
  `status` tinyint DEFAULT '1' COMMENT '状态:0禁用,1启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi','管理员',NULL,NULL,'ADMIN',1,'2025-10-20 10:51:31','2025-10-20 10:51:31'),(2,'user1','$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi','测试用户',NULL,NULL,'USER',1,'2025-10-20 10:51:31','2025-10-20 10:51:31'),(3,'user123','$2a$10$EDKSBHZ5QqYQ7tXeN/HkyeojKgFRFjwCRSeloJsE/B9XMPNQCj08.','',NULL,'','ADMIN',1,'2025-10-20 15:39:20','2025-10-20 15:47:00'),(4,'testuser','$2a$10$nzGIiFVhTN71T/zrD5L6EusYK5hZTSiJMIEdK7lMrT6oaqIwcq.dS','测试用户',NULL,'13800138000','USER',1,'2025-10-20 16:19:02','2025-10-20 16:19:02');
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

-- Dump completed on 2025-10-20 18:46:57
