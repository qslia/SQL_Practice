`DATEFROMPARTS` is a **SQL Server** built-in that creates a `date` value from year, month, and day integers.

**Syntax**

```sql
DATEFROMPARTS ( year, month, day )  -- returns a `date`
```

* Available in SQL Server 2012+
* Throws an error for invalid dates (e.g., `DATEFROMPARTS(2025,2,29)`)

**Examples**

```sql
-- Fixed date
SELECT DATEFROMPARTS(2025, 1, 1);            -- 2025-01-01

-- First day of the current year (auto-updates each year)
SELECT DATEFROMPARTS(YEAR(GETDATE()), 1, 1);

-- First day of next year (useful for upper bound)
SELECT DATEFROMPARTS(YEAR(GETDATE()) + 1, 1, 1);
```

**Why it’s popular for date filters**
Use a **left-closed, right-open** range to avoid end-of-year/time edge cases and make it future-proof:

```sql
WHERE dt >= DATEFROMPARTS(YEAR(GETDATE()), 1, 1)
  AND dt <  DATEFROMPARTS(YEAR(GETDATE()) + 1, 1, 1)
```

This captures all rows in the current year, even if `dt` is a `datetime`—SQL Server will handle the implicit conversion.

**Related “FROMPARTS” helpers**

* `DATETIMEFROMPARTS(y,m,d, hh,mi,ss,ms)` → `datetime`
* `DATETIME2FROMPARTS(...)` → `datetime2`
* `SMALLDATETIMEFROMPARTS(...)`
* `TIMEFROMPARTS(...)`
* `DATETIMEOFFSETFROMPARTS(...)`

> Note: `DATEFROMPARTS` is SQL Server–specific. Other databases use different functions (e.g., PostgreSQL `make_date`).
