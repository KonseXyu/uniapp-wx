-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: insurance_match
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
-- Table structure for table `company_basic`
--

DROP TABLE IF EXISTS `company_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_basic` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '企业ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `company_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业名称',
  `primary_phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主要联系电话',
  `backup_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备用联系电话',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `primary_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主要联系人',
  `backup_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备用联系人',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_company_name` (`company_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业基本信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_basic`
--

LOCK TABLES `company_basic` WRITE;
/*!40000 ALTER TABLE `company_basic` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_detail`
--

DROP TABLE IF EXISTS `company_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详细信息ID',
  `company_id` bigint NOT NULL COMMENT '企业ID',
  `industry` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属行业',
  `main_assets` text COLLATE utf8mb4_unicode_ci COMMENT '主要资产（多选，逗号分隔）',
  `established_years` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '成立年限',
  `employee_count` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '员工总数',
  `annual_revenue` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '年营业额',
  `registered_capital` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '注册资本金',
  `special_equipment` text COLLATE utf8mb4_unicode_ci COMMENT '特殊设备或场景（多选，逗号分隔）',
  `has_import_export` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否涉及进出口贸易',
  `purchased_insurance` text COLLATE utf8mb4_unicode_ci COMMENT '已购买的保险类型（多选，逗号分隔）',
  `risk_coverage` text COLLATE utf8mb4_unicode_ci COMMENT '希望覆盖的风险（多选，逗号分隔）',
  `potential_risk` text COLLATE utf8mb4_unicode_ci COMMENT '希望覆盖的潜在风险（多选，逗号分隔）',
  `risk_transfer` text COLLATE utf8mb4_unicode_ci COMMENT '希望转移的风险责任（多选，逗号分隔）',
  `annual_budget` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '年度保险费用预算',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_detail`
--

LOCK TABLES `company_detail` WRITE;
/*!40000 ALTER TABLE `company_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance_product`
--

DROP TABLE IF EXISTS `insurance_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '保险产品ID',
  `company_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '保险公司名称',
  `company_contact_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保险公司联系人姓名',
  `company_contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保险公司联系电话',
  `company_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保险公司地址',
  `insurance_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '保险名称',
  `insurance_contact_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保险联系人姓名',
  `insurance_contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保险联系人电话',
  `insurance_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '保险种类',
  `target_industry` text COLLATE utf8mb4_unicode_ci COMMENT '目标行业（多选，逗号分隔）',
  `target_years` text COLLATE utf8mb4_unicode_ci COMMENT '目标成立年限（多选，逗号分隔）',
  `target_employees` text COLLATE utf8mb4_unicode_ci COMMENT '目标员工总数（多选，逗号分隔）',
  `target_revenue` text COLLATE utf8mb4_unicode_ci COMMENT '目标年营业额（多选，逗号分隔）',
  `target_capital` text COLLATE utf8mb4_unicode_ci COMMENT '目标注册资本金（多选，逗号分隔）',
  `target_assets` text COLLATE utf8mb4_unicode_ci COMMENT '目标主要资产（多选，逗号分隔）',
  `target_equipment` text COLLATE utf8mb4_unicode_ci COMMENT '目标特殊设备或场景（多选，逗号分隔）',
  `target_import_export` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否涉及进出口贸易',
  `covered_insurance_types` text COLLATE utf8mb4_unicode_ci COMMENT '已购买的保险类型（多选，逗号分隔）',
  `covered_risks` text COLLATE utf8mb4_unicode_ci COMMENT '覆盖的风险（多选，逗号分隔）',
  `covered_potential_risks` text COLLATE utf8mb4_unicode_ci COMMENT '覆盖的潜在风险（多选，逗号分隔）',
  `risk_transfer_types` text COLLATE utf8mb4_unicode_ci COMMENT '能转移的风险责任（多选，逗号分隔）',
  `annual_fee` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '年度保险费用',
  `other_notes` text COLLATE utf8mb4_unicode_ci COMMENT '其他说明',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_insurance_type` (`insurance_type`),
  KEY `idx_company_name` (`company_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='保险产品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance_product`
--

LOCK TABLES `insurance_product` WRITE;
/*!40000 ALTER TABLE `insurance_product` DISABLE KEYS */;
INSERT INTO `insurance_product` VALUES (1,'中国人保财险','张经理','13800138000','北京市朝阳区建国门外大街2号','企业财产综合险','李顾问','13900139000','财产保险','制造业,建筑业,批发和零售业','3-5年,5-10年,10年以上','50-100人,100-300人,300-500人','1000万-5000万,5000万-1亿,1亿以上','100万-500万,500万-1000万,1000万以上','房屋建筑,机器设备,存货商品','无,其他','否','财产保险,责任保险','火灾,爆炸,雷击,台风,暴雨,洪水','设备损坏,停工停产,盗窃','财产损失,营业中断损失','5万-10万','适合中型制造企业','2025-10-21 11:50:00','2025-10-21 11:50:00'),(2,'平安保险','王经理','13700137000','深圳市福田区益田路5033号','雇主责任保险','赵顾问','13600136000','责任保险','制造业,建筑业,交通运输、仓储和邮政业','1-3年,3-5年,5-10年','10-50人,50-100人,100-300人','500万-1000万,1000万-5000万','50万-100万,100万-500万','机器设备,运输工具','锅炉,压力容器,起重机械,叉车','否','雇主责任险,团体意外险','火灾,爆炸','员工伤亡,第三方责任','雇主责任','1万-5万','覆盖员工工伤意外','2025-10-21 11:50:00','2025-10-21 11:50:00'),(3,'太平洋保险','刘经理','13500135000','上海市黄浦区中山南路1号','货物运输保险','陈顾问','13400134000','货运保险','批发和零售业,交通运输、仓储和邮政业','1-3年,3-5年','10-50人,50-100人','100万-500万,500万-1000万,1000万-5000万','50万-100万,100万-500万','存货商品,运输工具','无','是','货运保险','火灾,盗窃,抢劫','货物损失','财产损失','1万以下','适合进出口贸易企业','2025-10-21 11:50:00','2025-10-21 11:50:00');
/*!40000 ALTER TABLE `insurance_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_record`
--

DROP TABLE IF EXISTS `match_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '匹配记录ID',
  `company_id` bigint NOT NULL COMMENT '企业ID',
  `insurance_id` bigint NOT NULL COMMENT '保险产品ID',
  `match_score` decimal(5,2) NOT NULL COMMENT '匹配分数',
  `match_reason` text COLLATE utf8mb4_unicode_ci COMMENT '匹配原因',
  `match_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '匹配时间',
  PRIMARY KEY (`id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_insurance_id` (`insurance_id`),
  KEY `idx_match_score` (`match_score`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='匹配记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_record`
--

LOCK TABLES `match_record` WRITE;
/*!40000 ALTER TABLE `match_record` DISABLE KEYS */;
INSERT INTO `match_record` VALUES (1,4,1,30.00,'行业高度匹配；风险覆盖全面','2025-10-21 17:34:17'),(2,4,2,50.00,'行业高度匹配；资产类型匹配；风险覆盖全面','2025-10-21 17:34:17'),(3,4,3,25.00,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:34:17'),(4,4,1,10.00,'风险覆盖全面','2025-10-21 17:35:13'),(5,4,2,25.00,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:13'),(6,4,3,17.50,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:13'),(7,4,1,16.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:28'),(8,4,2,21.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:28'),(9,4,3,10.83,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:28'),(10,4,1,16.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:29'),(11,4,2,21.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:29'),(12,4,3,10.83,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:29'),(13,4,1,15.00,'风险覆盖全面','2025-10-21 17:35:46'),(14,4,2,10.00,'风险覆盖全面','2025-10-21 17:35:46'),(15,4,3,12.50,'支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:46'),(16,4,1,15.00,'风险覆盖全面','2025-10-21 21:55:59'),(17,4,2,7.00,'风险覆盖全面','2025-10-21 21:55:59'),(18,4,3,13.50,'支持进出口贸易企业；风险覆盖全面','2025-10-21 21:55:59'),(19,4,1,15.00,'风险覆盖全面','2025-10-21 21:56:47'),(20,4,2,7.00,'风险覆盖全面','2025-10-21 21:56:47'),(21,4,3,13.50,'支持进出口贸易企业；风险覆盖全面','2025-10-21 21:56:47'),(22,4,1,0.00,'基本符合企业保险需求','2025-10-21 22:40:26'),(23,4,2,0.00,'基本符合企业保险需求','2025-10-21 22:40:26'),(24,4,3,5.00,'支持进出口贸易企业','2025-10-21 22:40:26'),(25,4,1,0.00,'基本符合企业保险需求','2025-10-21 22:40:50'),(26,4,2,0.00,'基本符合企业保险需求','2025-10-21 22:40:50'),(27,4,3,5.00,'支持进出口贸易企业','2025-10-21 22:40:50'),(28,4,1,0.00,'基本符合企业保险需求','2025-10-21 22:40:51'),(29,4,2,0.00,'基本符合企业保险需求','2025-10-21 22:40:51'),(30,4,3,5.00,'支持进出口贸易企业','2025-10-21 22:40:51'),(31,4,1,5.00,'基本符合企业保险需求','2025-10-21 22:41:06'),(32,4,2,5.00,'基本符合企业保险需求','2025-10-21 22:41:06'),(33,4,3,0.00,'基本符合企业保险需求','2025-10-21 22:41:06'),(34,4,1,5.00,'基本符合企业保险需求','2025-10-21 23:12:19'),(35,4,2,5.00,'基本符合企业保险需求','2025-10-21 23:12:19'),(36,4,3,0.00,'基本符合企业保险需求','2025-10-21 23:12:19'),(37,4,1,5.00,'基本符合企业保险需求','2025-10-21 23:12:20'),(38,4,2,5.00,'基本符合企业保险需求','2025-10-21 23:12:20'),(39,4,3,0.00,'基本符合企业保险需求','2025-10-21 23:12:20'),(40,4,1,5.00,'基本符合企业保险需求','2025-10-21 23:12:26'),(41,4,2,5.00,'基本符合企业保险需求','2025-10-21 23:12:26'),(42,4,3,0.00,'基本符合企业保险需求','2025-10-21 23:12:26'),(43,5,1,5.00,'基本符合企业保险需求','2025-10-22 00:04:27'),(44,5,2,5.00,'基本符合企业保险需求','2025-10-22 00:04:27'),(45,5,3,0.00,'基本符合企业保险需求','2025-10-22 00:04:27');
/*!40000 ALTER TABLE `match_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `openid` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '微信openid',
  `unionid` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信unionid',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `nickname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像URL',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_openid` (`openid`),
  KEY `idx_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'ogqt-168mQ7H_SEb0A5Lw_jv-cUI',NULL,'17875786862',NULL,NULL,'2025-10-22 00:01:18','2025-10-22 00:01:18');
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

-- Dump completed on 2025-10-22 10:09:46
