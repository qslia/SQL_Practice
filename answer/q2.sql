-- SELECT
--   CONCAT(ac.Airline, f.Flight_Number) AS FlightCode,
--   f.Scheduled_Departure_Date, f.Scheduled_Departure_Time AS ScheduledDeparture
-- FROM flights9999 AS f
-- JOIN aircrafts9999 AS ac
--   ON ac.Tail_Number = f.Tail_Number
-- WHERE f.Scheduled_Departure_Date >= MAKEDATE(YEAR(CURDATE()), 1)
--   AND f.Scheduled_Departure_Date <  MAKEDATE(YEAR(CURDATE()) + 1, 1)
-- ORDER BY
--   ac.Airline,
--   CAST(f.Flight_Number AS UNSIGNED),
--   f.Flight_Number;
            

SELECT
  CONCAT(ac.Airline, f.Flight_Number) AS FlightCode,             -- e.g., AA16
  TIMESTAMP(f.Scheduled_Departure_Date, f.Scheduled_Departure_Time) AS ScheduledDeparture
FROM flights9999 AS f
JOIN aircrafts9999 AS ac
  ON ac.Tail_Number = f.Tail_Number
WHERE f.Scheduled_Departure_Date >= MAKEDATE(YEAR(CURDATE()), 1)
  AND f.Scheduled_Departure_Date <  MAKEDATE(YEAR(CURDATE()) + 1, 1)
ORDER BY
  ac.Airline,
  CAST(f.Flight_Number AS UNSIGNED),   -- numeric sort within airline
  f.Flight_Number;                     -- fallback if alphanumeric

