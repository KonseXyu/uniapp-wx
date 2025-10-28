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
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback_id` bigint NOT NULL,
  `feedback_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `feedback_id` (`feedback_id`) USING BTREE,
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`feedback_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,3,'aaaaaaa','2025-10-27 13:34:53'),(3,3,'这是一条反馈内容',NULL),(4,3,'这是1111111111111111一条反馈内容',NULL),(5,3,'这是111111111112222211111一条反馈内容',NULL),(6,3,'这是11111331111112222211111一条反馈内容','2025-10-27 14:20:04');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'tbl_user','前台用户表',NULL,NULL,'TblUser','crud','element-plus','com.ruoyi.system','system','user_wx','前台用户管理','konse','0','/','{\"parentMenuId\":0}','admin','2025-10-28 11:45:49','','2025-10-28 11:58:26',NULL),(2,'tbl_insurance_product','保险产品表',NULL,NULL,'TblInsuranceProduct','crud','element-plus','com.ruoyi.system','system','product','保险产品','konse','0','/','{\"parentMenuId\":1}','admin','2025-10-28 12:05:42','','2025-10-28 14:29:58',NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'id','用户ID','bigint','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(2,1,'openid','微信openid','varchar(128)','String','openid','0','0','0','0','0','1','1','LIKE','input','',2,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(3,1,'unionid','微信unionid','varchar(128)','String','unionid','0','0','0','0','0','1','1','LIKE','input','',3,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(4,1,'phone','手机号','varchar(20)','String','phone','0','0','0','0','0','1','1','LIKE','input','',4,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(5,1,'nickname','昵称','varchar(100)','String','nickname','0','0','0','0','0','1','1','LIKE','input','',5,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(6,1,'avatar','头像URL','varchar(255)','String','avatar','0','0','0','0','0','0','0','EQ','input','',6,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(7,1,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',7,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(8,1,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',8,'admin','2025-10-28 11:45:49','','2025-10-28 11:58:26'),(9,2,'id','保险产品ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(10,2,'company_name','保险公司名称','varchar(200)','String','companyName','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(11,2,'company_contact_name','保险公司联系人姓名','varchar(100)','String','companyContactName','0','0','0','1','1','1','1','LIKE','input','',3,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(12,2,'company_contact_phone','保险公司联系电话','varchar(20)','String','companyContactPhone','0','0','1','1','1','1','1','EQ','input','',4,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(13,2,'company_address','保险公司地址','varchar(500)','String','companyAddress','0','0','1','1','1','1','1','LIKE','textarea','',5,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(14,2,'insurance_name','保险名称','varchar(200)','String','insuranceName','0','0','1','1','1','1','1','LIKE','input','',6,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(15,2,'insurance_contact_name','保险联系人姓名','varchar(100)','String','insuranceContactName','0','0','1','1','1','1','1','LIKE','input','',7,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(16,2,'insurance_contact_phone','保险联系人电话','varchar(20)','String','insuranceContactPhone','0','0','1','1','1','1','1','EQ','input','',8,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(17,2,'insurance_type','保险种类','varchar(100)','String','insuranceType','0','0','1','1','1','1','1','EQ','radio','insurance_type',9,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(18,2,'target_industry','目标行业（多选，逗号分隔）','text','String','targetIndustry','0','0','1','1','1','1','1','EQ','select','insurance_industry',11,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(19,2,'target_years','目标成立年限（多选，逗号分隔）','text','String','targetYears','0','0','1','1','1','1','1','EQ','select','insurance_years',12,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(20,2,'target_employees','目标员工总数（多选，逗号分隔）','text','String','targetEmployees','0','0','1','1','1','1','1','EQ','select','insurance_employees',13,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(21,2,'target_revenue','目标年营业额（多选，逗号分隔）','text','String','targetRevenue','0','0','1','1','1','1','1','EQ','select','insurance_revenue',14,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(22,2,'target_capital','目标注册资本金（多选，逗号分隔）','text','String','targetCapital','0','0','1','1','1','1','1','EQ','select','insurance_capital',15,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(23,2,'target_assets','目标主要资产（多选，逗号分隔）','text','String','targetAssets','0','0','1','1','1','1','1','EQ','checkbox','insurance_assets',16,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(24,2,'target_equipment','目标特殊设备或场景（多选，逗号分隔）','text','String','targetEquipment','0','0','1','1','1','1','1','EQ','checkbox','insurance_equipment',17,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(25,2,'target_import_export','是否涉及进出口贸易','varchar(10)','String','targetImportExport','0','0','1','1','1','1','1','EQ','radio','insurance_import_export',10,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(26,2,'covered_insurance_types','已购买的保险类型（多选，逗号分隔）','text','String','coveredInsuranceTypes','0','0','1','1','1','1','1','EQ','checkbox','insurance_purchased',18,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(27,2,'covered_risks','覆盖的风险（多选，逗号分隔）','text','String','coveredRisks','0','0','1','1','1','1','1','EQ','checkbox','insurance_risk_coverage',19,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(28,2,'covered_potential_risks','覆盖的潜在风险（多选，逗号分隔）','text','String','coveredPotentialRisks','0','0','1','1','1','1','1','EQ','checkbox','insurance_potential_risk',20,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(29,2,'risk_transfer_types','能转移的风险责任（多选，逗号分隔）','text','String','riskTransferTypes','0','0','1','1','1','1','1','EQ','checkbox','insurance_risk_transfer',21,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(30,2,'annual_fee','年度保险费用','varchar(50)','String','annualFee','0','0','1','1','1','1','1','EQ','select','insurance_budget',22,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(31,2,'other_notes','其他说明','text','String','otherNotes','0','0','0','1','1','1','1','EQ','textarea','',23,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(32,2,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',24,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58'),(33,2,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',25,'admin','2025-10-28 12:05:42','','2025-10-28 14:29:58');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2025-10-27 17:05:02','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2025-10-27 17:05:02','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2025-10-27 17:05:02','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2025-10-27 17:05:02','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2025-10-27 17:05:02','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2025-10-27 17:05:02','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2025-10-27 17:05:02','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2025-10-27 17:05:02','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','保险公司',0,'若依','15888888888','ry@qq.com','0','0','admin','2025-10-27 17:04:58','admin','2025-10-27 17:13:01'),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-10-27 17:04:58','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','2','admin','2025-10-27 17:04:58','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-10-27 17:04:58','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','2','admin','2025-10-27 17:04:58','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2025-10-27 17:04:58','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','2','admin','2025-10-27 17:04:58','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','2','admin','2025-10-27 17:04:58','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','2','admin','2025-10-27 17:04:58','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','2','admin','2025-10-27 17:04:58','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2025-10-27 17:05:02','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2025-10-27 17:05:02','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2025-10-27 17:05:02','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2025-10-27 17:05:02','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2025-10-27 17:05:02','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2025-10-27 17:05:02','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2025-10-27 17:05:02','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2025-10-27 17:05:02','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2025-10-27 17:05:02','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2025-10-27 17:05:02','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2025-10-27 17:05:02','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2025-10-27 17:05:02','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2025-10-27 17:05:02','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2025-10-27 17:05:02','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2025-10-27 17:05:02','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2025-10-27 17:05:02','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2025-10-27 17:05:02','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2025-10-27 17:05:02','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2025-10-27 17:05:02','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2025-10-27 17:05:02','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2025-10-27 17:05:02','',NULL,'停用状态'),(100,0,'食品加工业','食品加工业','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:46:39','',NULL,NULL),(101,1,'家具制造业','家具制造业','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:46:50','',NULL,NULL),(102,2,'造纸与纸制品生产','造纸与纸制品生产','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:46:58','',NULL,NULL),(103,3,'塑料制品生产','塑料制品生产','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:47:08','',NULL,NULL),(104,4,'纺织业','纺织业','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:47:17','',NULL,NULL),(105,5,'木制品生产','木制品生产','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:47:23','',NULL,NULL),(106,6,'仓储类','仓储类','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:47:31','',NULL,NULL),(107,7,'物流运输','物流运输','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:47:39','admin','2025-10-28 13:47:43',NULL),(108,8,'其他行业','其他行业','insurance_industry',NULL,'default','N','0','admin','2025-10-28 13:47:53','',NULL,NULL),(109,0,'厂房/仓库','厂房/仓库','insurance_assets',NULL,'default','N','0','admin','2025-10-28 13:48:47','',NULL,NULL),(110,1,'办公设备','办公设备','insurance_assets',NULL,'default','N','0','admin','2025-10-28 13:48:54','',NULL,NULL),(111,2,'生产设备/流水线','生产设备/流水线','insurance_assets',NULL,'default','N','0','admin','2025-10-28 13:49:01','admin','2025-10-28 13:49:05',NULL),(112,3,'运输车辆','运输车辆','insurance_assets',NULL,'default','N','0','admin','2025-10-28 13:49:14','',NULL,NULL),(113,4,'存货（原材料/成品）','存货（原材料/成品）','insurance_assets',NULL,'default','N','0','admin','2025-10-28 13:49:22','',NULL,NULL),(114,5,'其它资产','其它资产','insurance_assets',NULL,'default','N','0','admin','2025-10-28 13:49:31','',NULL,NULL),(115,0,'1年以下','1年以下','insurance_years',NULL,'default','N','0','admin','2025-10-28 13:50:07','',NULL,NULL),(116,1,'1-3年','1-3年','insurance_years',NULL,'default','N','0','admin','2025-10-28 13:50:15','',NULL,NULL),(117,2,'3-5年','3-5年','insurance_years',NULL,'default','N','0','admin','2025-10-28 13:50:22','',NULL,NULL),(118,3,'5年以上','5年以上','insurance_years',NULL,'default','N','0','admin','2025-10-28 13:50:31','',NULL,NULL),(119,0,'50人以下','50人以下','insurance_employees',NULL,'default','N','0','admin','2025-10-28 13:51:03','',NULL,NULL),(120,1,'50-200人','50-200人','insurance_employees',NULL,'default','N','0','admin','2025-10-28 13:51:11','',NULL,NULL),(121,2,'200-500人','200-500人','insurance_employees',NULL,'default','N','0','admin','2025-10-28 13:51:19','',NULL,NULL),(122,3,'500人以上','500人以上','insurance_employees',NULL,'default','N','0','admin','2025-10-28 13:51:29','',NULL,NULL),(123,0,'500万以下','500万以下','insurance_revenue',NULL,'default','N','0','admin','2025-10-28 13:53:23','',NULL,NULL),(124,1,'500万-3000万','500万-3000万','insurance_revenue',NULL,'default','N','0','admin','2025-10-28 13:53:27','',NULL,NULL),(125,2,'3000万-1亿','3000万-1亿','insurance_revenue',NULL,'default','N','0','admin','2025-10-28 13:53:35','',NULL,NULL),(126,3,'1亿以上','1亿以上','insurance_revenue',NULL,'default','N','0','admin','2025-10-28 13:53:47','',NULL,NULL),(127,0,'500万以下','500万以下','insurance_capital',NULL,'default','N','0','admin','2025-10-28 13:54:32','',NULL,NULL),(128,1,'500万-3000万','500万-3000万','insurance_capital',NULL,'default','N','0','admin','2025-10-28 13:54:39','',NULL,NULL),(129,2,'3000万-1亿','3000万-1亿','insurance_capital',NULL,'default','N','0','admin','2025-10-28 13:54:48','',NULL,NULL),(130,3,'1亿以上','1亿以上','insurance_capital',NULL,'default','N','0','admin','2025-10-28 13:54:56','',NULL,NULL),(131,0,'高压/高温设备','高压/高温设备','insurance_equipment',NULL,'default','N','0','admin','2025-10-28 13:56:05','',NULL,NULL),(132,1,'精密仪器','精密仪器','insurance_equipment',NULL,'default','N','0','admin','2025-10-28 13:56:10','',NULL,NULL),(133,2,'高空作业','高空作业','insurance_equipment',NULL,'default','N','0','admin','2025-10-28 13:56:16','',NULL,NULL),(134,3,'危险化学品存储','危险化学品存储','insurance_equipment',NULL,'default','N','0','admin','2025-10-28 13:56:21','',NULL,NULL),(135,4,'数据服务器机房','数据服务器机房','insurance_equipment',NULL,'default','N','0','admin','2025-10-28 13:56:28','',NULL,NULL),(136,5,'以上设备或场景均没有','以上设备或场景均没有','insurance_equipment',NULL,'default','N','0','admin','2025-10-28 13:56:34','',NULL,NULL),(137,0,'财险','财险','insurance_type',NULL,'default','N','0','admin','2025-10-28 13:58:04','',NULL,NULL),(138,1,'寿险','寿险','insurance_type',NULL,'default','N','0','admin','2025-10-28 13:58:09','admin','2025-10-28 13:58:13',NULL),(139,0,'财产一切险','财产一切险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:00','',NULL,NULL),(140,1,'公众责任险','公众责任险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:08','',NULL,NULL),(141,2,'雇主责任险','雇主责任险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:17','',NULL,NULL),(142,3,'货物运输险','货物运输险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:25','',NULL,NULL),(143,4,'机器损坏险','机器损坏险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:33','',NULL,NULL),(144,5,'产品责任险','产品责任险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:45','',NULL,NULL),(145,6,'团体意外险','团体意外险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:00:53','',NULL,NULL),(146,7,'工程险','工程险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:01:02','admin','2025-10-28 14:01:07',NULL),(147,8,'没有购买过任何保险','没有购买过任何保险','insurance_purchased',NULL,'default','N','0','admin','2025-10-28 14:01:12','',NULL,NULL),(148,1,'自然灾害（火灾/洪水/地震等）','自然灾害（火灾/洪水/地震等）','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:03:45','',NULL,NULL),(149,2,'盗窃/抢劫','盗窃/抢劫','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:03:53','',NULL,NULL),(150,3,'员工工伤事故','员工工伤事故','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:03:59','',NULL,NULL),(151,4,'员工意外伤害','员工意外伤害','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:04:06','',NULL,NULL),(152,5,'产品质量纠纷','产品质量纠纷','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:04:14','',NULL,NULL),(153,6,'设备故障/停工','设备故障/停工','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:04:21','',NULL,NULL),(154,7,'法律诉讼','法律诉讼','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:04:27','',NULL,NULL),(155,8,'覆盖其他风险','覆盖其他风险','insurance_risk_coverage',NULL,'default','N','0','admin','2025-10-28 14:04:39','',NULL,NULL),(156,1,'重大资产损失导致停产','重大资产损失导致停产','insurance_potential_risk',NULL,'default','N','0','admin','2025-10-28 14:05:25','admin','2025-10-28 14:05:29',NULL),(157,2,'高额赔偿责任（如客户/公众伤害）','高额赔偿责任（如客户/公众伤害）','insurance_potential_risk',NULL,'default','N','0','admin','2025-10-28 14:05:36','',NULL,NULL),(158,3,'关键技术人员意外风险','关键技术人员意外风险','insurance_potential_risk',NULL,'default','N','0','admin','2025-10-28 14:05:43','',NULL,NULL),(159,4,'其他潜在风险','其他潜在风险','insurance_potential_risk',NULL,'default','N','0','admin','2025-10-28 14:05:48','',NULL,NULL),(160,5,'无','无','insurance_potential_risk',NULL,'default','N','0','admin','2025-10-28 14:05:54','',NULL,NULL),(161,1,'企业自身财产损失','企业自身财产损失','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:06:28','',NULL,NULL),(162,2,'第三方人身/财产损害赔偿责任','第三方人身/财产损害赔偿责任','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:06:35','',NULL,NULL),(163,3,'员工工伤/职业病保障','员工工伤/职业病保障','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:06:40','',NULL,NULL),(164,4,'货物运输途中的风险','货物运输途中的风险','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:06:46','',NULL,NULL),(165,5,'相关诉讼法律费用','相关诉讼法律费用','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:06:51','',NULL,NULL),(166,6,'其他特殊需求','其他特殊需求','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:06:57','',NULL,NULL),(167,7,'不能转移任何风险责任','不能转移任何风险责任','insurance_risk_transfer',NULL,'default','N','0','admin','2025-10-28 14:07:03','',NULL,NULL),(168,1,'10万以下','10万以下','insurance_budget',NULL,'default','N','0','admin','2025-10-28 14:07:27','',NULL,NULL),(169,2,'10-30万','10-30万','insurance_budget',NULL,'default','N','0','admin','2025-10-28 14:07:32','',NULL,NULL),(170,3,'30-50万','30-50万','insurance_budget',NULL,'default','N','0','admin','2025-10-28 14:07:38','',NULL,NULL),(171,4,'50万以上','50万以上','insurance_budget',NULL,'default','N','0','admin','2025-10-28 14:07:43','',NULL,NULL),(172,1,'是','是','insurance_import_export',NULL,'default','N','0','admin','2025-10-28 14:11:59','',NULL,NULL),(173,2,'否','否','insurance_import_export',NULL,'default','N','0','admin','2025-10-28 14:12:06','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2025-10-27 17:05:02','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2025-10-27 17:05:02','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2025-10-27 17:05:02','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2025-10-27 17:05:02','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2025-10-27 17:05:02','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2025-10-27 17:05:02','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2025-10-27 17:05:02','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2025-10-27 17:05:02','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2025-10-27 17:05:02','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2025-10-27 17:05:02','',NULL,'登录状态列表'),(100,'所属行业','insurance_industry','0','admin','2025-10-28 13:46:24','',NULL,'保险适用行业'),(101,'企业主要资产','insurance_assets','0','admin','2025-10-28 13:48:28','',NULL,NULL),(102,'投保企业成立年限','insurance_years','0','admin','2025-10-28 13:49:58','',NULL,NULL),(103,'企业员工总数','insurance_employees','0','admin','2025-10-28 13:50:55','',NULL,NULL),(104,'企业年营业额（人民币）','insurance_revenue','0','admin','2025-10-28 13:52:57','',NULL,NULL),(105,'企业注册资本金（人民币）','insurance_capital','0','admin','2025-10-28 13:54:25','',NULL,NULL),(106,'企业拥有的特殊设备或场景','insurance_equipment','0','admin','2025-10-28 13:55:57','',NULL,NULL),(107,'所属保险类型','insurance_type','0','admin','2025-10-28 13:57:56','',NULL,NULL),(108,'企业已购买的保险','insurance_purchased','0','admin','2025-10-28 13:59:51','',NULL,NULL),(109,'需要保险保障的风险范围','insurance_risk_coverage','0','admin','2025-10-28 14:03:33','admin','2025-10-28 14:05:16','riskCoverage'),(110,'需要保险保障的潜在风险','insurance_potential_risk','0','admin','2025-10-28 14:05:05','',NULL,NULL),(111,'需要保险能够转移的风险责任','insurance_risk_transfer','0','admin','2025-10-28 14:06:18','',NULL,NULL),(112,'企业年度保险费用预算','insurance_budget','0','admin','2025-10-28 14:07:19','',NULL,NULL),(113,'企业是否涉及进出口贸易','insurance_import_export','0','admin','2025-10-28 14:11:52','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2025-10-27 17:05:02','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2025-10-27 17:05:03','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2025-10-27 17:05:03','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','验证码错误','2025-10-28 11:45:15'),(101,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','1','验证码错误','2025-10-28 11:45:17'),(102,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 11:45:19'),(103,'admin','127.0.0.1','内网IP','Chrome 14','Windows 10','0','登录成功','2025-10-28 13:44:17');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2025-10-27 17:04:59','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2025-10-27 17:04:59','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2025-10-27 17:04:59','',NULL,'系统工具目录'),(100,'后台用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2025-10-27 17:04:59','admin','2025-10-27 17:17:00','用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2025-10-27 17:04:59','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2025-10-27 17:04:59','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2025-10-27 17:04:59','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2025-10-27 17:04:59','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2025-10-27 17:04:59','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2025-10-27 17:04:59','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2025-10-27 17:04:59','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2025-10-27 17:04:59','',NULL,'日志管理菜单'),(109,'后台在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2025-10-27 17:04:59','admin','2025-10-27 17:17:16','在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2025-10-27 17:04:59','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2025-10-27 17:04:59','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2025-10-27 17:04:59','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2025-10-27 17:04:59','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2025-10-27 17:04:59','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2025-10-27 17:04:59','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2025-10-27 17:04:59','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2025-10-27 17:04:59','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2025-10-27 17:04:59','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2025-10-27 17:04:59','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2025-10-27 17:04:59','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2025-10-27 17:04:59','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2025-10-27 17:04:59','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2025-10-27 17:04:59','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2025-10-27 17:04:59','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2025-10-27 17:04:59','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2025-10-27 17:04:59','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2025-10-27 17:04:59','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2025-10-27 17:04:59','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2025-10-27 17:04:59','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2025-10-27 17:04:59','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2025-10-27 17:04:59','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2025-10-27 17:04:59','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2025-10-27 17:04:59','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2025-10-27 17:04:59','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2025-10-27 17:05:00','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2025-10-27 17:05:00','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2025-10-27 17:05:00','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2025-10-27 17:05:00','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2025-10-27 17:05:00','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2025-10-27 17:05:00','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2025-10-27 17:05:00','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2025-10-27 17:05:00','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2025-10-27 17:05:00','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2025-10-27 17:05:00','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2025-10-27 17:05:00','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2025-10-27 17:05:00','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2025-10-27 17:05:00','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2025-10-27 17:05:00','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2025-10-27 17:05:00','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2025-10-27 17:05:00','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2025-10-27 17:05:00','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2025-10-27 17:05:00','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2025-10-27 17:05:00','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2025-10-27 17:05:00','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2025-10-27 17:05:00','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2025-10-27 17:05:01','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2025-10-27 17:05:01','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2025-10-27 17:05:01','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2025-10-27 17:05:01','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2025-10-27 17:05:01','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2025-10-27 17:05:01','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2025-10-27 17:05:01','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2025-10-27 17:05:01','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2025-10-27 17:05:01','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2025-10-27 17:05:01','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2025-10-27 17:05:01','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2025-10-27 17:05:01','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2025-10-27 17:05:01','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2025-10-27 17:05:01','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2025-10-27 17:05:01','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2025-10-27 17:05:01','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2025-10-27 17:05:01','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2025-10-27 17:05:01','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2025-10-27 17:05:01','',NULL,''),(2000,'前台用户管理',1,1,'user_wx','system/user_wx/index',NULL,'',1,0,'C','0','0','system:user_wx:list','user','admin','2025-10-28 12:01:28','admin','2025-10-28 12:04:13','前台用户管理菜单'),(2001,'前台用户管理查询',2000,1,'#','',NULL,'',1,0,'F','0','0','system:user_wx:query','#','admin','2025-10-28 12:01:29','',NULL,''),(2002,'前台用户管理新增',2000,2,'#','',NULL,'',1,0,'F','0','0','system:user_wx:add','#','admin','2025-10-28 12:01:29','',NULL,''),(2003,'前台用户管理修改',2000,3,'#','',NULL,'',1,0,'F','0','0','system:user_wx:edit','#','admin','2025-10-28 12:01:29','',NULL,''),(2004,'前台用户管理删除',2000,4,'#','',NULL,'',1,0,'F','0','0','system:user_wx:remove','#','admin','2025-10-28 12:01:29','',NULL,''),(2005,'前台用户管理导出',2000,5,'#','',NULL,'',1,0,'F','0','0','system:user_wx:export','#','admin','2025-10-28 12:01:29','',NULL,''),(2006,'保险产品',1,1,'product','system/product/index',NULL,'',1,0,'C','0','0','system:product:list','dict','admin','2025-10-28 14:15:51','admin','2025-10-28 14:34:37','保险产品菜单'),(2007,'保险产品查询',2006,1,'#','',NULL,'',1,0,'F','0','0','system:product:query','#','admin','2025-10-28 14:15:52','',NULL,''),(2008,'保险产品新增',2006,2,'#','',NULL,'',1,0,'F','0','0','system:product:add','#','admin','2025-10-28 14:15:52','',NULL,''),(2009,'保险产品修改',2006,3,'#','',NULL,'',1,0,'F','0','0','system:product:edit','#','admin','2025-10-28 14:15:52','',NULL,''),(2010,'保险产品删除',2006,4,'#','',NULL,'',1,0,'F','0','0','system:product:remove','#','admin','2025-10-28 14:15:52','',NULL,''),(2011,'保险产品导出',2006,5,'#','',NULL,'',1,0,'F','0','0','system:product:export','#','admin','2025-10-28 14:15:52','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2025-10-27 17:05:03','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2025-10-27 17:05:03','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (1,'操作日志',9,'com.ruoyi.web.controller.monitor.SysOperlogController.clean()','DELETE',1,'admin','研发部门','/monitor/operlog/clean','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-27 17:14:41',20),(2,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2025-10-27 17:04:59\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"后台用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-27 17:17:00',4),(3,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"monitor/online/index\",\"createTime\":\"2025-10-27 17:04:59\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":109,\"menuName\":\"后台在线用户\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2,\"path\":\"online\",\"perms\":\"monitor:online:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-27 17:17:16',5),(4,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tbl_user\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 11:45:49',67),(5,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"TblUser\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Openid\",\"columnComment\":\"微信openid\",\"columnId\":2,\"columnName\":\"openid\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"openid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Unionid\",\"columnComment\":\"微信unionid\",\"columnId\":3,\"columnName\":\"unionid\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"unionid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"手机号\",\"columnId\":4,\"columnName\":\"phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 11:47:18',29),(6,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tbl_user\"}',NULL,0,NULL,'2025-10-28 11:47:27',175),(7,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"TblUser\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 11:47:18\",\"usableColumn\":false},{\"capJavaField\":\"Openid\",\"columnComment\":\"微信openid\",\"columnId\":2,\"columnName\":\"openid\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"openid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 11:47:18\",\"usableColumn\":false},{\"capJavaField\":\"Unionid\",\"columnComment\":\"微信unionid\",\"columnId\":3,\"columnName\":\"unionid\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"unionid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 11:47:18\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"手机号\",\"columnId\":4,\"columnName\":\"phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 11:47:58',21),(8,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tbl_user\"}',NULL,0,NULL,'2025-10-28 11:48:02',32),(9,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user_wx\",\"className\":\"TblUser\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 11:47:58\",\"usableColumn\":false},{\"capJavaField\":\"Openid\",\"columnComment\":\"微信openid\",\"columnId\":2,\"columnName\":\"openid\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"openid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 11:47:58\",\"usableColumn\":false},{\"capJavaField\":\"Unionid\",\"columnComment\":\"微信unionid\",\"columnId\":3,\"columnName\":\"unionid\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"unionid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 11:47:58\",\"usableColumn\":false},{\"capJavaField\":\"Phone\",\"columnComment\":\"手机号\",\"columnId\":4,\"columnName\":\"phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 11:45:49\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEd','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 11:58:26',50),(10,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tbl_user\"}',NULL,0,NULL,'2025-10-28 11:58:29',182),(11,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/user_wx/index\",\"createTime\":\"2025-10-28 12:01:28\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"前台用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user_wx\",\"perms\":\"system:user_wx:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 12:02:17',22),(12,'前台用户管理',3,'com.ruoyi.system.controller.TblUserController.remove()','DELETE',1,'admin','研发部门','/system/user_wx/5','127.0.0.1','内网IP','[5]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 12:03:51',7),(13,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/user_wx/index\",\"createTime\":\"2025-10-28 12:01:28\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"前台用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user_wx\",\"perms\":\"system:user_wx:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 12:04:13',8),(14,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tbl_insurance_product\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 12:05:42',82),(15,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"所属行业\",\"dictType\":\"insurance_industry\",\"params\":{},\"remark\":\"保险适用行业\",\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:46:24',20),(16,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"食品加工业\",\"dictSort\":0,\"dictType\":\"insurance_industry\",\"dictValue\":\"食品加工业\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:46:39',9),(17,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"家具制造业\",\"dictSort\":1,\"dictType\":\"insurance_industry\",\"dictValue\":\"家具制造业\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:46:50',8),(18,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"造纸与纸制品生产\",\"dictSort\":2,\"dictType\":\"insurance_industry\",\"dictValue\":\"造纸与纸制品生产\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:46:58',8),(19,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"塑料制品生产\",\"dictSort\":3,\"dictType\":\"insurance_industry\",\"dictValue\":\"塑料制品生产\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:08',8),(20,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"纺织业\",\"dictSort\":4,\"dictType\":\"insurance_industry\",\"dictValue\":\"纺织业\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:17',7),(21,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"木制品生产\",\"dictSort\":5,\"dictType\":\"insurance_industry\",\"dictValue\":\"木制品生产\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:23',8),(22,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"仓储类\",\"dictSort\":6,\"dictType\":\"insurance_industry\",\"dictValue\":\"仓储类\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:31',7),(23,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"物流运输\",\"dictSort\":6,\"dictType\":\"insurance_industry\",\"dictValue\":\"物流运输\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:39',9),(24,'字典数据',2,'com.ruoyi.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-10-28 13:47:39\",\"default\":false,\"dictCode\":107,\"dictLabel\":\"物流运输\",\"dictSort\":7,\"dictType\":\"insurance_industry\",\"dictValue\":\"物流运输\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:43',8),(25,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他行业\",\"dictSort\":8,\"dictType\":\"insurance_industry\",\"dictValue\":\"其他行业\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:47:53',8),(26,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业主要资产\",\"dictType\":\"insurance_assets\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:48:28',5),(27,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"厂房/仓库\",\"dictSort\":0,\"dictType\":\"insurance_assets\",\"dictValue\":\"厂房/仓库\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:48:47',6),(28,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"办公设备\",\"dictSort\":1,\"dictType\":\"insurance_assets\",\"dictValue\":\"办公设备\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:48:54',6),(29,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"生产设备/流水线\",\"dictSort\":3,\"dictType\":\"insurance_assets\",\"dictValue\":\"生产设备/流水线\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:49:01',6),(30,'字典数据',2,'com.ruoyi.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-10-28 13:49:01\",\"default\":false,\"dictCode\":111,\"dictLabel\":\"生产设备/流水线\",\"dictSort\":2,\"dictType\":\"insurance_assets\",\"dictValue\":\"生产设备/流水线\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:49:06',8),(31,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"运输车辆\",\"dictSort\":3,\"dictType\":\"insurance_assets\",\"dictValue\":\"运输车辆\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:49:14',9),(32,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"存货（原材料/成品）\",\"dictSort\":4,\"dictType\":\"insurance_assets\",\"dictValue\":\"存货（原材料/成品）\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:49:22',8),(33,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其它资产\",\"dictSort\":5,\"dictType\":\"insurance_assets\",\"dictValue\":\"其它资产\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:49:31',7),(34,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"投保企业成立年限\",\"dictType\":\"insurance_years\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:49:58',6),(35,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"1年以下\",\"dictSort\":0,\"dictType\":\"insurance_years\",\"dictValue\":\"1年以下\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:50:07',6),(36,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"1-3年\",\"dictSort\":1,\"dictType\":\"insurance_years\",\"dictValue\":\"1-3年\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:50:15',6),(37,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"3-5年\",\"dictSort\":2,\"dictType\":\"insurance_years\",\"dictValue\":\"3-5年\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:50:22',5),(38,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"5年以上\",\"dictSort\":3,\"dictType\":\"insurance_years\",\"dictValue\":\"5年以上\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:50:31',7),(39,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业员工总数\",\"dictType\":\"insurance_employees\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:50:55',5),(40,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"50人以下\",\"dictSort\":0,\"dictType\":\"insurance_employees\",\"dictValue\":\"50人以下\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:51:03',6),(41,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"50-200人\",\"dictSort\":1,\"dictType\":\"insurance_employees\",\"dictValue\":\"50-200人\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:51:11',6),(42,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"200-500人\",\"dictSort\":2,\"dictType\":\"insurance_employees\",\"dictValue\":\"200-500人\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:51:19',6),(43,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"500人以上\",\"dictSort\":3,\"dictType\":\"insurance_employees\",\"dictValue\":\"500人以上\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:51:29',6),(44,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业年营业额（人民币）\",\"dictType\":\"insurance_revenue\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:52:57',6),(45,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"500万以下\",\"dictSort\":0,\"dictType\":\"insurance_revenue\",\"dictValue\":\"500万以下\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:53:23',5),(46,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"500万-3000万\",\"dictSort\":1,\"dictType\":\"insurance_revenue\",\"dictValue\":\"500万-3000万\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:53:27',5),(47,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"3000万-1亿\",\"dictSort\":2,\"dictType\":\"insurance_revenue\",\"dictValue\":\"3000万-1亿\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:53:35',6),(48,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"1亿以上\",\"dictSort\":3,\"dictType\":\"insurance_revenue\",\"dictValue\":\"1亿以上\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:53:47',5),(49,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业注册资本金（人民币）\",\"dictType\":\"insurance_capital\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:54:25',5),(50,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"500万以下\",\"dictSort\":0,\"dictType\":\"insurance_capital\",\"dictValue\":\"500万以下\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:54:32',5),(51,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"500万-3000万\",\"dictSort\":1,\"dictType\":\"insurance_capital\",\"dictValue\":\"500万-3000万\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:54:39',6),(52,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"3000万-1亿\",\"dictSort\":2,\"dictType\":\"insurance_capital\",\"dictValue\":\"3000万-1亿\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:54:48',6),(53,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"1亿以上\",\"dictSort\":3,\"dictType\":\"insurance_capital\",\"dictValue\":\"1亿以上\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:54:56',5),(54,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业拥有的特殊设备或场景\",\"dictType\":\"insurance_equipment\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:55:57',5),(55,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"高压/高温设备\",\"dictSort\":0,\"dictType\":\"insurance_equipment\",\"dictValue\":\"高压/高温设备\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:56:05',5),(56,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"精密仪器\",\"dictSort\":1,\"dictType\":\"insurance_equipment\",\"dictValue\":\"精密仪器\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:56:10',6),(57,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"高空作业\",\"dictSort\":2,\"dictType\":\"insurance_equipment\",\"dictValue\":\"高空作业\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:56:16',6),(58,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"危险化学品存储\",\"dictSort\":3,\"dictType\":\"insurance_equipment\",\"dictValue\":\"危险化学品存储\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:56:21',6),(59,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"数据服务器机房\",\"dictSort\":4,\"dictType\":\"insurance_equipment\",\"dictValue\":\"数据服务器机房\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:56:28',5),(60,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"以上设备或场景均没有\",\"dictSort\":5,\"dictType\":\"insurance_equipment\",\"dictValue\":\"以上设备或场景均没有\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:56:34',5),(61,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"所属保险类型\",\"dictType\":\"insurance_type\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:57:56',6),(62,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"财险\",\"dictSort\":0,\"dictType\":\"insurance_type\",\"dictValue\":\"财险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:58:04',6),(63,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"寿险\",\"dictSort\":0,\"dictType\":\"insurance_type\",\"dictValue\":\"寿险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:58:09',5),(64,'字典数据',2,'com.ruoyi.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-10-28 13:58:09\",\"default\":false,\"dictCode\":138,\"dictLabel\":\"寿险\",\"dictSort\":1,\"dictType\":\"insurance_type\",\"dictValue\":\"寿险\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:58:13',5),(65,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业已购买的保险\",\"dictType\":\"insurance_purchased\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 13:59:51',4),(66,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"财产一切险\",\"dictSort\":0,\"dictType\":\"insurance_purchased\",\"dictValue\":\"财产一切险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:00',5),(67,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"公众责任险\",\"dictSort\":1,\"dictType\":\"insurance_purchased\",\"dictValue\":\"公众责任险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:08',5),(68,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"雇主责任险\",\"dictSort\":2,\"dictType\":\"insurance_purchased\",\"dictValue\":\"雇主责任险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:17',4),(69,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"货物运输险\",\"dictSort\":3,\"dictType\":\"insurance_purchased\",\"dictValue\":\"货物运输险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:25',5),(70,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"机器损坏险\",\"dictSort\":4,\"dictType\":\"insurance_purchased\",\"dictValue\":\"机器损坏险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:33',6),(71,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"产品责任险\",\"dictSort\":5,\"dictType\":\"insurance_purchased\",\"dictValue\":\"产品责任险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:45',5),(72,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"团体意外险\",\"dictSort\":6,\"dictType\":\"insurance_purchased\",\"dictValue\":\"团体意外险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:00:53',6),(73,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"工程险\",\"dictSort\":6,\"dictType\":\"insurance_purchased\",\"dictValue\":\"工程险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:01:02',5),(74,'字典数据',2,'com.ruoyi.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-10-28 14:01:02\",\"default\":false,\"dictCode\":146,\"dictLabel\":\"工程险\",\"dictSort\":7,\"dictType\":\"insurance_purchased\",\"dictValue\":\"工程险\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:01:07',5),(75,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"没有购买过任何保险\",\"dictSort\":8,\"dictType\":\"insurance_purchased\",\"dictValue\":\"没有购买过任何保险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:01:12',5),(76,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"需要保险保障的风险范围\",\"dictType\":\"insurance_risk\",\"params\":{},\"remark\":\"riskCoverage\",\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:03:33',5),(77,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"自然灾害（火灾/洪水/地震等）\",\"dictSort\":1,\"dictType\":\"insurance_risk\",\"dictValue\":\"自然灾害（火灾/洪水/地震等）\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:03:45',4),(78,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"盗窃/抢劫\",\"dictSort\":2,\"dictType\":\"insurance_risk\",\"dictValue\":\"盗窃/抢劫\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:03:53',6),(79,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"员工工伤事故\",\"dictSort\":3,\"dictType\":\"insurance_risk\",\"dictValue\":\"员工工伤事故\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:03:59',5),(80,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"员工意外伤害\",\"dictSort\":4,\"dictType\":\"insurance_risk\",\"dictValue\":\"员工意外伤害\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:04:06',5),(81,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"产品质量纠纷\",\"dictSort\":5,\"dictType\":\"insurance_risk\",\"dictValue\":\"产品质量纠纷\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:04:14',6),(82,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"设备故障/停工\",\"dictSort\":6,\"dictType\":\"insurance_risk\",\"dictValue\":\"设备故障/停工\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:04:21',5),(83,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"法律诉讼\",\"dictSort\":7,\"dictType\":\"insurance_risk\",\"dictValue\":\"法律诉讼\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:04:27',6),(84,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"覆盖其他风险\",\"dictSort\":8,\"dictType\":\"insurance_risk\",\"dictValue\":\"覆盖其他风险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:04:39',4),(85,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"需要保险保障的潜在风险\",\"dictType\":\"insurance_potential_risk\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:05',5),(86,'字典类型',2,'com.ruoyi.web.controller.system.SysDictTypeController.edit()','PUT',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-10-28 14:03:33\",\"dictId\":109,\"dictName\":\"需要保险保障的风险范围\",\"dictType\":\"insurance_risk_coverage\",\"params\":{},\"remark\":\"riskCoverage\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:16',19),(87,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"重大资产损失导致停产\",\"dictSort\":0,\"dictType\":\"insurance_potential_risk\",\"dictValue\":\"重大资产损失导致停产\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:25',5),(88,'字典数据',2,'com.ruoyi.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-10-28 14:05:25\",\"default\":false,\"dictCode\":156,\"dictLabel\":\"重大资产损失导致停产\",\"dictSort\":1,\"dictType\":\"insurance_potential_risk\",\"dictValue\":\"重大资产损失导致停产\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:29',6),(89,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"高额赔偿责任（如客户/公众伤害）\",\"dictSort\":2,\"dictType\":\"insurance_potential_risk\",\"dictValue\":\"高额赔偿责任（如客户/公众伤害）\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:36',4),(90,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"关键技术人员意外风险\",\"dictSort\":3,\"dictType\":\"insurance_potential_risk\",\"dictValue\":\"关键技术人员意外风险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:43',4),(91,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他潜在风险\",\"dictSort\":4,\"dictType\":\"insurance_potential_risk\",\"dictValue\":\"其他潜在风险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:48',4),(92,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"无\",\"dictSort\":5,\"dictType\":\"insurance_potential_risk\",\"dictValue\":\"无\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:05:54',5),(93,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"需要保险能够转移的风险责任\",\"dictType\":\"insurance_risk_transfer\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:18',4),(94,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"企业自身财产损失\",\"dictSort\":1,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"企业自身财产损失\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:28',4),(95,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"第三方人身/财产损害赔偿责任\",\"dictSort\":2,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"第三方人身/财产损害赔偿责任\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:35',6),(96,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"员工工伤/职业病保障\",\"dictSort\":3,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"员工工伤/职业病保障\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:40',5),(97,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"货物运输途中的风险\",\"dictSort\":4,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"货物运输途中的风险\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:46',4),(98,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"相关诉讼法律费用\",\"dictSort\":5,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"相关诉讼法律费用\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:51',5),(99,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他特殊需求\",\"dictSort\":6,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"其他特殊需求\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:06:57',5),(100,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"不能转移任何风险责任\",\"dictSort\":7,\"dictType\":\"insurance_risk_transfer\",\"dictValue\":\"不能转移任何风险责任\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:07:03',5),(101,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业年度保险费用预算\",\"dictType\":\"insurance_budget\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:07:19',4),(102,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"10万以下\",\"dictSort\":1,\"dictType\":\"insurance_budget\",\"dictValue\":\"10万以下\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:07:27',4),(103,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"10-30万\",\"dictSort\":2,\"dictType\":\"insurance_budget\",\"dictValue\":\"10-30万\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:07:32',5),(104,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"30-50万\",\"dictSort\":3,\"dictType\":\"insurance_budget\",\"dictValue\":\"30-50万\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:07:38',5),(105,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"50万以上\",\"dictSort\":4,\"dictType\":\"insurance_budget\",\"dictValue\":\"50万以上\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:07:43',4),(106,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"product\",\"className\":\"TblInsuranceProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"保险产品ID\",\"columnId\":9,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CompanyName\",\"columnComment\":\"保险公司名称\",\"columnId\":10,\"columnName\":\"company_name\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"companyName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactName\",\"columnComment\":\"保险公司联系人姓名\",\"columnId\":11,\"columnName\":\"company_contact_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"companyContactName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactPhone\",\"columnComment\":\"保险公司联系电话\",\"columnId\":12,\"columnName\":\"company_contact_phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isI','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:10:07',55),(107,'字典类型',1,'com.ruoyi.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"企业是否涉及进出口贸易\",\"dictType\":\"insurance_import_export\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:11:52',5),(108,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"是\",\"dictSort\":1,\"dictType\":\"insurance_import_export\",\"dictValue\":\"是\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:11:59',3),(109,'字典数据',1,'com.ruoyi.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"否\",\"dictSort\":2,\"dictType\":\"insurance_import_export\",\"dictValue\":\"否\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:12:06',6),(110,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"product\",\"className\":\"TblInsuranceProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"保险产品ID\",\"columnId\":9,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:10:07\",\"usableColumn\":false},{\"capJavaField\":\"CompanyName\",\"columnComment\":\"保险公司名称\",\"columnId\":10,\"columnName\":\"company_name\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"companyName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:10:07\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactName\",\"columnComment\":\"保险公司联系人姓名\",\"columnId\":11,\"columnName\":\"company_contact_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"companyContactName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:10:07\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactPhone\",\"columnComment\":\"保险公司联系电话\",\"columnId\":12,\"columnName\":\"company_contact_phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:14:30',32),(111,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tbl_insurance_product\"}',NULL,0,NULL,'2025-10-28 14:14:37',202),(112,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"product\",\"className\":\"TblInsuranceProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"保险产品ID\",\"columnId\":9,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:14:30\",\"usableColumn\":false},{\"capJavaField\":\"CompanyName\",\"columnComment\":\"保险公司名称\",\"columnId\":10,\"columnName\":\"company_name\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"companyName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:14:30\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactName\",\"columnComment\":\"保险公司联系人姓名\",\"columnId\":11,\"columnName\":\"company_contact_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"companyContactName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:14:30\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactPhone\",\"columnComment\":\"保险公司联系电话\",\"columnId\":12,\"columnName\":\"company_contact_phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:14:58',29),(113,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tbl_insurance_product\"}',NULL,0,NULL,'2025-10-28 14:15:02',54),(114,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"product\",\"className\":\"TblInsuranceProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"保险产品ID\",\"columnId\":9,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:14:58\",\"usableColumn\":false},{\"capJavaField\":\"CompanyName\",\"columnComment\":\"保险公司名称\",\"columnId\":10,\"columnName\":\"company_name\",\"columnType\":\"varchar(200)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"companyName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:14:58\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactName\",\"columnComment\":\"保险公司联系人姓名\",\"columnId\":11,\"columnName\":\"company_contact_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28 12:05:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"companyContactName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-10-28 14:14:58\",\"usableColumn\":false},{\"capJavaField\":\"CompanyContactPhone\",\"columnComment\":\"保险公司联系电话\",\"columnId\":12,\"columnName\":\"company_contact_phone\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-28','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:29:58',102),(115,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tbl_insurance_product\"}',NULL,0,NULL,'2025-10-28 14:30:02',219),(116,'保险产品',1,'com.ruoyi.system.controller.TblInsuranceProductController.add()','POST',1,'admin','研发部门','/system/product','127.0.0.1','内网IP','{\"annualFee\":\"10万以下\",\"companyAddress\":\"Test1\",\"companyContactName\":\"TTTT\",\"companyContactPhone\":\"178757786862\",\"companyName\":\"Test1\",\"coveredInsuranceTypes\":\"货物运输险,财产一切险\",\"coveredPotentialRisks\":\"重大资产损失导致停产\",\"coveredRisks\":\"自然灾害（火灾/洪水/地震等）,员工工伤事故,员工意外伤害,盗窃/抢劫,设备故障/停工,产品质量纠纷\",\"createTime\":\"2025-10-28 14:33:25\",\"id\":14,\"insuranceContactName\":\"Test1\",\"insuranceContactPhone\":\"17875786862\",\"insuranceName\":\"Test1\",\"insuranceType\":\"财险\",\"params\":{},\"riskTransferTypes\":\"企业自身财产损失\",\"targetAssets\":\"厂房/仓库,运输车辆,办公设备,存货（原材料/成品）\",\"targetCapital\":\"500万以下\",\"targetEmployees\":\"50人以下\",\"targetEquipment\":\"以上设备或场景均没有,危险化学品存储,高压/高温设备\",\"targetImportExport\":\"是\",\"targetIndustry\":\"食品加工业\",\"targetRevenue\":\"500万以下\",\"targetYears\":\"1年以下\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:33:25',112),(117,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/product/index\",\"createTime\":\"2025-10-28 14:15:51\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"保险产品\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"product\",\"perms\":\"system:product:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-10-28 14:34:37',20);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2025-10-27 17:04:59','',NULL,''),(2,'se','项目经理',2,'0','admin','2025-10-27 17:04:59','',NULL,''),(3,'hr','人力资源',3,'0','admin','2025-10-27 17:04:59','',NULL,''),(4,'user','普通员工',4,'0','admin','2025-10-27 17:04:59','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2025-10-27 17:04:59','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2025-10-27 17:04:59','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','admin','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-10-28 13:44:18','2025-10-27 17:04:59','admin','2025-10-27 17:04:59','','2025-10-27 17:14:14','管理员'),(2,105,'ry','test2','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-10-27 17:04:59','2025-10-27 17:04:59','admin','2025-10-27 17:04:59','admin','2025-10-27 17:14:02','测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_company_basic`
--

DROP TABLE IF EXISTS `tbl_company_basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_company_basic` (
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业基本信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_company_basic`
--

LOCK TABLES `tbl_company_basic` WRITE;
/*!40000 ALTER TABLE `tbl_company_basic` DISABLE KEYS */;
INSERT INTO `tbl_company_basic` VALUES (10,5,'kk','17875786862','','2025-10-27 22:08:14','2025-10-27 22:08:14','kll',''),(11,4,'41','17875786862','','2025-10-27 22:49:42','2025-10-27 22:49:42','214','');
/*!40000 ALTER TABLE `tbl_company_basic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_company_detail`
--

DROP TABLE IF EXISTS `tbl_company_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_company_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详细信息ID',
  `company_id` bigint NOT NULL COMMENT '企业ID',
  `industry` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属行业',
  `insurance_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '期望购买的保险类型',
  `established_years` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '成立年限',
  `employee_count` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '员工总数',
  `annual_revenue` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '年营业额',
  `registered_capital` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '注册资本金',
  `has_import_export` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否涉及进出口贸易',
  `main_assets` text COLLATE utf8mb4_unicode_ci COMMENT '主要资产（多选，逗号分隔）',
  `special_equipment` text COLLATE utf8mb4_unicode_ci COMMENT '特殊设备或场景（多选，逗号分隔）',
  `purchased_insurance` text COLLATE utf8mb4_unicode_ci COMMENT '已购买的保险类型（多选，逗号分隔）',
  `risk_coverage` text COLLATE utf8mb4_unicode_ci COMMENT '希望覆盖的风险（多选，逗号分隔）',
  `potential_risk` text COLLATE utf8mb4_unicode_ci COMMENT '希望覆盖的潜在风险（多选，逗号分隔）',
  `risk_transfer` text COLLATE utf8mb4_unicode_ci COMMENT '希望转移的风险责任（多选，逗号分隔）',
  `annual_budget` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '年度保险费用预算',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_company_id` (`company_id`),
  KEY `idx_insurance_type` (`insurance_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_company_detail`
--

LOCK TABLES `tbl_company_detail` WRITE;
/*!40000 ALTER TABLE `tbl_company_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_company_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_insurance_favorite`
--

DROP TABLE IF EXISTS `tbl_insurance_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_insurance_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `insurance_id` bigint NOT NULL COMMENT '保险产品ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_insurance` (`user_id`,`insurance_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_insurance_id` (`insurance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='保险收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_insurance_favorite`
--

LOCK TABLES `tbl_insurance_favorite` WRITE;
/*!40000 ALTER TABLE `tbl_insurance_favorite` DISABLE KEYS */;
INSERT INTO `tbl_insurance_favorite` VALUES (11,4,5,'2025-10-27 21:42:33'),(12,4,4,'2025-10-27 21:42:33'),(13,4,7,'2025-10-27 21:42:35'),(14,4,9,'2025-10-27 21:42:36'),(15,4,10,'2025-10-27 21:42:37'),(16,4,8,'2025-10-27 22:05:27'),(17,4,1,'2025-10-27 22:05:38'),(19,5,2,'2025-10-27 22:06:30'),(23,5,8,'2025-10-27 22:09:42');
/*!40000 ALTER TABLE `tbl_insurance_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_insurance_product`
--

DROP TABLE IF EXISTS `tbl_insurance_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_insurance_product` (
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='保险产品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_insurance_product`
--

LOCK TABLES `tbl_insurance_product` WRITE;
/*!40000 ALTER TABLE `tbl_insurance_product` DISABLE KEYS */;
INSERT INTO `tbl_insurance_product` VALUES (1,'中国人保财险','张经理','13800138000','北京市朝阳区建国门外大街2号','企业财产综合险','李顾问','13900139000','寿险','家具制造业','3-5年','50人以下','500万以下','500万以下','厂房/仓库,办公设备,生产设备/流水线,运输车辆,存货（原材料/成品）','高压/高温设备,精密仪器,高空作业','否','财产一切险,公众责任险,雇主责任险','自然灾害（火灾/洪水/地震等）,盗窃/抢劫','重大资产损失导致停产,高额赔偿责任（如客户/公众伤害）','企业自身财产损失,第三方人身/财产损害赔偿责任','10万以下','适合中型制造企业','2025-10-21 11:50:00','2025-10-23 17:58:08'),(2,'平安保险','王经理','13700137000','深圳市福田区益田路5033号','雇主责任保险','赵顾问','13600136000','寿险','家具制造业','3-5年','50人以下','500万以下','500万以下','机器设备,运输工具','锅炉,压力容器,起重机械,叉车','否','雇主责任险,团体意外险','火灾,爆炸','员工伤亡,第三方责任','雇主责任','1万-5万','覆盖员工工伤意外','2025-10-21 11:50:00','2025-10-23 17:58:08'),(3,'太平洋保险','刘经理','13500135000','上海市黄浦区中山南路1号','货物运输保险','陈顾问','13400134000','寿险','家具制造业','3-5年','50人以下','500万以下','500万以下','存货商品,运输工具','无','是','货运保险','火灾,盗窃,抢劫','货物损失','财产损失','1万以下','适合进出口贸易企业','2025-10-21 11:50:00','2025-10-23 17:58:08'),(4,'中国人寿财险','李经理','13812345678','北京市海淀区中关村大街1号','企业财产综合险','周顾问','13912345678','寿险','家具制造业','3-5年','50人以下','500万以下','500万以下','厂房/仓库、存货（原材料/成品）','以上设备或场景均没有','否','财险','自然灾害（火灾/洪水/地震等）、盗窃/抢劫','重大资产损失导致停产','企业自身财产损失','10万以下','适合小型初创食品加工企业，保障基础财产安全','2025-10-22 09:30:00','2025-10-23 17:58:08'),(5,'中国平安财险','张经理','13712345678','上海市浦东新区陆家嘴环路100号','雇主责任保险','吴顾问','13612345678','财险','家具制造业','1年以下','50人以下','500万以下','500万以下','生产设备/流水线、办公设备','高空作业','是','寿险','员工工伤事故、员工意外伤害','高额赔偿责任（如客户/公众伤害）','员工工伤/职业病保障','10-30万','适配中小型家具制造企业，覆盖员工工伤风险','2025-10-22 09:35:00','2025-10-23 17:57:48'),(6,'太平洋财险','王经理','13512345678','广州市天河区珠江新城冼村路5号','货物运输保险','郑顾问','13412345678','财险','家具制造业','1年以下','50人以下','500万以下','500万以下','运输车辆、存货（原材料/成品）','以上设备或场景均没有','否','财险','盗窃/抢劫、覆盖其他风险','货物运输途中的风险','货物运输途中的风险','30-50万','适合中型物流运输企业，保障货物运输安全','2025-10-22 09:40:00','2025-10-23 17:56:07'),(7,'中国大地保险','刘经理','13823456789','深圳市南山区科技园南区10号','机器损坏保险','孙顾问','13923456789','财险','家具制造业','1年以下','50人以下','500万以下','500万以下','生产设备/流水线、厂房/仓库','高压/高温设备','是','财险','设备故障/停工、自然灾害（火灾/洪水/地震等）','重大资产损失导致停产','企业自身财产损失','50万以上','适配大型造纸企业，重点保障生产设备安全','2025-10-22 09:45:00','2025-10-23 17:56:07'),(8,'阳光财险','陈经理','13723456789','杭州市西湖区天目山路18号','产品责任保险','马顾问','13623456789','财险','家具制造业','1年以下','50人以下','500万以下','500万以下','生产设备/流水线、其它资产','精密仪器','否','财险','产品质量纠纷、法律诉讼','高额赔偿责任（如客户/公众伤害）','第三方人身/财产损害赔偿责任','10万以下','适合小型塑料制品企业，规避产品质量纠纷风险','2025-10-22 09:50:00','2025-10-23 17:56:07'),(9,'泰康在线','赵经理','13523456789','成都市锦江区东大街芷泉段229号','团体意外伤害保险','朱顾问','13423456789','财险','家具制造业','1年以下','50人以下','500万以下','500万以下','办公设备、存货（原材料/成品）','以上设备或场景均没有','否','寿险','员工意外伤害、覆盖其他风险','关键技术人员意外风险','员工工伤/职业病保障','10-30万','适配中小型纺织企业，保障员工意外安全','2025-10-22 09:55:00','2025-10-23 17:57:48'),(10,'新华保险','周经理','13834567890','武汉市江汉区解放大道688号','仓储财产保险','吴顾问','13934567890','财险','仓储类','3-5年','200-500人','3000万-1亿','3000万-1亿','仓库、存货（原材料/成品）','危险化学品存储','是','财险','盗窃/抢劫、自然灾害（火灾/洪水/地震等）','重大资产损失导致停产','企业自身财产损失','30-50万','适合中型仓储企业，保障仓储货物及场地安全','2025-10-22 10:00:00','2025-10-22 10:00:00'),(11,'太平财险','吴经理','13734567890','南京市玄武区中山路18号','车辆损失保险','郑顾问','13634567890','财险','物流运输','5年以上','500人以上','1亿以上','1亿以上','运输车辆、其它资产','以上设备或场景均没有','否','财险','覆盖其他风险、盗窃/抢劫','货物运输途中的风险','货物运输途中的风险','50万以上','适配大型物流企业，重点保障运输车辆安全','2025-10-22 10:05:00','2025-10-22 10:05:00'),(12,'中华联合财险','郑经理','13534567890','西安市雁塔区长安南路493号','企业综合保障保险','孙顾问','13434567890','财险','木制品生产','1年以下','50人以下','500万以下','500万以下','厂房/仓库、生产设备/流水线','高空作业','否','财险','自然灾害（火灾/洪水/地震等）、设备故障/停工','重大资产损失导致停产','企业自身财产损失','10万以下','适合小型木制品企业，提供综合财产保障','2025-10-22 10:10:00','2025-10-22 10:10:00'),(13,'天安财险','孙经理','13845678901','重庆市渝中区解放碑邹容路100号','职业责任保险','马顾问','13945678901','寿险','其他行业','1-3年','50-200人','500万-3000万','500万-3000万','办公设备、其它资产','数据服务器机房','是','寿险','法律诉讼、覆盖其他风险','高额赔偿责任（如客户/公众伤害）','相关诉讼法律费用','10-30万','适配中小型综合类企业，规避职业责任纠纷风险','2025-10-22 10:15:00','2025-10-22 10:15:00'),(14,'Test1','TTTT','178757786862','Test1','Test1','Test1','17875786862','财险','食品加工业','1年以下','50人以下','500万以下','500万以下','厂房/仓库,运输车辆,办公设备,存货（原材料/成品）','以上设备或场景均没有,危险化学品存储,高压/高温设备','是','货物运输险,财产一切险','自然灾害（火灾/洪水/地震等）,员工工伤事故,员工意外伤害,盗窃/抢劫,设备故障/停工,产品质量纠纷','重大资产损失导致停产','企业自身财产损失','10万以下',NULL,'2025-10-28 14:33:26','2025-10-28 14:33:25');
/*!40000 ALTER TABLE `tbl_insurance_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_match_record`
--

DROP TABLE IF EXISTS `tbl_match_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_match_record` (
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
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='匹配记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_match_record`
--

LOCK TABLES `tbl_match_record` WRITE;
/*!40000 ALTER TABLE `tbl_match_record` DISABLE KEYS */;
INSERT INTO `tbl_match_record` VALUES (1,4,1,30.00,'行业高度匹配；风险覆盖全面','2025-10-21 17:34:17'),(2,4,2,50.00,'行业高度匹配；资产类型匹配；风险覆盖全面','2025-10-21 17:34:17'),(3,4,3,25.00,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:34:17'),(4,4,1,10.00,'风险覆盖全面','2025-10-21 17:35:13'),(5,4,2,25.00,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:13'),(6,4,3,17.50,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:13'),(7,4,1,16.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:28'),(8,4,2,21.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:28'),(9,4,3,10.83,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:28'),(10,4,1,16.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:29'),(11,4,2,21.67,'资产类型匹配；风险覆盖全面','2025-10-21 17:35:29'),(12,4,3,10.83,'资产类型匹配；支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:29'),(13,4,1,15.00,'风险覆盖全面','2025-10-21 17:35:46'),(14,4,2,10.00,'风险覆盖全面','2025-10-21 17:35:46'),(15,4,3,12.50,'支持进出口贸易企业；风险覆盖全面','2025-10-21 17:35:46'),(16,4,1,15.00,'风险覆盖全面','2025-10-21 21:55:59'),(17,4,2,7.00,'风险覆盖全面','2025-10-21 21:55:59'),(18,4,3,13.50,'支持进出口贸易企业；风险覆盖全面','2025-10-21 21:55:59'),(19,4,1,15.00,'风险覆盖全面','2025-10-21 21:56:47'),(20,4,2,7.00,'风险覆盖全面','2025-10-21 21:56:47'),(21,4,3,13.50,'支持进出口贸易企业；风险覆盖全面','2025-10-21 21:56:47'),(22,4,1,0.00,'基本符合企业保险需求','2025-10-21 22:40:26'),(23,4,2,0.00,'基本符合企业保险需求','2025-10-21 22:40:26'),(24,4,3,5.00,'支持进出口贸易企业','2025-10-21 22:40:26'),(25,4,1,0.00,'基本符合企业保险需求','2025-10-21 22:40:50'),(26,4,2,0.00,'基本符合企业保险需求','2025-10-21 22:40:50'),(27,4,3,5.00,'支持进出口贸易企业','2025-10-21 22:40:50'),(28,4,1,0.00,'基本符合企业保险需求','2025-10-21 22:40:51'),(29,4,2,0.00,'基本符合企业保险需求','2025-10-21 22:40:51'),(30,4,3,5.00,'支持进出口贸易企业','2025-10-21 22:40:51'),(31,4,1,5.00,'基本符合企业保险需求','2025-10-21 22:41:06'),(32,4,2,5.00,'基本符合企业保险需求','2025-10-21 22:41:06'),(33,4,3,0.00,'基本符合企业保险需求','2025-10-21 22:41:06'),(34,4,1,5.00,'基本符合企业保险需求','2025-10-21 23:12:19'),(35,4,2,5.00,'基本符合企业保险需求','2025-10-21 23:12:19'),(36,4,3,0.00,'基本符合企业保险需求','2025-10-21 23:12:19'),(37,4,1,5.00,'基本符合企业保险需求','2025-10-21 23:12:20'),(38,4,2,5.00,'基本符合企业保险需求','2025-10-21 23:12:20'),(39,4,3,0.00,'基本符合企业保险需求','2025-10-21 23:12:20'),(40,4,1,5.00,'基本符合企业保险需求','2025-10-21 23:12:26'),(41,4,2,5.00,'基本符合企业保险需求','2025-10-21 23:12:26'),(42,4,3,0.00,'基本符合企业保险需求','2025-10-21 23:12:26'),(43,5,1,5.00,'基本符合企业保险需求','2025-10-22 00:04:27'),(44,5,2,5.00,'基本符合企业保险需求','2025-10-22 00:04:27'),(45,5,3,0.00,'基本符合企业保险需求','2025-10-22 00:04:27'),(46,6,1,0.00,'基本符合企业保险需求','2025-10-22 11:27:11'),(47,6,2,0.00,'基本符合企业保险需求','2025-10-22 11:27:11'),(48,6,3,5.00,'支持进出口贸易企业','2025-10-22 11:27:11'),(49,6,1,0.00,'基本符合企业保险需求','2025-10-22 11:31:14'),(50,6,2,0.00,'基本符合企业保险需求','2025-10-22 11:31:14'),(51,6,3,5.00,'支持进出口贸易企业','2025-10-22 11:31:14'),(52,6,1,0.00,'基本符合企业保险需求','2025-10-22 11:31:29'),(53,6,2,0.00,'基本符合企业保险需求','2025-10-22 11:31:29'),(54,6,3,5.00,'支持进出口贸易企业','2025-10-22 11:31:29'),(55,6,1,0.00,'基本符合企业保险需求','2025-10-22 11:33:02'),(56,6,2,0.00,'基本符合企业保险需求','2025-10-22 11:33:02'),(57,6,3,5.00,'支持进出口贸易企业','2025-10-22 11:33:02'),(58,6,1,0.00,'基本符合企业保险需求','2025-10-22 11:33:07'),(59,6,2,0.00,'基本符合企业保险需求','2025-10-22 11:33:07'),(60,6,3,5.00,'支持进出口贸易企业','2025-10-22 11:33:07'),(61,6,1,0.00,'基本符合企业保险需求','2025-10-22 11:33:08'),(62,6,2,0.00,'基本符合企业保险需求','2025-10-22 11:33:08'),(63,6,3,5.00,'支持进出口贸易企业','2025-10-22 11:33:08'),(64,6,1,0.00,'基本符合企业保险需求','2025-10-22 12:13:12'),(65,6,2,0.00,'基本符合企业保险需求','2025-10-22 12:13:12'),(66,6,3,5.00,'支持进出口贸易企业','2025-10-22 12:13:12'),(67,6,1,0.00,'基本符合企业保险需求','2025-10-22 13:18:59'),(68,6,2,0.00,'基本符合企业保险需求','2025-10-22 13:18:59'),(69,6,3,5.00,'支持进出口贸易企业','2025-10-22 13:18:59'),(70,6,1,0.00,'基本符合企业保险需求','2025-10-22 13:19:00'),(71,6,2,0.00,'基本符合企业保险需求','2025-10-22 13:19:00'),(72,6,3,5.00,'支持进出口贸易企业','2025-10-22 13:19:00'),(73,6,1,0.00,'基本符合企业保险需求','2025-10-22 13:32:09'),(74,6,2,0.00,'基本符合企业保险需求','2025-10-22 13:32:09'),(75,6,3,5.00,'支持进出口贸易企业','2025-10-22 13:32:09'),(76,6,1,0.00,'基本符合企业保险需求','2025-10-23 13:02:33'),(77,6,2,0.00,'基本符合企业保险需求','2025-10-23 13:02:33'),(78,6,3,5.00,'支持进出口贸易企业','2025-10-23 13:02:33'),(79,6,1,0.00,'基本符合企业保险需求','2025-10-23 13:22:29'),(80,6,2,0.00,'基本符合企业保险需求','2025-10-23 13:22:29'),(81,6,3,5.00,'支持进出口贸易企业','2025-10-23 13:22:29'),(82,6,1,0.00,'基本符合企业保险需求','2025-10-23 13:48:18'),(83,6,2,0.00,'基本符合企业保险需求','2025-10-23 13:48:18'),(84,6,3,5.00,'支持进出口贸易企业','2025-10-23 13:48:18'),(85,6,4,65.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:48:18'),(86,6,5,5.00,'支持进出口贸易企业','2025-10-23 13:48:18'),(87,6,6,0.00,'基本符合企业保险需求','2025-10-23 13:48:18'),(88,6,7,10.00,'支持进出口贸易企业','2025-10-23 13:48:18'),(89,6,8,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:48:18'),(90,6,9,5.00,'基本符合企业保险需求','2025-10-23 13:48:18'),(91,6,10,5.00,'支持进出口贸易企业','2025-10-23 13:48:18'),(92,6,11,0.00,'基本符合企业保险需求','2025-10-23 13:48:18'),(93,6,12,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:48:18'),(94,6,13,5.00,'支持进出口贸易企业','2025-10-23 13:48:18'),(95,6,1,0.00,'基本符合企业保险需求','2025-10-23 13:48:20'),(96,6,2,0.00,'基本符合企业保险需求','2025-10-23 13:48:20'),(97,6,3,5.00,'支持进出口贸易企业','2025-10-23 13:48:20'),(98,6,4,65.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:48:20'),(99,6,5,5.00,'支持进出口贸易企业','2025-10-23 13:48:20'),(100,6,6,0.00,'基本符合企业保险需求','2025-10-23 13:48:20'),(101,6,7,10.00,'支持进出口贸易企业','2025-10-23 13:48:20'),(102,6,8,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:48:20'),(103,6,9,5.00,'基本符合企业保险需求','2025-10-23 13:48:20'),(104,6,10,5.00,'支持进出口贸易企业','2025-10-23 13:48:20'),(105,6,11,0.00,'基本符合企业保险需求','2025-10-23 13:48:20'),(106,6,12,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:48:20'),(107,6,13,5.00,'支持进出口贸易企业','2025-10-23 13:48:20'),(108,6,1,0.00,'基本符合企业保险需求','2025-10-23 13:51:26'),(109,6,2,0.00,'基本符合企业保险需求','2025-10-23 13:51:26'),(110,6,3,5.00,'支持进出口贸易企业','2025-10-23 13:51:26'),(111,6,4,65.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:51:26'),(112,6,5,5.00,'支持进出口贸易企业','2025-10-23 13:51:26'),(113,6,6,0.00,'基本符合企业保险需求','2025-10-23 13:51:26'),(114,6,7,10.00,'支持进出口贸易企业','2025-10-23 13:51:26'),(115,6,8,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:51:26'),(116,6,9,5.00,'基本符合企业保险需求','2025-10-23 13:51:26'),(117,6,10,5.00,'支持进出口贸易企业','2025-10-23 13:51:26'),(118,6,11,0.00,'基本符合企业保险需求','2025-10-23 13:51:26'),(119,6,12,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:51:26'),(120,6,13,5.00,'支持进出口贸易企业','2025-10-23 13:51:26'),(121,6,1,0.00,'基本符合企业保险需求','2025-10-23 13:51:27'),(122,6,2,0.00,'基本符合企业保险需求','2025-10-23 13:51:28'),(123,6,3,5.00,'支持进出口贸易企业','2025-10-23 13:51:28'),(124,6,4,65.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:51:28'),(125,6,5,5.00,'支持进出口贸易企业','2025-10-23 13:51:28'),(126,6,6,0.00,'基本符合企业保险需求','2025-10-23 13:51:28'),(127,6,7,10.00,'支持进出口贸易企业','2025-10-23 13:51:28'),(128,6,8,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:51:28'),(129,6,9,5.00,'基本符合企业保险需求','2025-10-23 13:51:28'),(130,6,10,5.00,'支持进出口贸易企业','2025-10-23 13:51:28'),(131,6,11,0.00,'基本符合企业保险需求','2025-10-23 13:51:28'),(132,6,12,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 13:51:28'),(133,6,13,5.00,'支持进出口贸易企业','2025-10-23 13:51:28'),(134,6,1,65.00,'员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 14:03:51'),(135,6,2,0.00,'基本符合企业保险需求','2025-10-23 14:03:51'),(136,6,3,5.00,'支持进出口贸易企业','2025-10-23 14:03:51'),(137,6,4,65.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:03:51'),(138,6,5,5.00,'支持进出口贸易企业','2025-10-23 14:03:51'),(139,6,6,0.00,'基本符合企业保险需求','2025-10-23 14:03:51'),(140,6,7,10.00,'支持进出口贸易企业','2025-10-23 14:03:51'),(141,6,8,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:03:51'),(142,6,9,5.00,'基本符合企业保险需求','2025-10-23 14:03:51'),(143,6,10,5.00,'支持进出口贸易企业','2025-10-23 14:03:51'),(144,6,11,0.00,'基本符合企业保险需求','2025-10-23 14:03:51'),(145,6,12,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:03:51'),(146,6,13,5.00,'支持进出口贸易企业','2025-10-23 14:03:51'),(147,6,1,65.00,'员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 14:03:53'),(148,6,2,0.00,'基本符合企业保险需求','2025-10-23 14:03:53'),(149,6,3,5.00,'支持进出口贸易企业','2025-10-23 14:03:53'),(150,6,4,65.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:03:53'),(151,6,5,5.00,'支持进出口贸易企业','2025-10-23 14:03:53'),(152,6,6,0.00,'基本符合企业保险需求','2025-10-23 14:03:53'),(153,6,7,10.00,'支持进出口贸易企业','2025-10-23 14:03:53'),(154,6,8,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:03:53'),(155,6,9,5.00,'基本符合企业保险需求','2025-10-23 14:03:53'),(156,6,10,5.00,'支持进出口贸易企业','2025-10-23 14:03:53'),(157,6,11,0.00,'基本符合企业保险需求','2025-10-23 14:03:53'),(158,6,12,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:03:53'),(159,6,13,5.00,'支持进出口贸易企业','2025-10-23 14:03:53'),(160,6,1,95.00,'行业高度匹配；员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 14:05:18'),(161,6,2,0.00,'基本符合企业保险需求','2025-10-23 14:05:18'),(162,6,3,5.00,'支持进出口贸易企业','2025-10-23 14:05:18'),(163,6,4,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:05:18'),(164,6,5,35.00,'行业高度匹配；支持进出口贸易企业','2025-10-23 14:05:18'),(165,6,6,0.00,'基本符合企业保险需求','2025-10-23 14:05:18'),(166,6,7,10.00,'支持进出口贸易企业','2025-10-23 14:05:18'),(167,6,8,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:05:18'),(168,6,9,5.00,'基本符合企业保险需求','2025-10-23 14:05:18'),(169,6,10,5.00,'支持进出口贸易企业','2025-10-23 14:05:18'),(170,6,11,0.00,'基本符合企业保险需求','2025-10-23 14:05:18'),(171,6,12,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:05:18'),(172,6,13,5.00,'支持进出口贸易企业','2025-10-23 14:05:18'),(173,6,1,65.00,'员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 14:06:37'),(174,6,2,0.00,'基本符合企业保险需求','2025-10-23 14:06:37'),(175,6,3,5.00,'支持进出口贸易企业','2025-10-23 14:06:37'),(176,6,4,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:06:37'),(177,6,5,5.00,'支持进出口贸易企业','2025-10-23 14:06:37'),(178,6,6,0.00,'基本符合企业保险需求','2025-10-23 14:06:37'),(179,6,7,40.00,'行业高度匹配；支持进出口贸易企业','2025-10-23 14:06:37'),(180,6,8,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:06:37'),(181,6,9,5.00,'基本符合企业保险需求','2025-10-23 14:06:37'),(182,6,10,5.00,'支持进出口贸易企业','2025-10-23 14:06:37'),(183,6,11,0.00,'基本符合企业保险需求','2025-10-23 14:06:37'),(184,6,12,35.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 14:06:37'),(185,6,13,5.00,'支持进出口贸易企业','2025-10-23 14:06:37'),(186,6,1,60.00,'员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 17:47:18'),(187,6,2,0.00,'基本符合企业保险需求','2025-10-23 17:47:18'),(188,6,3,5.00,'支持进出口贸易企业','2025-10-23 17:47:18'),(189,6,4,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:47:18'),(190,6,5,5.00,'支持进出口贸易企业','2025-10-23 17:47:18'),(191,6,6,0.00,'基本符合企业保险需求','2025-10-23 17:47:18'),(192,6,7,30.00,'行业高度匹配；支持进出口贸易企业','2025-10-23 17:47:18'),(193,6,8,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:47:18'),(194,6,9,5.00,'基本符合企业保险需求','2025-10-23 17:47:18'),(195,6,10,5.00,'支持进出口贸易企业','2025-10-23 17:47:18'),(196,6,11,0.00,'基本符合企业保险需求','2025-10-23 17:47:18'),(197,6,12,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:47:18'),(198,6,13,5.00,'支持进出口贸易企业','2025-10-23 17:47:18'),(199,6,1,60.00,'员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 17:47:43'),(200,6,2,0.00,'基本符合企业保险需求','2025-10-23 17:47:43'),(201,6,3,5.00,'支持进出口贸易企业','2025-10-23 17:47:43'),(202,6,4,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:47:43'),(203,6,5,5.00,'支持进出口贸易企业','2025-10-23 17:47:43'),(204,6,6,0.00,'基本符合企业保险需求','2025-10-23 17:47:43'),(205,6,7,30.00,'行业高度匹配；支持进出口贸易企业','2025-10-23 17:47:43'),(206,6,8,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:47:43'),(207,6,9,5.00,'基本符合企业保险需求','2025-10-23 17:47:43'),(208,6,10,5.00,'支持进出口贸易企业','2025-10-23 17:47:43'),(209,6,11,0.00,'基本符合企业保险需求','2025-10-23 17:47:43'),(210,6,12,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:47:43'),(211,6,13,5.00,'支持进出口贸易企业','2025-10-23 17:47:43'),(212,6,1,80.00,'行业高度匹配；员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 17:48:04'),(213,6,2,0.00,'基本符合企业保险需求','2025-10-23 17:48:04'),(214,6,3,5.00,'支持进出口贸易企业','2025-10-23 17:48:04'),(215,6,4,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:48:04'),(216,6,5,25.00,'行业高度匹配；支持进出口贸易企业','2025-10-23 17:48:04'),(217,6,6,0.00,'基本符合企业保险需求','2025-10-23 17:48:04'),(218,6,7,10.00,'支持进出口贸易企业','2025-10-23 17:48:04'),(219,6,8,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:48:04'),(220,6,9,5.00,'基本符合企业保险需求','2025-10-23 17:48:04'),(221,6,10,5.00,'支持进出口贸易企业','2025-10-23 17:48:04'),(222,6,11,0.00,'基本符合企业保险需求','2025-10-23 17:48:04'),(223,6,12,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:48:04'),(224,6,13,5.00,'支持进出口贸易企业','2025-10-23 17:48:04'),(225,6,1,80.00,'行业高度匹配；员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 17:48:05'),(226,6,2,0.00,'基本符合企业保险需求','2025-10-23 17:48:05'),(227,6,3,5.00,'支持进出口贸易企业','2025-10-23 17:48:05'),(228,6,4,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:48:05'),(229,6,5,25.00,'行业高度匹配；支持进出口贸易企业','2025-10-23 17:48:05'),(230,6,6,0.00,'基本符合企业保险需求','2025-10-23 17:48:05'),(231,6,7,10.00,'支持进出口贸易企业','2025-10-23 17:48:05'),(232,6,8,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:48:05'),(233,6,9,5.00,'基本符合企业保险需求','2025-10-23 17:48:05'),(234,6,10,5.00,'支持进出口贸易企业','2025-10-23 17:48:05'),(235,6,11,0.00,'基本符合企业保险需求','2025-10-23 17:48:05'),(236,6,12,45.00,'成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:48:05'),(237,6,13,5.00,'支持进出口贸易企业','2025-10-23 17:48:05'),(238,6,1,80.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 17:56:14'),(239,6,4,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:56:14'),(240,6,6,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:56:14'),(241,6,7,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 17:56:14'),(242,6,8,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:56:14'),(243,6,1,80.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；资产类型匹配；风险覆盖全面','2025-10-23 17:58:17'),(244,6,2,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:58:17'),(245,6,3,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 17:58:17'),(246,6,4,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:58:17'),(247,6,5,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 17:58:41'),(248,6,6,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:58:41'),(249,6,7,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 17:58:41'),(250,6,8,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:58:41'),(251,6,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 17:58:41'),(252,6,5,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 18:01:30'),(253,6,6,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 18:01:30'),(254,6,7,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 18:01:30'),(255,6,8,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 18:01:30'),(256,6,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 18:01:30'),(257,6,5,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 22:37:50'),(258,6,6,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 22:37:50'),(259,6,7,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；支持进出口贸易企业','2025-10-23 22:37:50'),(260,6,8,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 22:37:50'),(261,6,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-23 22:37:50'),(262,7,5,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:47:42'),(263,7,6,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:47:42'),(264,7,7,45.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:47:42'),(265,7,8,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:47:42'),(266,7,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:47:42'),(267,7,5,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:48:29'),(268,7,6,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:29'),(269,7,7,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:48:29'),(270,7,8,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:29'),(271,7,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:29'),(272,7,5,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:48:39'),(273,7,6,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:39'),(274,7,7,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:48:39'),(275,7,8,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:39'),(276,7,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:39'),(277,7,5,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:48:41'),(278,7,6,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:41'),(279,7,7,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合','2025-10-27 15:48:41'),(280,7,8,55.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:41'),(281,7,9,50.00,'行业高度匹配；成立年限符合要求；员工规模符合；营业额范围适合；不支持进出口贸易企业','2025-10-27 15:48:41');
/*!40000 ALTER TABLE `tbl_match_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-28 14:40:06
