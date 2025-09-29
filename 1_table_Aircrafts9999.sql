DROP TABLE IF EXISTS `Airlines9999`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Airlines9999` (
    `IATA_Code` CHAR(2),
    `Airline` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`IATA_Code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `Airlines9999`
--
LOCK TABLES `Airlines9999` WRITE;
/*!40000 ALTER TABLE `Airlines9999` DISABLE KEYS */
;
INSERT INTO `Airlines9999`
VALUES ('UA', 'United Airlines Inc.'),
('AA', 'American Airlines Inc.'),
('US', 'US Airways Inc.'),
('F9', 'Frontier Airlines Inc.'),
('B6', 'JetBlue Airways'),
('OO', 'Skywest Airlines Inc.'),
('AS', 'Alaska Airlines Inc.'),
('NK', 'Spirit Airlines'),
('WN', 'Southwest Airlines Co.'),
('DL', 'Delta Air Lines Inc.'),
('EV', 'Atlantic Southeast Airlines'),
('HA', 'Hawaiian Airlines Inc.'),
('MQ', 'American Eagle Airlines Inc.'),
('VX', 'Virgin America');
/*!40000 ALTER TABLE `Airlines9999` ENABLE KEYS */
;
UNLOCK TABLES;