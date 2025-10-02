# 📋 SQL Assignment Questions

---

## Question 1 | **15 marks**

List all flights by 2 airlines: **American Airlines Inc.** and **United Airlines Inc.**

**Requirements:**
- Show IATA code and flight number
- Sort by flight number within each IATA code (ascending)

---

## Question 2 | **15 marks**

List all flights that flew in the current year (2025).

**Requirements:**
- Display IATA code and flight number as one value (e.g., `AA16`)
- Show scheduled departure date and time
- Sort by flight number within airline code
- ⚠️ **Note:** Code should work in future years

---

## Question 3 | **20 marks**

List all flights with delays longer than 1 hour.

**Requirements:**
- Display IATA code and flight number as one value (e.g., `AA16`)
- Show scheduled departure date and time
- Show duration of delay
- Sort by time delay (descending)

**Hints:**
- Explore the `TIMEDIFF()` function
- Compare timestamps like strings (e.g., `='00:00:05'` for 5 seconds)

---

## Question 4 | **20 marks**

Find the longest flight(s).

**Requirements:**
- Display airline IATA code and flight number as one string (e.g., `UA97`)
- Show departure and arrival airports' IATA codes
- Show scheduled departure time and distance

---

## Question 5 | **15 marks**

List bookings that contain more than 1 flight.

**Requirements:**
- Show booking IDs and number of flights in each booking
- Order by Booking ID

---

## Question 6 | **20 marks**

List passengers from Florida (FL) who have bookings to fly from an airport in the same state where they live.

**Requirements:**
- Show passenger full name (first and last name separated by space)
- Show IATA code and city of departure airport
- Order by Full name and IATA code

---

## Question 7 | **20 marks**

List all aircrafts that are not allocated to any flights.

**Requirements:**
- Show tail number, aircraft model
- Show airline IATA code and name
- Order by aircraft model within each airline IATA code

---

## Question 8 | **25 marks**

List all flights where the city of the origin airport and city of the destination airport start with the same letter.

**Example:** Augusta → Atlanta (both start with "A")

**Requirements:**
- Show origin airport: IATA code and city
- Show destination airport: IATA code and city
- Show scheduled departure date
- Order by origin airport IATA codes

---

## Question 9 | **5 marks**

### Part A
Add yourself as a staff member.
- Staff ID = your student ID
- Provide the SQL `INSERT` statement

### Part B
Add records to allocate yourself to at least 3 flights (your choice).
- Provide the SQL statement(s) to create the data

---

## Question 10 | **15 marks**

List yourself as a staff member with all fields.

**Requirements:**
- Show staff ID (your student ID)
- Show full name (first and last names separated by space)
- Show departure airport IATA code and city
- Show scheduled departure date and time
- ⚠️ **Note:** This is the only SELECT statement where you do NOT need to start with `StuID`

---

## Question 11 | **15 marks**

### Part A
Write the SQL DDL to create a view that counts the number of flights completed by each staff member.

**Requirements:**
- Include: staff ID, full name (first and last name separated by space), number of completed flights
- Do NOT include `StuID` in this view

**Submission Requirements:**
- Provide the SQL code
- Provide 2 screenshots:
  - The list of tables and views from the left pane of Workbench showing your created view
  - The results of running `SELECT` from your View (showing the SELECT statement used to create the View)

### Part B
Using the View you created in Task 11a, list the staff members who completed the lowest number of flights.

**Requirements:**
- Display: staff ID, full name, number of flights
- ⚠️ **You MUST include your student ID in task 11b**

---

**End of Questions**






