1. List all flights by 2 airlines: American Airlines Inc. and United Airlines Inc. For every listed flight, your results should show IATA code and flight number. Within each IATA code the list should be sorted by flight number (default setting, i.e. ascending).
*(15 marks)*

2. List all flights that flew in the current year, i.e. 2025. Your list should show IATA code and flight number as one value (e.g. AA16), and scheduled departure date and time. The list should be sorted by flight number within airline code. Note, the code should work in the future years
*(15 marks)*


3. List all flights with the delay longer than 1 hour. Your list should show IATA code and flight number as one value (e.g. AA16), scheduled departure date and time, and the duration of the delay. The list should be sorted by time delay in descending order. Hint: explore the function TIMEDIFF(). You compare time stamps like strings, e.g. if you want to know whether a value equals 5 seconds, you will write ='00:00:05'
*(20 marks)*

4. Find the longest flight(s). Your list should show airline IATA code and flight number as one string (e.g. UA97), departure and arrival airports’ IATA code, scheduled departure time and distance.
   *(20 marks)*

5. List bookings that contain more than 1 flight. Your result set should list the booking IDs and number of flights in the booking, ordered by Booking ID.
   *(15 marks)*

6. List passengers from Florida (FL) who have bookings to fly from an airport in the same state where they live. Your list should show passenger full name as first and last name separated by space, IATA code and city of the departure airport. The list should be ordered by Full name and the IATA code.
   *(20 marks)*



7. List all aircrafts that are not allocated to any flights. Your list should show tail number, aircraft model, and airline IATA code and name. Order by aircraft model within each airline IATA code.
   *(20 marks)*

8. List all flights where city of the origin airport and city of the destination airport start with the same letter (e.g. origin airport city Augusta and the destination airport city is Atlanta – both start with A). The results should include IATA code and city of the origin airport, IATA code and city of the destination airport and scheduled departure date. The list should be in the order of IATA codes of origin airports.
   *(25 marks)*

9.
   a. Add yourself as a staff member. Staff ID is your student ID. Provide the SQL statement that will create this record.

   b. Add records to allocate yourself to at least 3 flights (your choice of flights). Provide the SQL statement(s) that will create the data.
*(5 marks)*


10. List yourself as a staff member with all fields including staff ID (which is your student ID), full name as first and last names separated by space, departure airport IATA code and city, scheduled departure date and time. This is the only SELECT statement where you do not need to start with StuID.
    *(15 marks)*

11.
    a. Write the SQL DDL to create a view that counts the number of flights completed by each staff member. Your list should include staff id, full name as first and last name separated by space and number of completed flights.

    Do not include StuID in this view.

    In addition to the code, you need to provide 2 screenshots:
    – the list of tables and views from the left pane of Workbench showing your created the view, and
    – the results of running SELECT from your View (we recommend explicitly showing the SELECT statement used to create the View).
    *(15 marks)*



    b. Using the View you created in Task 11a, list the staff members who completed the lowest number of flights. Your results need to display staff id, full name and the corresponding number of flights.

    You **must** include your student ID in task 11b.






