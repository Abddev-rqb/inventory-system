-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: inventory_db
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.4

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add Token',8,'add_tokenproxy'),(30,'Can change Token',8,'change_tokenproxy'),(31,'Can delete Token',8,'delete_tokenproxy'),(32,'Can view Token',8,'view_tokenproxy'),(33,'Can add laptop',9,'add_laptop'),(34,'Can change laptop',9,'change_laptop'),(35,'Can delete laptop',9,'delete_laptop'),(36,'Can view laptop',9,'view_laptop'),(37,'Can add order',10,'add_order'),(38,'Can change order',10,'change_order'),(39,'Can delete order',10,'delete_order'),(40,'Can view order',10,'view_order'),(41,'Can view total sales report',10,'view_sales_report'),(42,'Can add order item',11,'add_orderitem'),(43,'Can change order item',11,'change_orderitem'),(44,'Can delete order item',11,'delete_orderitem'),(45,'Can view order item',11,'view_orderitem'),(46,'Can add order deletion request',12,'add_orderdeletionrequest'),(47,'Can change order deletion request',12,'change_orderdeletionrequest'),(48,'Can delete order deletion request',12,'delete_orderdeletionrequest'),(49,'Can view order deletion request',12,'view_orderdeletionrequest'),(50,'Can add return',13,'add_return'),(51,'Can change return',13,'change_return'),(52,'Can delete return',13,'delete_return'),(53,'Can view return',13,'view_return'),(54,'Can assign return priority',13,'assign_return_priority'),(55,'Can stock in returned laptop',13,'stock_in_return'),(56,'Can export return records',13,'export_return'),(57,'Can add return expense',14,'add_returnexpense'),(58,'Can change return expense',14,'change_returnexpense'),(59,'Can delete return expense',14,'delete_returnexpense'),(60,'Can view return expense',14,'view_returnexpense');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1000000$NnZ6kgh9KMgThbjiZ1v8yL$b3Lj9ta9zzbWSoS9n0rYV/ICMtY12Z83Buf5Y6tF+ok=','2026-09-08 07:09:06.496625',1,'admin','','','admin@gmail.com',1,1,'2026-09-08 07:08:46.910906');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('dfc31f07da9d257259ce04dbcb626b4cc2fbe4f7','2026-09-08 07:10:00.058620',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(9,'inventory','laptop'),(10,'inventory','order'),(12,'inventory','orderdeletionrequest'),(11,'inventory','orderitem'),(13,'inventory','return'),(14,'inventory','returnexpense'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-07-26 20:03:25.225209'),(2,'auth','0001_initial','2026-07-26 20:03:26.045657'),(3,'admin','0001_initial','2026-07-26 20:03:26.233731'),(4,'admin','0002_logentry_remove_auto_add','2026-07-26 20:03:26.248281'),(5,'admin','0003_logentry_add_action_flag_choices','2026-07-26 20:03:26.265446'),(6,'contenttypes','0002_remove_content_type_name','2026-07-26 20:03:26.425861'),(7,'auth','0002_alter_permission_name_max_length','2026-07-26 20:03:26.512012'),(8,'auth','0003_alter_user_email_max_length','2026-07-26 20:03:26.554031'),(9,'auth','0004_alter_user_username_opts','2026-07-26 20:03:26.569651'),(10,'auth','0005_alter_user_last_login_null','2026-07-26 20:03:26.652038'),(11,'auth','0006_require_contenttypes_0002','2026-07-26 20:03:26.655750'),(12,'auth','0007_alter_validators_add_error_messages','2026-07-26 20:03:26.669495'),(13,'auth','0008_alter_user_username_max_length','2026-07-26 20:03:26.766306'),(14,'auth','0009_alter_user_last_name_max_length','2026-07-26 20:03:26.861348'),(15,'auth','0010_alter_group_name_max_length','2026-07-26 20:03:26.894743'),(16,'auth','0011_update_proxy_permissions','2026-07-26 20:03:26.910250'),(17,'auth','0012_alter_user_first_name_max_length','2026-07-26 20:03:27.007224'),(18,'sessions','0001_initial','2026-07-26 20:03:27.057108'),(19,'inventory','0001_initial','2026-07-27 21:23:46.789532'),(20,'inventory','0002_laptop_inventory_status_alter_laptop_area_and_more','2026-07-28 18:09:13.581449'),(21,'authtoken','0001_initial','2026-07-30 20:08:51.616410'),(22,'authtoken','0002_auto_20160226_1747','2026-07-30 20:08:51.724863'),(23,'authtoken','0003_tokenproxy','2026-07-30 20:08:51.731576'),(24,'authtoken','0004_alter_tokenproxy_options','2026-07-30 20:08:51.741891'),(25,'inventory','0003_alter_laptop_inventory_status','2026-08-03 20:18:29.304832'),(26,'inventory','0004_order_orderdeletionrequest_orderitem_and_more','2026-08-07 07:18:23.884594'),(27,'inventory','0005_remove_laptop_laptop_quantity_gte_1_and_more','2026-08-08 06:42:20.880800'),(28,'inventory','0006_alter_laptop_inventory_status','2026-08-11 06:23:49.736978'),(29,'inventory','0007_remove_laptop_laptop_quantity_gte_0_and_more','2026-08-11 06:46:35.466973'),(30,'inventory','0008_alter_order_options','2026-08-12 06:59:01.085906'),(31,'inventory','0009_orderitem_inventory_status_before_sale','2026-08-12 21:26:01.396801'),(32,'inventory','0010_return_and_more','2026-08-15 19:32:40.280511'),(33,'inventory','0011_alter_return_service_rack','2026-08-16 09:44:56.087622'),(34,'inventory','0012_returnexpense','2026-08-19 08:07:50.917977'),(35,'inventory','0013_order_source_return','2026-08-19 21:15:28.976293'),(36,'inventory','0014_return_customer_address','2026-08-19 21:32:31.349701'),(37,'inventory','0015_return_inventory_service_source','2026-08-19 22:21:56.022978'),(38,'inventory','0016_return_seal_status_return_warranty_status','2026-09-04 19:33:11.769891');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('glypp2e3623ckgaqgfyp1krdrgy812g5','.eJxVjMsOwiAQRf-FtSHOQGFw6b7fQGYKSNXQpI-V8d-1SRe6veec-1KRt7XGbclzHJO6KFCn3014eOS2g3Tndpv0MLV1HkXvij7oovsp5ef1cP8OKi_1Wxc5OxMKUUawFoPrgNgTsXhK1piAznKRhAlJPBQEkIzowbMrXWfU-wPBSTbu:1x3px4:MV5i8onvlbr8CJbl3n9lJnzzePGto0VuCl6wDdzs6kY','2026-09-22 07:09:06.501921');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_laptops`
--

DROP TABLE IF EXISTS `inventory_laptops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_laptops` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processor_generation` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ram_gb` int unsigned NOT NULL,
  `storage_gb` int unsigned NOT NULL,
  `storage_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wholesale_price` decimal(12,2) NOT NULL,
  `retail_price` decimal(12,2) NOT NULL,
  `qc_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comments` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int unsigned NOT NULL,
  `warranty_days` smallint unsigned NOT NULL,
  `area` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `inventory_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `laptop_company_idx` (`company`),
  KEY `laptop_model_idx` (`model_number`),
  KEY `laptop_qc_status_idx` (`qc_status`),
  KEY `laptop_area_idx` (`area`),
  KEY `laptop_inv_status_idx` (`inventory_status`),
  CONSTRAINT `inventory_laptops_chk_1` CHECK ((`ram_gb` >= 0)),
  CONSTRAINT `inventory_laptops_chk_2` CHECK ((`storage_gb` >= 0)),
  CONSTRAINT `inventory_laptops_chk_3` CHECK ((`quantity` >= 0)),
  CONSTRAINT `inventory_laptops_chk_4` CHECK ((`warranty_days` >= 0)),
  CONSTRAINT `laptop_quantity_exactly_1` CHECK ((`quantity` = 1)),
  CONSTRAINT `laptop_ram_gte_1` CHECK ((`ram_gb` >= 1)),
  CONSTRAINT `laptop_retail_gte_wholesale` CHECK ((`retail_price` >= `wholesale_price`)),
  CONSTRAINT `laptop_retail_price_gte_0` CHECK ((`retail_price` >= 0)),
  CONSTRAINT `laptop_storage_gte_1` CHECK ((`storage_gb` >= 1)),
  CONSTRAINT `laptop_valid_warranty_days` CHECK ((`warranty_days` in (0,7,15,30))),
  CONSTRAINT `laptop_wholesale_price_gte_0` CHECK ((`wholesale_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_laptops`
--

LOCK TABLES `inventory_laptops` WRITE;
/*!40000 ALTER TABLE `inventory_laptops` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_laptops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_order`
--

DROP TABLE IF EXISTS `inventory_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_number` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_address` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_mode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `via` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `via_other` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_items` int unsigned NOT NULL,
  `total_amount` decimal(14,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `dispatched_at` datetime(6) DEFAULT NULL,
  `employee_id` int NOT NULL,
  `source_return_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  UNIQUE KEY `source_return_id` (`source_return_id`),
  KEY `order_status_created_idx` (`status`,`created_at`),
  KEY `order_price_created_idx` (`price_mode`,`created_at`),
  KEY `inventory_order_employee_id_7bc618a3_fk_auth_user_id` (`employee_id`),
  KEY `inventory_order_status_a8be2571` (`status`),
  KEY `inventory_order_created_at_d33ccf43` (`created_at`),
  CONSTRAINT `inventory_order_employee_id_7bc618a3_fk_auth_user_id` FOREIGN KEY (`employee_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `inventory_order_source_return_id_2bab57b7_fk_inventory` FOREIGN KEY (`source_return_id`) REFERENCES `inventory_returns` (`id`),
  CONSTRAINT `inventory_order_chk_1` CHECK ((`total_items` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_order`
--

LOCK TABLES `inventory_order` WRITE;
/*!40000 ALTER TABLE `inventory_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_orderdeletionrequest`
--

DROP TABLE IF EXISTS `inventory_orderdeletionrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_orderdeletionrequest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reason` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  `requested_by_id` int NOT NULL,
  `reviewed_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_orderdelet_order_id_84678ad4_fk_inventory` (`order_id`),
  KEY `inventory_orderdelet_requested_by_id_d787310f_fk_auth_user` (`requested_by_id`),
  KEY `inventory_orderdelet_reviewed_by_id_f3763b48_fk_auth_user` (`reviewed_by_id`),
  KEY `inventory_orderdeletionrequest_status_6438dbd0` (`status`),
  KEY `inventory_orderdeletionrequest_created_at_91d4a17e` (`created_at`),
  CONSTRAINT `inventory_orderdelet_order_id_84678ad4_fk_inventory` FOREIGN KEY (`order_id`) REFERENCES `inventory_order` (`id`),
  CONSTRAINT `inventory_orderdelet_requested_by_id_d787310f_fk_auth_user` FOREIGN KEY (`requested_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `inventory_orderdelet_reviewed_by_id_f3763b48_fk_auth_user` FOREIGN KEY (`reviewed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_orderdeletionrequest`
--

LOCK TABLES `inventory_orderdeletionrequest` WRITE;
/*!40000 ALTER TABLE `inventory_orderdeletionrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_orderdeletionrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_orderitem`
--

DROP TABLE IF EXISTS `inventory_orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number_snapshot` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_snapshot` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(14,2) NOT NULL,
  `line_total` decimal(14,2) NOT NULL,
  `is_custom_item` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `laptop_id` bigint DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `inventory_status_before_sale` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_orderitem_laptop_id_fc5e06e4_fk_inventory_laptops_id` (`laptop_id`),
  KEY `inventory_orderitem_order_id_72ba1749_fk_inventory_order_id` (`order_id`),
  CONSTRAINT `inventory_orderitem_laptop_id_fc5e06e4_fk_inventory_laptops_id` FOREIGN KEY (`laptop_id`) REFERENCES `inventory_laptops` (`id`),
  CONSTRAINT `inventory_orderitem_order_id_72ba1749_fk_inventory_order_id` FOREIGN KEY (`order_id`) REFERENCES `inventory_order` (`id`),
  CONSTRAINT `inventory_orderitem_chk_1` CHECK ((`quantity` >= 0)),
  CONSTRAINT `order_item_line_total_gte_0` CHECK ((`line_total` >= 0)),
  CONSTRAINT `order_item_quantity_gt_zero` CHECK ((`quantity` > 0)),
  CONSTRAINT `order_item_unit_price_gte_0` CHECK ((`unit_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_orderitem`
--

LOCK TABLES `inventory_orderitem` WRITE;
/*!40000 ALTER TABLE `inventory_orderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_return_expenses`
--

DROP TABLE IF EXISTS `inventory_return_expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_return_expenses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `total_amount` decimal(14,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `return_record_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ret_exp_return_date_idx` (`return_record_id`,`created_at`),
  KEY `inventory_return_expenses_created_by_id_0267914a_fk_auth_user_id` (`created_by_id`),
  KEY `inventory_return_expenses_item_name_000b12e5` (`item_name`),
  KEY `inventory_return_expenses_created_at_237cd8ed` (`created_at`),
  CONSTRAINT `inventory_return_exp_return_record_id_dc7282d0_fk_inventory` FOREIGN KEY (`return_record_id`) REFERENCES `inventory_returns` (`id`),
  CONSTRAINT `inventory_return_expenses_created_by_id_0267914a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `inventory_return_expenses_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_return_expenses`
--

LOCK TABLES `inventory_return_expenses` WRITE;
/*!40000 ALTER TABLE `inventory_return_expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_return_expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_returns`
--

DROP TABLE IF EXISTS `inventory_returns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_returns` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processor_generation` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ram_gb` int unsigned NOT NULL,
  `storage_gb` int unsigned NOT NULL,
  `storage_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issue` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_rack` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `repair_notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `stocked_in_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `stocked_in_by_id` int DEFAULT NULL,
  `stocked_in_laptop_id` bigint DEFAULT NULL,
  `technician_id` int DEFAULT NULL,
  `customer_address` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_laptop_id` bigint DEFAULT NULL,
  `source_inventory_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seal_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warranty_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_returns_created_by_id_f51f448a_fk_auth_user_id` (`created_by_id`),
  KEY `inventory_returns_stocked_in_by_id_8b34c0e2_fk_auth_user_id` (`stocked_in_by_id`),
  KEY `inventory_returns_stocked_in_laptop_id_6375da06_fk_inventory` (`stocked_in_laptop_id`),
  KEY `return_status_created_idx` (`status`,`created_at`),
  KEY `return_priority_created_idx` (`priority`,`created_at`),
  KEY `return_tech_status_idx` (`technician_id`,`status`),
  KEY `return_rack_idx` (`service_rack`),
  KEY `inventory_returns_customer_name_691f4ec9` (`customer_name`),
  KEY `inventory_returns_company_9323e1c7` (`company`),
  KEY `inventory_returns_model_number_2bc0ec3b` (`model_number`),
  KEY `inventory_returns_serial_number_a0c0431d` (`serial_number`),
  KEY `inventory_returns_priority_962957c9` (`priority`),
  KEY `inventory_returns_status_c91840e6` (`status`),
  KEY `inventory_returns_stocked_in_at_c3ceaf86` (`stocked_in_at`),
  KEY `inventory_returns_created_at_a0500d7c` (`created_at`),
  KEY `inventory_returns_service_rack_6788ae5a` (`service_rack`),
  KEY `inventory_returns_source_laptop_id_e95e1cc6_fk_inventory` (`source_laptop_id`),
  KEY `inventory_returns_source_type_2903553c` (`source_type`),
  KEY `inventory_returns_seal_status_0c44f05a` (`seal_status`),
  KEY `inventory_returns_warranty_status_83e0b139` (`warranty_status`),
  CONSTRAINT `inventory_returns_created_by_id_f51f448a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `inventory_returns_source_laptop_id_e95e1cc6_fk_inventory` FOREIGN KEY (`source_laptop_id`) REFERENCES `inventory_laptops` (`id`),
  CONSTRAINT `inventory_returns_stocked_in_by_id_8b34c0e2_fk_auth_user_id` FOREIGN KEY (`stocked_in_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `inventory_returns_stocked_in_laptop_id_6375da06_fk_inventory` FOREIGN KEY (`stocked_in_laptop_id`) REFERENCES `inventory_laptops` (`id`),
  CONSTRAINT `inventory_returns_technician_id_a9e9f5e2_fk_auth_user_id` FOREIGN KEY (`technician_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `inventory_returns_chk_1` CHECK ((`ram_gb` >= 0)),
  CONSTRAINT `inventory_returns_chk_2` CHECK ((`storage_gb` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_returns`
--

LOCK TABLES `inventory_returns` WRITE;
/*!40000 ALTER TABLE `inventory_returns` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_returns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'inventory_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-08 12:42:56
