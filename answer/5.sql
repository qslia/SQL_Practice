SELECT
  fb.BookingID,
  COUNT(*) AS Num_Flights
FROM Flight_Booking9999 AS fb
GROUP BY fb.BookingID
HAVING COUNT(*) > 1
ORDER BY fb.BookingID;
