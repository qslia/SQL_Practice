SELECT
  ac.Tail_Number,
  ac.Model,
  al.IATA_Code,
  al.Airline
FROM Aircrafts9999 AS ac
JOIN Airlines9999 AS al
  ON al.IATA_Code = ac.Airline
LEFT JOIN Flights9999 AS f
  ON f.Tail_Number = ac.Tail_Number
WHERE f.Tail_Number IS NULL
ORDER BY ac.Airline, ac.Model;
