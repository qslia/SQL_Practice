SELECT
  CONCAT(p.FirstName, ' ', p.FamilyName)       AS Full_Name,
  a.IATA_Code                                  AS Departure_IATA,
  a.City                                       AS Departure_City
FROM Passengers9999 AS p
JOIN Bookings9999 AS b
  ON b.PassengerID = p.PassengerID
JOIN Flight_Booking9999 AS fb
  ON fb.BookingID = b.BookingID
JOIN Flights9999 AS f
  ON f.Flight_Number = fb.Flight_Number
  AND f.Scheduled_Departure_Date = fb.Scheduled_Departure_Date
  AND f.Scheduled_Departure_Time = fb.Scheduled_Departure_Time
JOIN Airports9999 AS a
  ON a.IATA_Code = f.Origin_Airport
WHERE p.State = 'Florida'       -- passenger lives in Florida
  AND a.State = 'FL'       -- departure airport also in Florida
ORDER BY Full_Name, Departure_IATA;
