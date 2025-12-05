Yes, that's correct! When you list two tables/subqueries separated by a comma in the FROM clause:

```sql
FROM 
    (subquery1) ny,
    (subquery2) ca
```

This is equivalent to a **CROSS JOIN** (or Cartesian product). In PostgreSQL and most SQL databases, comma-separated tables in the FROM clause represent an implicit cross join.

So both of these are equivalent:

**Your version (implicit CROSS JOIN):**
```sql
FROM
    (select count(*) as excellent_student from NewYork where score >= 90) ny,
    (select count(*) as excellent_student from California where score >= 90) ca
```

**Explicit CROSS JOIN version:**
```sql
FROM
    (select count(*) as excellent_student from NewYork where score >= 90) ny
CROSS JOIN
    (select count(*) as excellent_student from California where score >= 90) ca
```

Both will produce the same result. The explicit `CROSS JOIN` syntax is generally preferred for clarity, but your version with the comma is syntactically correct and will work.

Since each subquery returns exactly one row (a count), the cross join will produce exactly one row in the result, which is what you want for this comparison.