`LIMIT` is used in SQL to control **how many rows** are returned from a query.

### `LIMIT 1`

This means:

> **Return only 1 row** from the result set.

---

### Example

If your result after sorting looks like this:

| salary |
| ------ |
| 300    |
| 200    |
| 100    |

Then:

```sql
SELECT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1;
```

will return only the first row:

| salary |
| ------ |
| 300    |

---

### `LIMIT 1 OFFSET 1`

* `OFFSET 0` means start from the first row
* `OFFSET 1` means skip the first row and return the next row

So:

```sql
LIMIT 1 OFFSET 1
```

means:

> Skip the highest salary and return the next highest salary.

From:

| salary |
| ------ |
| 300    |
| 200    |
| 100    |

`LIMIT 1 OFFSET 1` returns:

| salary |
| ------ |
| 200    |

---

So in short:

| Clause             | Meaning                                          |
| ------------------ | ------------------------------------------------ |
| `LIMIT 1`          | Return only one row                              |
| `LIMIT 1 OFFSET 1` | Skip one row (the first) and return the next one |

Let me know if you'd like to see this demonstrated with a concrete query!
