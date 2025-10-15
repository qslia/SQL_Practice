```sql
-- Write your MySQL query statement below
SELECT w2.id
FROM Weather w1
JOIN Weather w2
  ON DATEDIFF(w2.recordDate, w1.recordDate) = 1
WHERE w2.temperature > w1.temperature;
```

Alternative (MySQL 8.0+ with window functions):

```sql
WITH t AS (
  SELECT id, recordDate, temperature,
         LAG(recordDate) OVER (ORDER BY recordDate)  AS prev_date,
         LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp
  FROM Weather
)
SELECT id
FROM t
WHERE DATEDIFF(recordDate, prev_date) = 1
  AND temperature > prev_temp;
```
<br><br><br><br>
In **MySQL**, the `DATEDIFF()` function returns the **difference in days** between two date values.

### 🧠 Syntax:

```sql
DATEDIFF(date1, date2)
```

👉 It calculates `date1 - date2`, meaning:

* If `date1` is **later** than `date2`, the result is **positive**.
* If `date1` is **earlier**, the result is **negative**.

---

### 🧩 Example:

```sql
SELECT DATEDIFF('2025-01-05', '2025-01-01') AS diff;
```

**Output:**

```
diff
----
4
```

Because there are 4 days between January 1 and January 5.

---

### 💡 In your query:

```sql
ON DATEDIFF(w2.recordDate, w1.recordDate) = 1
```

This means:

> Join each day (`w2`) with the **previous day** (`w1`) — where the difference between their dates is exactly 1 day.

So you can compare today’s temperature with **yesterday’s** temperature.
