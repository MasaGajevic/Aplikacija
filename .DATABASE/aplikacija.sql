-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for aplikacija
CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `aplikacija`;

-- Dumping structure for table aplikacija.administrator
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.administrator: ~6 rows (approximately)
DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'milantex', '30B1B23A56D4AAA7BF951355D4F3CCFB157F2CF7B27D673A1B91613C431F28A76D3E621B9F38FD3C7954D619909EF4CBB574E225D6D60EDC6D423E652112633A'),
	(2, 'test_user', '90856ufdjg98tyuhgrehg34'),
	(3, 'pperic', '6A4C0DC4FCC43BDEA28963DF73E4F8351BCDAE08FDA1516234E8D764AF8178A610BCCA2813D204DFF92A43F0511EB0016C7682CCF7B343D99E01739FC26EF104'),
	(7, 'mmilic', 'D1B080950E85C8916A16DA7CE500D85B56E52B64F59B958F1929F164FB0751544925557C0649C9BB50F3DE0D1471FCE3E233E1EF33BD0EA06601FC7D54F927FC'),
	(9, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC'),
	(10, 'test', 'EE26B0DD4AF7E749AA1A8EE3C10AE9923F618980772E473F8819A5D4940E0DB27AC185F8A0E1D5F84F88BC887FD67B143732C304CC5FA9AD8E6F57F50028A8FF');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

-- Dumping structure for table aplikacija.administrator_token
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `token` text COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`administrator_token_id`),
  KEY `fk_administrator_token_administrator_id` (`administrator_id`),
  CONSTRAINT `fk_administrator_token_administrator_id` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.administrator_token: ~10 rows (approximately)
DELETE FROM `administrator_token`;
/*!40000 ALTER TABLE `administrator_token` DISABLE KEYS */;
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(1, 1, '2020-06-11 12:19:07', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTQ5MTQ3LjgwNywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjUuMCIsImlhdCI6MTU5MTg3MDc0N30.VNZpgueUodx5zH4dNV-UtUVo6hAM0HCKHG9H2qqQZao', '2020-07-12 10:19:07', 1),
	(2, 1, '2020-06-11 12:30:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTQ5ODU5LjY0MSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTg3MTQ1OX0.rGb_AeTI8queWATdyQovUmYU6srXlH0JF3I-VDQiGOY', '2020-07-12 10:30:59', 1),
	(3, 1, '2020-06-11 12:31:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTQ5ODkwLjkzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzgzLjAuNDEwMy45NyBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNTkxODcxNDkwfQ.yp99CMh0U_rHDgw7IKx54PgsUleCeD_qZ-UPC1ohR9I', '2020-07-12 10:31:30', 1),
	(4, 1, '2020-06-11 12:31:55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTQ5OTE1LjM1NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTg3MTUxNX0.ThBotWvDSfGJxfEh5m8k1oaOoYn0W8tGn52SyTHCerI', '2020-07-12 10:31:55', 1),
	(5, 1, '2020-06-11 12:32:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTQ5OTYwLjc2NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTg3MTU2MH0.mcBSKOAZcnwi-ZrexjsIHVEfdFjxl_HbbPKXweCMJYw', '2020-07-12 10:32:40', 1),
	(6, 1, '2020-06-11 12:37:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTUwMjM0LjUzMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTg3MTgzNH0.J6pyE831olJbxZH32-DvBSNakwpFylScUipepuDHvYg', '2020-07-12 10:37:14', 1),
	(7, 1, '2020-06-11 12:51:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk0NTUxMDk5Ljk5NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTg3MjY5OX0.w65mslZyVjtBVmiw-wbtU9SA3GCdpAYPe_oRgQkiDko', '2020-07-12 10:51:39', 1),
	(8, 1, '2020-07-09 11:19:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk2OTY4MzgwLjAxNCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyODk5ODB9.9acxI9qwQIbIP7shC9epwn7QyMi90aWe2JfTRL7u_dQ', '2020-08-09 10:19:40', 1),
	(9, 1, '2020-07-09 12:08:55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk2OTcxMzM1Ljk1OCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMSIsImlhdCI6MTU5NDI5MjkzNX0.2t6U1JZb8j3DSWkQtZ33wHGm3QGc7veU7qCK3hzQRR4', '2020-08-09 11:08:55', 1),
	(10, 1, '2020-07-09 12:31:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6Im1pbGFudGV4IiwiZXhwIjoxNTk2OTcyNjY1LjM5NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjExNiBNb2JpbGUgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NDI5NDI2NX0.jZE3P0VTSmwEaVW1-BrHfiAbM1fJ4mGfE-mnjzp2gyc', '2020-08-09 11:31:05', 1);
/*!40000 ALTER TABLE `administrator_token` ENABLE KEYS */;

-- Dumping structure for table aplikacija.carpet
CREATE TABLE IF NOT EXISTS `carpet` (
  `carpet_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `excerpt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('XXL','XL','XXXL') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'XXL',
  `is_promoted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`carpet_id`),
  KEY `fk_carpet_category_id` (`category_id`),
  CONSTRAINT `fk_carpet_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.carpet: ~3 rows (approximately)
DELETE FROM `carpet`;
/*!40000 ALTER TABLE `carpet` DISABLE KEYS */;
INSERT INTO `carpet` (`carpet_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
	(3, 'Boho-Chic', 3, 'Boho Chic je jedan jako lep tepih', 'Kolekciju Boho Chic odlikuje atraktivan dezen koji se odlično se uklapa u neobične ambijente pružajući lični pečat prostoru. Tepisi su postojani, laki za održavanje i praktični za svaki ambijent.Kolekciju Boho Chic odlikuje atraktivan dezen koji se odlično se uklapa u neobične ambijente pružajući lični pečat prostoru. Tepisi su postojani, laki za održavanje i praktični za svaki ambijent.', 'XL', 0, '2020-07-09 11:50:41'),
	(6, 'Linea', 3, 'Savrsen tepih', 'Kolekciju Linea čini kombinacija modernih, retro, etno i klasičnih dezena. Preovladavaju jaki tonovi crvene, bordo i naranžaste.Kolekciju Linea čini kombinacija modernih, retro, etno i klasičnih dezena. Preovladavaju jaki tonovi crvene, bordo i naranžaste.Kolekciju Linea čini kombinacija modernih, retro, etno i klasičnih dezena. Preovladavaju jaki tonovi crvene, bordo i naranžaste.Kolekciju Linea čini kombinacija modernih, retro, etno i klasičnih dezena. Preovladavaju jaki tonovi crvene, bordo i naranžaste.', 'XXL', 0, '2020-07-09 11:52:14'),
	(8, 'Tepih baš', 3, 'Tepih je ovaj jako mekan', 'Ovaj tepih je bas lep i mekan i bas je lepo gaziti po njemu mmmm baš je lepo to skroz lepo', 'XXXL', 0, '2020-07-09 11:52:35');
/*!40000 ALTER TABLE `carpet` ENABLE KEYS */;

-- Dumping structure for table aplikacija.carpet_price
CREATE TABLE IF NOT EXISTS `carpet_price` (
  `carpet_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carpet_id` int(10) unsigned NOT NULL DEFAULT 0,
  `price` decimal(10,2) unsigned NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`carpet_price_id`),
  KEY `fk_carpet_price_carpet_id` (`carpet_id`),
  CONSTRAINT `fk_carpet_price_carpet_id` FOREIGN KEY (`carpet_id`) REFERENCES `carpet` (`carpet_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.carpet_price: ~3 rows (approximately)
DELETE FROM `carpet_price`;
/*!40000 ALTER TABLE `carpet_price` DISABLE KEYS */;
INSERT INTO `carpet_price` (`carpet_price_id`, `carpet_id`, `price`, `created_at`) VALUES
	(5, 8, 550.00, '2020-07-09 11:59:32'),
	(6, 3, 1200.00, '2020-07-09 12:06:41'),
	(7, 6, 900.00, '2020-07-09 12:06:48');
/*!40000 ALTER TABLE `carpet_price` ENABLE KEYS */;

-- Dumping structure for table aplikacija.cart
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.cart: ~2 rows (approximately)
DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_id`, `user_id`, `created_at`) VALUES
	(85, 5, '2020-07-09 13:30:37'),
	(86, 5, '2020-07-09 12:30:41');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- Dumping structure for table aplikacija.cart_carpet
CREATE TABLE IF NOT EXISTS `cart_carpet` (
  `cart_carpet_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int(10) unsigned NOT NULL DEFAULT 0,
  `carpet_id` int(10) unsigned NOT NULL DEFAULT 0,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`cart_carpet_id`),
  UNIQUE KEY `uq_cart_carpet_cart_id_carpet_id` (`cart_id`,`carpet_id`),
  KEY `fk_cart_carpet_carpet_id` (`carpet_id`),
  CONSTRAINT `fk_cart_carpet_carpet_id` FOREIGN KEY (`carpet_id`) REFERENCES `carpet` (`carpet_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_carpet_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.cart_carpet: ~2 rows (approximately)
DELETE FROM `cart_carpet`;
/*!40000 ALTER TABLE `cart_carpet` DISABLE KEYS */;
INSERT INTO `cart_carpet` (`cart_carpet_id`, `cart_id`, `carpet_id`, `quantity`) VALUES
	(14, 85, 8, 1),
	(15, 85, 6, 3);
/*!40000 ALTER TABLE `cart_carpet` ENABLE KEYS */;

-- Dumping structure for table aplikacija.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `parent__category_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.category: ~5 rows (approximately)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Staze', 'assets/pc.jpg', NULL),
	(2, 'Tepisi za trpezarije', 'assets/home.jpg', NULL),
	(3, 'Podni tepisi', 'assets/pc/laptop.jpg', NULL),
	(4, 'Tepisi za decije sobe', 'assets/pc/memory.jpg', NULL),
	(5, 'Preparirane životinje', 'assets/pc/memory/hdd.jpg', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table aplikacija.order
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `cart_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('rejected','accepted','shipped','pending') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.order: ~1 rows (approximately)
DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`order_id`, `created_at`, `cart_id`, `status`) VALUES
	(6, '2020-07-09 12:30:37', 85, 'pending');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

-- Dumping structure for table aplikacija.photo
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carpet_id` int(10) unsigned NOT NULL DEFAULT 0,
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_carpet_id` (`carpet_id`),
  CONSTRAINT `fk_photo_carpet_id` FOREIGN KEY (`carpet_id`) REFERENCES `carpet` (`carpet_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.photo: ~3 rows (approximately)
DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `carpet_id`, `image_path`) VALUES
	(10, 3, '202079-0641156619-tepih1.jpg'),
	(11, 6, '202079-8152638871-tepih2.jpg'),
	(12, 8, '202079-4660678344-tepih3.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

-- Dumping structure for table aplikacija.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `forename` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `surname` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `phone_number` varchar(24) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `postal_address` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`),
  UNIQUE KEY `uq_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.user: ~3 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `forename`, `surname`, `phone_number`, `postal_address`) VALUES
	(1, 'test@test.rs', '8D2F4D9C7F87141F0810F1ACD6C0462FF0319BB049AA88EA4E310649628091DE316CF1392E19AF4F0A327826545F63E4E969838F5E7D572A475DE3255B738ACA', 'Pera', 'Peric', '+38166999999', 'Nepoznata adresa bb, Glavna Luka, Nedodjija'),
	(3, 'proba1@test.rs', '0F159A7488487C6791DB6894E43F101B396AF1C6BDCF7C5D2AA9E861F07D19BF81B9C95D2BA6C1D6155A50FCC7FC5BF2CCCC319DB856C8771AA8DC06D9AA6AB0', 'Proba', 'Test', '+38111309999999', 'Neka adresa 44\n11000 Beograd\nR. Srbija'),
	(5, 'testiranje@gmail.com', 'C89C6361959323192DD27C3685EA69A459F5E2CB051291D0F2933D2545C48834640D446F6F28E7E19375FFC05D81BB44F18FE3ABCDD135C410C15A26B523CC80', 'Neko', 'Neko', '+381612042686', 'Ulica ta i ta 14');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table aplikacija.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `token` text COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_token_id`),
  KEY `fk_user_token_user_id` (`user_id`),
  CONSTRAINT `fk_user_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table aplikacija.user_token: ~17 rows (approximately)
DELETE FROM `user_token`;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(1, 1, '2020-06-04 12:53:45', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5Mzk0NjQyNS4wNDIsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjYxIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTEyNjgwMjV9.dhQXDYiE_JGK8NIYRI_TI00Chl2SkqKVvgQUEv1fDQM', '2020-07-05 10:53:45', 1),
	(2, 3, '2020-06-04 13:31:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjozLCJpZGVudGl0eSI6InByb2JhMUB0ZXN0LnJzIiwiZXhwIjoxNTkzOTQ4NzAwLjQ4NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuNjEgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTI3MDMwMH0._uqyUkFcW1PmO7ViMoU2YIM0W0kPvUv5_0wSxc5RCds', '2020-07-05 11:31:40', 1),
	(3, 1, '2020-06-04 14:11:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5Mzk1MTA4NC43OTYsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI1LjAiLCJpYXQiOjE1OTEyNzI2ODR9.oHbKjPZJjkzXHGYwvQqUNxUXgZmaEBM7qO7bQMyKwlE', '2020-07-05 12:11:24', 1),
	(4, 1, '2020-06-04 14:23:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5Mzk1MTgzNy4zMjgsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjYxIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTEyNzM0Mzd9.qTE9d9LuNdm8iW3zr9nartwGuTPKpdarGuYFXoupPZs', '2020-07-05 12:23:57', 1),
	(5, 1, '2020-06-09 17:03:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDM5MzM5NC45MTUsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTE3MTQ5OTR9.xEwS4ewIDuPBDlLn2y5bmJciGa8Q4Lz5audbVnJuNNQ', '2020-07-10 15:03:14', 1),
	(6, 1, '2020-06-09 17:15:43', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDM5NDE0My4wMjIsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI1LjAiLCJpYXQiOjE1OTE3MTU3NDN9.CvdmjqBVTgWL18LivqxFaFSlNoToayQKpM096OBp3YM', '2020-07-10 15:15:43', 1),
	(7, 1, '2020-06-09 17:31:00', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDM5NTA2MC44MjYsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI1LjAiLCJpYXQiOjE1OTE3MTY2NjB9.-Sa6y8nxZlay2VdnUVEgAMw2lbDo-uagNCvw4lp2dGk', '2020-07-10 15:31:00', 1),
	(8, 1, '2020-06-09 17:34:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDM5NTI0Mi4zNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjUuMCIsImlhdCI6MTU5MTcxNjg0Mn0.143wLNp1AI63HoS1iFLsVSBJu0hDbGma80_OtzyHrtI', '2020-07-10 15:34:02', 1),
	(9, 1, '2020-06-11 12:05:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDU0ODMwNC43NjEsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTE4Njk5MDR9.DfAucJOhFZC89kn5A52ELoVeG-uMiDnd7Gmm4jQMWUU', '2020-07-12 10:05:04', 1),
	(10, 1, '2020-06-11 12:26:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDU0OTU2OS4wMSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MTg3MTE2OX0.w2C9-zA7BXemSKABnCAAikD-w89VD71d1dglP1B-nZA', '2020-07-12 10:26:09', 1),
	(11, 1, '2020-06-11 12:26:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDU0OTU4MC4wMDMsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTE4NzExODB9.FjVVHHbYCQA2K0nDabFUdryYo3XN8RPJejjDiBcJMHA', '2020-07-12 10:26:20', 1),
	(12, 1, '2020-06-11 12:27:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDU0OTY2MS42MjQsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTE4NzEyNjF9.ofyXIs1DVc40hltTwaEVShBDIuEw0wDWy0OSV9mDbfU', '2020-07-12 10:27:41', 1),
	(13, 1, '2020-06-11 12:32:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDU0OTkyNi4yOTEsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTE4NzE1MjZ9.YTJ9y-wELQSV_uZZ9fNZgLgyemJ2-Rn_BEuAWDFRh2E', '2020-07-12 10:32:06', 1),
	(14, 1, '2020-06-11 12:51:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6InRlc3RAdGVzdC5ycyIsImV4cCI6MTU5NDU1MTA3MC41NjQsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTE4NzI2NzB9.6sUHF9bhNYOBNGpt5TaW7npHhyuY2LQlGUzYWjSSprs', '2020-07-12 10:51:10', 1),
	(15, 5, '2020-07-09 11:18:45', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo1LCJpZGVudGl0eSI6InRlc3RpcmFuamVAZ21haWwuY29tIiwiZXhwIjoxNTk2OTY4MzI1LjgzMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyODk5MjV9.OJNgRtA-gorljSBXY7TL0-VYc8PkeOJ0ED4Z1iu13FE', '2020-08-09 10:18:45', 1),
	(16, 5, '2020-07-09 11:54:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo1LCJpZGVudGl0eSI6InRlc3RpcmFuamVAZ21haWwuY29tIiwiZXhwIjoxNTk2OTcwNDk3LjU1NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyOTIwOTd9.U-6CjTlSCXBacCEhlMfT_AtezDwjX6fn6BxYwl_1nA8', '2020-08-09 10:54:57', 1),
	(17, 5, '2020-07-09 11:56:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo1LCJpZGVudGl0eSI6InRlc3RpcmFuamVAZ21haWwuY29tIiwiZXhwIjoxNTk2OTcwNTczLjU5MiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjExNiBNb2JpbGUgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NDI5MjE3M30.yFqRIyugooXeHFiOkvQvJyTLU74p71H1_obBPnO_S6M', '2020-08-09 10:56:13', 1);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
