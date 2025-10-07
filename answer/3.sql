SELECT
  CONCAT(a.Airline, f.Flight_Number)        AS Flight,                 -- e.g., AA16
  f.Scheduled_Departure_Date                AS Scheduled_Departure_Date,
  f.Scheduled_Departure_Time                AS Scheduled_Departure_Time,
  TIMEDIFF(f.Departure_Time, f.Scheduled_Departure_Time) AS Delay     -- duration of delay
FROM Flights9999 AS f
JOIN Aircrafts9999 AS ac
  ON ac.Tail_Number = f.Tail_Number
JOIN Airlines9999 AS a
  ON a.IATA_Code = ac.Airline
WHERE
  f.Scheduled_Departure_Time IS NOT NULL
  AND f.Departure_Time IS NOT NULL
  AND TIMEDIFF(f.Departure_Time, f.Scheduled_Departure_Time) > '01:00:00'  -- > 1 hour
ORDER BY
  TIMEDIFF(f.Departure_Time, f.Scheduled_Departure_Time) DESC;            -- longest delay first
