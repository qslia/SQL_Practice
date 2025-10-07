SELECT
  CONCAT(al.IATA_Code, f.Flight_Number) AS Flight,       -- e.g., UA97
  f.Origin_Airport                       AS Origin_IATA,
  f.Destination_Airport                  AS Destination_IATA,
  f.Scheduled_Departure_Time             AS Scheduled_Departure_Time,
  f.Distance                             AS Distance
FROM Flights9999 AS f
JOIN Aircrafts9999 AS ac
  ON ac.Tail_Number = f.Tail_Number
JOIN Airlines9999 AS al
  ON al.IATA_Code = ac.Airline
WHERE f.Distance = (SELECT MAX(Distance) FROM Flights9999);
