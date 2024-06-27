CREATE DATABASE  IF NOT EXISTS `inventario` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventario`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: inventario
-- ------------------------------------------------------
-- Server version	8.4.0

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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categorias` int NOT NULL,
  `desc_categorias` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_categorias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `id_estados` int NOT NULL,
  `desc_estados` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_estados`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Estados de la venta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_productos` int NOT NULL,
  `id_categorias` int DEFAULT NULL,
  `desc_productos` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_productos`),
  KEY `id_categorias_idx` (`id_categorias`),
  CONSTRAINT `FK_CATEGORIAS` FOREIGN KEY (`id_categorias`) REFERENCES `categorias` (`id_categorias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipospago`
--

DROP TABLE IF EXISTS `tipospago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipospago` (
  `id_tipospago` int NOT NULL,
  `desc_tipospago` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tipospago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_ventas` int NOT NULL,
  `id_estados` int DEFAULT NULL,
  `id_productos` int DEFAULT NULL,
  `id_tipospago` int DEFAULT NULL,
  `orden` int DEFAULT NULL,
  `fecha_venta` text,
  `cantidad_ordenada` int DEFAULT NULL,
  `precio` int DEFAULT NULL,
  `descuento` int DEFAULT NULL,
  `total` int DEFAULT NULL,
  PRIMARY KEY (`id_ventas`),
  KEY `FK_estados_idx` (`id_estados`),
  KEY `FK_PRODUCTOS_idx` (`id_productos`),
  KEY `FK_TIPOSPAGO_idx` (`id_tipospago`),
  CONSTRAINT `FK_estados` FOREIGN KEY (`id_estados`) REFERENCES `estados` (`id_estados`),
  CONSTRAINT `FK_PRODUCTOS` FOREIGN KEY (`id_productos`) REFERENCES `productos` (`id_productos`),
  CONSTRAINT `FK_TIPOSPAGO` FOREIGN KEY (`id_tipospago`) REFERENCES `tipospago` (`id_tipospago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-25 19:41:18
