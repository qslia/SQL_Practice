select al.IATA_Code,
    f.Flight_Number
from flights9999 as f
    JOIN aircrafts9999 as ac on ac.Tail_Number = f.Tail_Number
    JOIN airlines9999 as al on al.IATA_Code = ac.Airline
where al.Airline in ('American Airlines Inc.', 'United Airlines Inc.')
ORDER BY IATA_Code,
    Flight_Number