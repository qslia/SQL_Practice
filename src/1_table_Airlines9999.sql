-- Active: 1752124648940@@127.0.0.1@3306@flight_management

-- DROP SCHEMA IF EXISTS `flight_management`;
-- CREATE SCHEMA IF NOT EXISTS `flight_management` DEFAULT CHARACTER SET utf8;

USE `flight_management`;

DROP TABLE IF EXISTS `Airlines9999`;

CREATE TABLE `Airlines9999` (
    `IATA_Code` CHAR(2),
    `Airline` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`IATA_Code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

LOCK TABLES `Airlines9999` WRITE;

INSERT INTO
    `Airlines9999`
VALUES ('UA', 'United Airlines Inc.'),
    (
        'AA',
        'American Airlines Inc.'
    ),
    ('US', 'US Airways Inc.'),
    (
        'F9',
        'Frontier Airlines Inc.'
    ),
    ('B6', 'JetBlue Airways'),
    ('OO', 'Skywest Airlines Inc.'),
    ('AS', 'Alaska Airlines Inc.'),
    ('NK', 'Spirit Airlines'),
    (
        'WN',
        'Southwest Airlines Co.'
    ),
    ('DL', 'Delta Air Lines Inc.'),
    (
        'EV',
        'Atlantic Southeast Airlines'
    ),
    (
        'HA',
        'Hawaiian Airlines Inc.'
    ),
    (
        'MQ',
        'American Eagle Airlines Inc.'
    ),
    ('VX', 'Virgin America');

UNLOCK TABLES;

