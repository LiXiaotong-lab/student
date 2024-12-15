CREATE DATABASE  IF NOT EXISTS `educational_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `educational_system`;
-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: educational_system
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin123456','管理员','http://localhost:9090/files/1717603685063-1697438073596-avatar.png','ADMIN','13677889922','admin@xm.com');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arrange`
--

DROP TABLE IF EXISTS `arrange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arrange` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `courseId` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程编号',
  `teacherId` varchar(10) NOT NULL COMMENT '教师编号',
  PRIMARY KEY (`courseId`,`teacherId`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `teacherId1` (`teacherId`),
  KEY `courseId` (`courseId`),
  CONSTRAINT `courseId1` FOREIGN KEY (`courseId`) REFERENCES `course` (`courseId`),
  CONSTRAINT `teacherId1` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教师排课';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrange`
--

LOCK TABLES `arrange` WRITE;
/*!40000 ALTER TABLE `arrange` DISABLE KEYS */;
INSERT INTO `arrange` VALUES (36,'110011','20030523'),(38,'100010','20030523'),(40,'200020','20030523'),(41,'400040','20030523');
/*!40000 ALTER TABLE `arrange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `collegeId` varchar(10) NOT NULL COMMENT '学院编号',
  `name` varchar(30) NOT NULL COMMENT '学院名称',
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '学院描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `collegeId_UNIQUE` (`collegeId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学院表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college`
--

LOCK TABLES `college` WRITE;
/*!40000 ALTER TABLE `college` DISABLE KEYS */;
INSERT INTO `college` VALUES (1,'12345','管理科学与信息工程学院','管理科学与信息工程学院主要研究方向包括管理科学、信息系统、数据科学、运筹学、信息技术和工程管理等领域，致力于通过将管理学和信息技术相结合，培养能够在复杂商业环境中进行决策和管理的高素质人才。\n'),(2,'23456','信息技术学院','培养学生成为具有信息技术专业知识和技能的专业人士，能够适应信息化时代的需求，并在各种行业中发挥作用。'),(3,'34567','管理学院','旨在培养学生成为具有管理专业知识和技能的专业人士，能够在各种组织和行业中担任管理职位，解决实际管理问题，并推动组织的发展和创新。'),(4,'45678','金融学院','培养学生成为具有金融专业知识和技能的专业人士，能够在金融机构、投资公司、保险公司、企业财务部门等领域从事金融相关工作，参与金融市场的运作和管理。'),(5,'12340','计算机科学与技术学院','致力于培养学生在计算机科学与技术领域的专业知识和技能，能够应对信息技术领域的挑战和需求，参与科技创新和社会发展。'),(6,'23451','电子工程学院','旨在培养学生成为具有电子工程领域专业知识和技能的专业人士，能够在电子与通信领域从事科研、开发和应用工作，推动电子科技的发展与进步。'),(7,'34562','外国语学院','致力于培养学生的外语能力和跨文化交流能力，以及相关的语言文化知识，使其能够在国际化的背景下参与各种国际交流与合作活动。'),(8,'45673','法学院','旨在培养学生具备法律专业知识和法律实务能力，能够在法律领域从事法律实践、司法工作、法律咨询等相关工作，维护社会公平正义和法治秩序。'),(9,'56784','艺术与设计学院','致力于培养学生的艺术创造能力和设计实践能力，在美术、音乐、戏剧、设计等领域培养具有创新意识和审美能力的专业人才。'),(10,'67895','生命科学学院','旨在培养学生成为具有生命科学专业知识和实验技能的专业人士，能够从事生命科学研究、医药生物技术开发等相关工作，推动生命科学领域的发展。'),(11,'78906','教育学院','致力于培养具备教育理论和教育实践能力的专业人才，能够从事教育教学、教育管理、教育研究等相关工作，为教育事业发展贡献力量。'),(12,'89017','体育学院','旨在培养学生的体育专业知识和运动技能，培养具有体育教育、体育训练、运动科学等方面专业能力的人才，促进体育事业的发展。'),(13,'90128','心理学院','致力于培养学生的心理学专业知识和心理咨询能力，能够从事心理学研究、心理健康教育、心理咨询等相关工作，促进社会心理健康。'),(14,'01239','环境科学与工程学院','旨在培养学生具备环境科学与工程领域的专业知识和技能，能够从事环境保护、资源利用、环境工程设计等相关工作，推动环境保护和可持续发展。');
/*!40000 ALTER TABLE `college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `courseId` varchar(10) NOT NULL COMMENT '课程号',
  `Name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `creditHours` int NOT NULL COMMENT '学分',
  `majorId` varchar(45) NOT NULL,
  `syllabus` varchar(80) DEFAULT NULL COMMENT '课程大纲',
  `semester` varchar(45) NOT NULL COMMENT '学期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `courseId_UNIQUE` (`courseId`),
  KEY `majorId_idx` (`majorId`),
  CONSTRAINT `majorId1` FOREIGN KEY (`majorId`) REFERENCES `major` (`majorId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='课程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'100010','数据库系统',3,'080902','数据库系统课程的教学大纲包括数据库基本概念、关系数据库理论、SQL语言和数据库设计等内容。','2'),(2,'110011','操作系统',4,'080903','操作系统课程介绍了操作系统的原理、设计、实现和应用，包括进程管理、内存管理、文件系统等。','3'),(3,'120012','形式语言与自动机',3,'080901','形式语言与自动机课程涵盖了形式语言、自动机理论、文法理论、图灵机等相关内容。','2'),(4,'200020','计算机网络',4,'080901','计算机网络课程涵盖了网络基本概念、协议、网络层次结构、路由算法等内容。','3'),(5,'300030','人工智能导论',3,'080901','人工智能导论课程介绍了人工智能的基本概念、方法和应用，涵盖了搜索算法、机器学习等内容。','4'),(6,'400040','软件工程',3,'080901','软件工程课程介绍了软件开发的基本原理、方法和流程，包括需求分析、设计、测试等阶段。','4'),(7,'500050','C++程序设计',3,'080901','C++程序设计课程介绍了C++语言的基本语法、面向对象编程、数据结构和算法等内容。','2'),(8,'600060','离散数学',3,'080901','离散数学课程讲解了数理逻辑、集合论、图论、计数原理等离散数学基础知识。','1'),(9,'700070','数据结构',4,'080901','数据结构课程介绍了常见的数据结构，如链表、栈、队列、树、图等，并讲解了相关的算法。','3'),(10,'800080','计算机组成原理',4,'080901','计算机组成原理课程涵盖了计算机硬件组成、指令集体系结构、CPU设计、存储器层次结构等内容。','1'),(11,'900090','计算机导论',3,'080901','计算机导论课程介绍了计算机的基本概念、发展历程、工作原理以及计算机科学的基础知识。','1'),(12,'373295','软件工程',3,'080902','软件工程课程的教学大纲包括软件开发生命周期、软件需求分析、软件设计、软件测试、软件项目管理等内容。','4'),(13,'705208','数据库系统',3,'080902','数据库系统课程的教学大纲包括数据库基本概念、关系数据库理论、SQL语言和数据库设计等内容。','4'),(14,'637717','计算机网络',2,'080902','计算机网络课程的教学大纲包括网络体系结构、网络协议、网络安全、无线网络和网络编程等内容。','7'),(15,'676843','心理学导论',2,'080921','心理学导论课程的教学大纲包括心理学的基本概念、主要理论流派、心理学研究方法、感知觉、记忆和学习等内容。','1'),(16,'229115','发展心理学',3,'080921','发展心理学课程的教学大纲包括人类发展的各个阶段、认知发展、情感发展、社会性发展、人格发展等内容。','2'),(17,'254443','生物科学导论',2,'080918','生物科学导论课程的教学大纲包括细胞生物学、遗传学、进化生物学、生态学、生物技术等内容。','5'),(18,'869401','遗传学',2,'080918','遗传学课程的教学大纲包括遗传的基本原理、基因表达与调控、分子遗传学、群体遗传学等内容。','3'),(19,'782219','微生物学',3,'080918','微生物学课程的教学大纲包括微生物的形态结构、代谢、遗传、分类和应用等内容。','7'),(20,'603771','企业管理',1,'080932','企业管理课程的教学大纲包括企业的组织结构、管理理论、战略管理、人力资源管理、市场营销等内容。','7'),(22,'942429','财务管理',1,'080932','财务管理课程的教学大纲包括财务报表分析、预算管理、成本控制、资金管理、投资决策等内容。','7'),(23,'485715','金融学',1,'080912','金融学课程的教学大纲包括金融市场、金融机构、投资学、货币银行学、国际金融等内容。','6'),(24,'111642','投资学',4,'080912','投资学课程的教学大纲包括证券投资、投资组合管理、风险管理、资本市场理论等内容。','4'),(25,'517091','国际金融',1,'080933','国际金融课程的教学大纲包括国际金融市场、国际收支、汇率理论与政策、跨国金融管理等内容。','6'),(26,'753025','金融风险管理',2,'080933','金融风险管理课程的教学大纲包括风险识别、风险评估、风险控制、衍生工具、风险管理策略等内容。','4'),(28,'214728','国际贸易',2,'080933','国际贸易课程的教学大纲包括国际贸易理论、国际贸易政策、国际贸易实务、国际结算等内容。','1'),(29,'802602','宏观经济学',2,'080933','宏观经济学课程的教学大纲包括国民收入核算、经济增长、失业、通货膨胀、经济周期等内容。','1'),(30,'110575','微观经济学',4,'080933','微观经济学课程的教学大纲包括需求供给理论、消费者行为、生产成本、市场结构等内容。','6');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `live`
--

DROP TABLE IF EXISTS `live`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topic` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `chief` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `topic_UNIQUE` (`topic`),
  KEY `teacherId` (`chief`),
  CONSTRAINT `teacherId` FOREIGN KEY (`chief`) REFERENCES `teacher` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `live`
--

LOCK TABLES `live` WRITE;
/*!40000 ALTER TABLE `live` DISABLE KEYS */;
INSERT INTO `live` VALUES (1,'学生课堂实况','2024-05-16 10:00:00','20030523'),(2,'校园参观','2024-05-08 15:00:00','20091129'),(3,'食堂做饭实况','2024-05-22 11:00:00','20140618');
/*!40000 ALTER TABLE `live` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `id` int NOT NULL AUTO_INCREMENT,
  `majorId` varchar(10) NOT NULL COMMENT '专业编号',
  `name` varchar(45) NOT NULL COMMENT '专业名',
  `description` varchar(100) DEFAULT NULL,
  `collegeId` varchar(10) NOT NULL COMMENT '所属学院（学院外键）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `majorId_UNIQUE` (`majorId`),
  KEY `collegeId_idx` (`collegeId`),
  CONSTRAINT `collegeId` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='专业';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (1,'080901','计算机科学与技术','计算机科学与技术专业旨在培养具有扎实的计算机科学基础、系统的软件工程理论知识和较强的软件开发与管理能力的专业人才。','12345'),(2,'080902','软件工程','软件工程专业旨在培养具有扎实的计算机科学基础、系统的软件工程理论知识和较强的软件开发与管理能力的专业人才。','12345'),(3,'080932','管理学','管理学专业旨在培养具备管理、经济、法律及企业管理等方面的知识和能力，能够在工商企业、政府部门等单位从事管理、教学和科研工作的专业人才。','34567'),(4,'080903','数据科学与人工智能','数据科学与人工智能专业旨在培养能够处理和分析大数据、开发和应用人工智能技术的专业人才。','12340'),(5,'080904','网络工程','网络工程专业旨在培养具有扎实的计算机网络技术基础，能够进行网络规划、设计、管理和安全维护的专业人才。','12340'),(6,'080905','通信工程','通信工程专业旨在培养具有现代通信技术知识，能够从事通信系统设计、开发、运营和维护的专业人才。','23451'),(7,'080906','电子信息工程','电子信息工程专业旨在培养具有电子技术和信息系统基础，能够从事电子设备和信息系统设计、开发和维护的专业人才。','23451'),(8,'080907','集成电路设计与集成系统','集成电路设计与集成系统专业旨在培养具备集成电路设计、开发和系统集成能力的专业人才。','23451'),(9,'080908','英语','英语专业旨在培养具有扎实的英语语言基础、较强的英语实际应用能力及跨文化交际能力的专业人才，能够在教育、外事、经贸、文化等部门从事翻译、研究、教学等工作。','34562'),(10,'080909','日语','日语专业旨在培养具有扎实的日语语言基础和实际应用能力，能够在教育、外事、经贸、文化等领域从事翻译、研究、教学等工作的专业人才。','34562'),(11,'080910','法语','法语专业旨在培养具有扎实的法语语言基础和实际应用能力，能够在教育、外事、经贸、文化等领域从事翻译、研究、教学等工作的专业人才。','34562'),(12,'080911','法律','法学专业旨在培养具备法学理论知识和实务技能，能够在法律服务、司法机关、企事业单位从事法律工作的专业人才。','45673'),(13,'080912','经济法','经济法专业旨在培养具有经济法基础理论和实务技能的专业人才，能够在法律服务、司法机关、企事业单位从事经济法律工作的专业人才。','45673'),(14,'080933','金融学','金融学专业旨在培养具有扎实的经济学理论基础和金融实务技能，能够在银行、证券、投资、保险及其他经济管理部门从事相关工作的专业人才。','45678'),(15,'080914','美术','美术专业旨在培养具备美术理论知识和创作技能，能够从事美术创作、教育和研究的专业人才。','56784'),(16,'080915','音乐','音乐专业旨在培养具备音乐理论知识和表演技能，能够从事音乐表演、教育和研究的专业人才。','56784'),(17,'080916','设计','设计专业旨在培养具备设计理论知识和实践技能，能够从事视觉传达设计、产品设计、环境设计等工作的专业人才。','56784'),(18,'080917','生物科学','生物科学专业旨在培养具有扎实的生物学基础知识和实验技能，能够在生命科学研究、教育、生产和管理等领域从事相关工作的专业人才。','67895'),(19,'080918','生物技术','生物技术专业旨在培养具备生物技术基础知识和应用技能，能够在生物技术研发、生产和管理等领域工作的专业人才。','67895'),(20,'080919','生物信息学','生物信息学专业旨在培养具备生物信息分析和数据处理技能，能够在生物信息学研究和应用领域从事相关工作的专业人才。','67895'),(21,'080920','教育学','教育学专业旨在培养具备教育学、心理学基础理论及教育研究能力，能够在各级各类学校及教育机构从事教学、管理及科研工作的专业人才。','78906'),(22,'080921','心理学','心理学专业旨在培养具有心理学基础理论、研究方法及应用技能的专业人才，能够在教育、健康、社会服务等领域从事心理咨询与辅导等工作。','78906'),(23,'080922','教育心理学','教育心理学专业旨在培养具备教育心理学理论和应用技能的专业人才，能够在教育和心理咨询领域从事教学、研究和辅导工作的专业人才。','78906'),(24,'080923','体育教育','体育教育专业旨在培养具备体育教育理论知识和教学技能，能够在各级学校和体育机构从事体育教学、训练和管理工作的专业人才。','89017'),(25,'080924','体育训练','体育训练专业旨在培养具备体育训练理论和实践技能的专业人才，能够从事竞技体育训练、教学和科研工作的专业人才。','89017'),(26,'080925','运动科学','运动科学专业旨在培养具备运动科学基础理论和实验技能的专业人才，能够在体育科研、教学和管理领域从事相关工作的专业人才。','89017'),(27,'080926','心理咨询','心理咨询专业旨在培养具有心理咨询理论和实务技能的专业人才，能够在教育、医疗、社会服务等领域从事心理咨询和辅导工作的专业人才。','90128'),(28,'080927','心理健康教育','心理健康教育专业旨在培养具备心理健康教育理论和应用技能的专业人才，能够在学校、社区和企业中从事心理健康教育和辅导工作的专业人才。','90128'),(29,'080928','临床心理学','临床心理学专业旨在培养具备临床心理学理论和实务技能的专业人才，能够在医疗机构、心理咨询机构等从事心理治疗和咨询工作的专业人才。','90128'),(30,'080929','环境科学','环境科学专业旨在培养具备环境科学基础理论和实验技能的专业人才，能够在环境保护、科研、教育等领域从事环境科学研究和管理工作的专业人才。','01239'),(31,'080930','环境工程','环境工程专业旨在培养具备环境工程基础理论和实践技能的专业人才，能够在环境保护、工程设计和管理等领域从事环境工程工作的专业人才。','01239'),(32,'080931','资源环境与城乡规划管理','资源环境与城乡规划管理专业旨在培养具备资源环境科学和城乡规划管理理论知识和实践技能的专业人才。','01239');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='公告信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,'山河大学开学了！','山河大学开学了！','2024-05-02','admin'),(2,'所有功能都已完成，可以正常使用，请同学们检查自己的信息是否正确。','所有功能都已完成，可以正常使用，请同学们检查自己的信息是否正确。','2024-05-03','admin'),(3,'快期末啦！啥也不会吧？','期末让人很开心吧?','2024-05-30','admin');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '学号',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `password` varchar(20) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `majorId` varchar(10) NOT NULL,
  `grade` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '电话号码',
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '邮箱',
  `address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '家庭地址',
  `role` varchar(10) DEFAULT NULL,
  `admissionDate` date DEFAULT NULL COMMENT '入学时间',
  `graduationDate` date DEFAULT NULL COMMENT '毕业时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `majorId_idx` (`majorId`),
  CONSTRAINT `majorId` FOREIGN KEY (`majorId`) REFERENCES `major` (`majorId`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'202482450101','杨小龙','123456','http://localhost:9090/files/IMG_0964.jpg','080910','法语24-1','男','2001-05-01','19232478687','yangxiaolong@example.com','北京市朝阳区','STUDENT','2024-09-01','2026-06-01'),(2,'202482450102','赵小杰','123456','http://localhost:9090/files/IMG_0964.jpg','080919','生物24-2','男','2002-12-02','17732429342','zhaoxiaojie@example.com','上海市浦东新区','STUDENT','2024-09-01','2026-06-01'),(3,'202482450103','李小雨','123456','http://localhost:9090/files/IMG_0964.jpg','080921','心理24-3','女','2003-11-12','13524782394','wuxiaofang@example.com','广州市天河区','STUDENT','2024-09-01','2026-06-01'),(4,'202482450104','孙小刚','123456','http://localhost:9090/files/IMG_0964.jpg','080903','人工智能24-1','男','2001-09-04','17748238472','sunxiaogang@example.com','深圳市福田区','STUDENT','2024-09-01','2026-06-01'),(5,'202482450105','蒋小丽','123456','http://localhost:9090/files/IMG_0964.jpg','080929','环境24-2','女','2002-12-05','19823423623','jiangxiaoli@example.com','成都市武侯区','STUDENT','2024-09-01','2026-06-01'),(6,'202482450106','王小明','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2001-11-04','10976485008','wangxiaoming@example.com','重庆市渝中区','STUDENT','2024-09-01','2026-06-01'),(7,'202482450107','冯小霞','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2001-06-28','10438645732','fengxiaoxia@example.com','杭州市西湖区','STUDENT','2024-09-01','2026-06-01'),(8,'202482450108','张大伟','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2001-12-02','10360208443','zhangdawei@example.com','南京市鼓楼区','STUDENT','2024-09-01','2026-06-01'),(9,'202482450109','钱小雨','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2002-03-26','10021199913','qianxiaoyu@example.com','武汉市江汉区','STUDENT','2024-09-01','2026-06-01'),(10,'202482450110','陈小玲','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2001-11-04','10094694485','chenxiaoling@example.com','西安市雁塔区','STUDENT','2024-09-01','2026-06-01'),(11,'202482450111','郑小文','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2000-02-06','10763023700','zhengxiaowen@example.com','苏州市姑苏区','STUDENT','2024-09-01','2026-06-01'),(12,'202482450112','孙芳','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2000-09-02','10046883875','sunfang@example.com','成都市锦江区','STUDENT','2024-09-01','2026-06-01'),(13,'202482450113','周小婷','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2000-04-07','10276257606','zhouxiaoting@example.com','天津市和平区','STUDENT','2024-09-01','2026-06-01'),(14,'202482450114','卫小军','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2002-07-21','10958773124','weixiaojun@example.com','青岛市市南区','STUDENT','2024-09-01','2026-06-01'),(15,'202482450115','许小华','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2002-04-13','10482323745','xuxiaohua@example.com','大连市中山区','STUDENT','2024-09-01','2026-06-01'),(16,'202482450116','李小红','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2000-09-17','10776429682','lixiaohong@example.com','沈阳市沈河区','STUDENT','2024-09-01','2026-06-01'),(17,'202482450117','韩小萍','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2000-04-25','10650017196','hanxiaoping@example.com','哈尔滨市道里区','STUDENT','2024-09-01','2026-06-01'),(18,'202482450118','张伟','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2000-05-09','12471658058','zhangwei@example.com','长春市朝阳区','STUDENT','2024-09-01','2026-06-01'),(19,'202482450119','刘明','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2003-11-18','11111351112','liuming@example.com','济南市历下区','STUDENT','2024-09-01','2026-06-01'),(20,'202482450120','秦小莉','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2002-07-30','18870751381','qinxiaoli@example.com','太原市小店区','STUDENT','2024-09-01','2026-06-01'),(21,'202482450121','吴洋','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2002-01-05','18542119002','wuyang@example.com','兰州市城关区','STUDENT','2024-09-01','2026-06-01'),(22,'202482450122','郑敏','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2003-01-17','12463501377','zhengmin@example.com','银川市兴庆区','STUDENT','2024-09-01','2026-06-01'),(23,'202482450123','李辉','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2003-10-14','19927457915','lihui@example.com','西宁市城中区','STUDENT','2024-09-01','2026-06-01'),(24,'202482450124','王红','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2000-07-01','16450190764','wanghong@example.com','拉萨市城关区','STUDENT','2024-09-01','2026-06-01'),(25,'202482450125','张丽','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2003-05-28','13206506048','zhangli@example.com','乌鲁木齐市天山区','STUDENT','2024-09-01','2026-06-01'),(26,'202482450126','褚小刘','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2000-03-13','12871900808','chuxiaoliu@example.com','呼和浩特市回民区','STUDENT','2024-09-01','2026-06-01'),(27,'202482450127','沈小磊','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2001-02-22','15707563698','shenxiaolei@example.com','南宁市青秀区','STUDENT','2024-09-01','2026-06-01'),(28,'202482450128','许小华','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2003-12-23','12596605748','xuxiaohua@example.com','大连市中山区','STUDENT','2024-09-01','2026-06-01'),(29,'202482450129','李小红','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','女','2001-04-05','17967438705','lixiaohong@example.com','沈阳市沈河区','STUDENT','2024-09-01','2026-06-01'),(30,'202482450130','卫小军','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2000-02-25','18011886429','weixiaojun@example.com','青岛市市南区','STUDENT','2024-09-01','2026-06-01'),(31,'202482450131','刘一鸣','123456','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','2001-05-09','18212319023','liuyiming@example.com','石家庄市新华区','STUDENT','2024-09-01','2026-06-01'),(32,'202482450132','黎明','2342','http://localhost:9090/files/IMG_0964.jpg','080901','E计24-1','男','1999-12-11','12346573829','1124219013@qq.com','石家庄桥西区','STUDENT','2024-09-01','2026-06-01'),(33,'202482450133','刘敏','123456','http://localhost:9090/files/IMG_0964.jpg','080930','环境24-1','女','2003-02-18','18765432109','liumin@example.com','广州市天河区','STUDENT','2024-09-01','2026-06-01'),(34,'202482450134','李华','123456','http://localhost:9090/files/IMG_0964.jpg','080927','心理24-1','男','2003-05-15','13678901234','lihua@example.com','上海市浦东新区','STUDENT','2024-09-01','2026-06-01'),(35,'202482450135','王明','123456','http://localhost:9090/files/IMG_0964.jpg','080926','心理24-2','男','2002-08-03','18976543210','wangming@example.com','北京市朝阳区','STUDENT','2024-09-01','2026-06-01'),(36,'202482450136','刘敏','123456','http://localhost:9090/files/IMG_0964.jpg','080930','环境24-1','女','2003-02-18','18765432109','liumin@example.com','广州市天河区','STUDENT','2024-09-01','2026-06-01'),(37,'202482450137','张伟','123456','http://localhost:9090/files/IMG_0964.jpg','080902','软工24-1','男','2003-10-09','13987654321','zhangwei@example.com','深圳市南山区','STUDENT','2024-09-01','2026-06-01'),(38,'202482450138','陈静','123456','http://localhost:9090/files/IMG_0964.jpg','080918','生物24-1','女','2003-04-25','13812345678','chenjing@example.com','成都市武侯区','STUDENT','2024-09-01','2026-06-01'),(39,'202482450139','杨杰','123456','http://localhost:9090/files/IMG_0964.jpg','080912','法学24-1','男','2002-11-30','18623456789','yangjie@example.com','重庆市渝北区','STUDENT','2024-09-01','2026-06-01'),(40,'202482450140','周芳','123456','http://localhost:9090/files/IMG_0964.jpg','080912','法学24-2','女','2003-06-07','13598765432','zhoufang@example.com','南京市鼓楼区','STUDENT','2024-09-01','2026-06-01'),(41,'202482450141','吴健','123456','http://localhost:9090/files/IMG_0964.jpg','080907','集成电路24-1','男','2002-09-14','13245678901','wujiang@example.com','杭州市西湖区','STUDENT','2024-09-01','2026-06-01'),(42,'202482450142','王丽','123456','http://localhost:9090/files/IMG_0964.jpg','080916','设计24-1','女','2002-12-30','18678901234','wangli@example.com','武汉市江汉区','STUDENT','2024-09-01','2026-06-01'),(43,'202482450143','刘强','123456','http://localhost:9090/files/IMG_0964.jpg','080909','日语24-1','男','2003-03-19','13901234567','liuqiang@example.com','苏州市工业园区','STUDENT','2024-09-01','2026-06-01'),(44,'202482450144','张艳','123456','http://localhost:9090/files/IMG_0964.jpg','080923','体育24-1','女','2003-08-05','13856789012','zhangyan@example.com','青岛市市北区','STUDENT','2024-09-01','2026-06-01'),(45,'202482450145','赵雷','123456','http://localhost:9090/files/IMG_0964.jpg','080928','临床心理24-1','男','2002-10-17','18765432109','zhaolei@example.com','沈阳市和平区','STUDENT','2024-09-01','2026-06-01'),(46,'202482450146','孙芳','123456','http://localhost:9090/files/IMG_0964.jpg','080929','环境工程24-1','女','2003-04-03','13987654321','sunfang@example.com','成都市青羊区','STUDENT','2024-09-01','2026-06-01'),(47,'202482450147','李刚','123456','http://localhost:9090/files/IMG_0964.jpg','080924','体育教育24-1','男','2003-09-11','18723456789','ligang@example.com','西安市雁塔区','STUDENT','2024-09-01','2026-06-01'),(48,'202482450148','周秀英','123456','http://localhost:9090/files/IMG_0964.jpg','080920','教育学24-1','女','2002-11-28','13578901234','zhouxiuying@example.com','杭州市拱墅区','STUDENT','2024-09-01','2026-06-01'),(49,'202482450149','朱伟','123456','http://localhost:9090/files/IMG_0964.jpg','080931','城乡规划24-1','男','2003-01-08','13098765432','zhuwei@example.com','南京市玄武区','STUDENT','2024-09-01','2026-06-01');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL COMMENT '教师编号',
  `name` varchar(20) NOT NULL COMMENT '教师姓名',
  `password` varchar(20) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '教师性别',
  `role` varchar(10) NOT NULL,
  `phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '教师电话',
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '教师邮箱',
  `office` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '教师办公地址',
  `collegeId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `username` (`username`),
  KEY `collegeId_idx` (`collegeId`),
  CONSTRAINT `collegeId11` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教师表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'20030523','赵德广','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678','zhaodeguang@example.com','第三办公楼301','12340'),(2,'20040106','李雨天','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','19876543212','liyutian@example.com','第五办公楼107','12340'),(3,'20070208','赵丽云','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','14680135794','zhaoliyun@example.com','第一办公楼216','12340'),(4,'20091129','杨丽','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','18932376436','yangli@example.com','第三办公楼503','12340'),(5,'20101218','王彩霞','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','13579246803','wangcaixia@example.com','','12340'),(6,'20130419','陈捷','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','18924281299','chenjie@example.com','第二办公楼201','12340'),(7,'20140618','刘同','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','19934628236','liutong@example.com','第二办公楼218','12340'),(8,'20040211','王志强','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678902','wangzhiqiang@example.com','第二办公楼302','12340'),(9,'20090624','张丽丽','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678903','zhanglili@example.com','第六办公楼303','23451'),(10,'20170924','刘明','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678904','liuming@example.com','第二办公楼304','34562'),(11,'20021227','李华','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678905','lihua@example.com','第一办公楼305','45673'),(12,'20040709','陈红','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678906','chenhong@example.com','第二办公楼306','56784'),(13,'20000519','王伟','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678907','wangwei@example.com','第二办公楼307','67895'),(14,'20160919','刘霞','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678908','liuxia@example.com','第四办公楼308','78906'),(15,'20050304','张涛','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678909','zhangtao@example.com','第二办公楼309','89017'),(16,'20130202','陈阳','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678910','chenyang@example.com','第四办公楼310','90128'),(17,'20031118','王芳','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678911','wangfang@example.com','第二办公楼311','01239'),(18,'20010404','李勇','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678912','liyong@example.com','第六办公楼312','23451'),(19,'20180228','刘丽','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678913','liuli@example.com','第二办公楼313','34562'),(20,'20100303','张强','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678914','zhangqiang@example.com','第二办公楼314','45673'),(21,'20160827','王萍','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678915','wangping@example.com','第五办公楼315','56784'),(22,'20060706','李刚','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678916','ligang@example.com','第二办公楼316','67895'),(23,'20030408','刘洋','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678917','liuyang@example.com','第二办公楼317','78906'),(24,'20030616','张丽','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678918','zhanglei@example.com','第二办公楼318','89017'),(25,'20061206','王强','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678919','wangqiang@example.com','第二办公楼319','90128'),(26,'20060527','陈华','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678920','chenhua@example.com','第二办公楼320','01239'),(27,'20071120','刘萍','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678921','liuping@example.com','第四办公楼321','23451'),(28,'20120426','张伟','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678922','zhangwei@example.com','第二办公楼322','34562'),(29,'20170119','王霞','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','女','TEACHER','12345678923','wangxia@example.com','第二办公楼323','45673'),(30,'20120324','李强','123456','http://localhost:9090/files/1717730591426-teacher_avatar.jpg','男','TEACHER','12345678924','liqiang@example.com','第一办公楼324','56784');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timetable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `studentId` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生编号',
  `courseId` varchar(10) NOT NULL,
  `teacherId` varchar(10) NOT NULL,
  `time` varchar(45) DEFAULT NULL,
  `room` varchar(20) DEFAULT NULL,
  `testtime` varchar(45) DEFAULT NULL,
  `testroom` varchar(20) DEFAULT NULL,
  `score` decimal(5,2) DEFAULT NULL COMMENT '成绩',
  `evaluate` decimal(5,2) DEFAULT NULL COMMENT '评估',
  PRIMARY KEY (`studentId`,`courseId`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `timetable_classroom_id_idx` (`room`),
  KEY `fk_teacher_course` (`teacherId`,`courseId`),
  KEY `Arrange里面的课程编号` (`courseId`),
  CONSTRAINT `Arrange里的教师编号` FOREIGN KEY (`teacherId`) REFERENCES `arrange` (`teacherId`),
  CONSTRAINT `Arrange里面的课程编号` FOREIGN KEY (`courseId`) REFERENCES `arrange` (`courseId`),
  CONSTRAINT `studentId` FOREIGN KEY (`studentId`) REFERENCES `student` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教学活动';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable`
--

LOCK TABLES `timetable` WRITE;
/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
INSERT INTO `timetable` VALUES (41,'202482450101','100010','20030523',NULL,NULL,NULL,NULL,NULL,NULL),(1,'202482450101','110011','20030523','周三上午8:00-9:30','二教202','2024年6月23日下午15:00','二教202',99.00,100.00);
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类描述',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'zhangsan','123456','张三','http://localhost:9090/files/1699252742825-柴犬.jpeg','USER','18811112222','zhangsan@xm.com'),(9,'lisi','123456','李四','http://localhost:9090/files/1699254328253-柯基.jpeg','USER','18866660000','lisi@xm.com'),(10,'user','user','user',NULL,'USER',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topic` varchar(20) NOT NULL,
  `filename` varchar(20) NOT NULL,
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `topic_UNIQUE` (`topic`),
  KEY `teacherId_idx` (`author`),
  CONSTRAINT `teacherId3` FOREIGN KEY (`author`) REFERENCES `teacher` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
INSERT INTO `video` VALUES (1,'2023迎新大会','new.mp4','20030523'),(2,'2024大学生夏令营活动宣传视频','summer.mp4','20091129');
/*!40000 ALTER TABLE `video` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-16 15:13:01
