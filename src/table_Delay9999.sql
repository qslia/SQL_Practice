DROP TABLE IF EXISTS `Flights9999`;
DROP TABLE IF EXISTS `Delay9999`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `Delay9999` (
    `Delay_Code` SMALLINT,
    `Reason` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`Delay_Code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `Delay9999`
--
LOCK TABLES `Delay9999` WRITE;
/*!40000 ALTER TABLE `Delay9999` DISABLE KEYS */
;
INSERT INTO `Delay9999`
VALUES (1, 'Air Traffic Control'),
(2, 'Weather'),
(3, 'Late Arrival of Aircraft'),
(4, 'Maintenance'),
(5, 'Crew Availability'),
(6, 'Security Clearance'),
(7, 'Baggage Handling Delay'),
(8, 'Fueling Delay'),
(9, 'Ground Operations'),
(10, 'Airline Scheduling / Logistics'),
(11, 'Documentation Issues'),
(12, 'Equipment Malfunction'),
(13, 'Passenger-related Delay'),
(14, 'Runway Congestion'),
(15, 'Miscellaneous / Other');
/*!40000 ALTER TABLE `Delay9999` ENABLE KEYS */
;
UNLOCK TABLES;