Good question — **which happens first: `SELECT` or `ORDER BY`?**

### Short Answer

In SQL **the data is ordered before the `LIMIT` is applied**, but the `SELECT` list is evaluated last.
So the logical processing order is:

1. **FROM**
2. **WHERE**
3. **GROUP BY**
4. **HAVING**
5. **SELECT**
6. **ORDER BY**
7. **LIMIT / OFFSET**

---

### Applied to your query:

```sql
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;
```

Logical processing:

| Step | Clause                   | What Happens                            |
| ---- | ------------------------ | --------------------------------------- |
| 1    | `FROM Employee`          | Load the table data                     |
| 2    | *(no WHERE)*             | Skip this step                          |
| 3    | *(no GROUP BY)*          | Skip                                    |
| 4    | *(no HAVING)*            | Skip                                    |
| 5    | `SELECT DISTINCT salary` | Return unique salaries                  |
| 6    | `ORDER BY salary DESC`   | Sort salaries from high to low          |
| 7    | `LIMIT 1 OFFSET 1`       | Skip the first row, return the next row |

---

### So to answer clearly:

* **`SELECT DISTINCT` happens before `ORDER BY`**, because we need to remove duplicates first.
* Then **`ORDER BY` sorts the distinct salaries**.
* Finally, **`LIMIT/OFFSET` picks the second one**.

---

If you'd like, I can also rewrite this query using **window functions**, which make the logic even clearer.
