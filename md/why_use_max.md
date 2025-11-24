Great question — **why do we use `MAX()`** when extracting `start_time` and `end_time`?

---

# ✅ Why `MAX()` Is Used

In this table, each `(machine_id, process_id)` has **exactly two rows**:

| activity_type | timestamp |
| ------------- | --------- |
| start         | X         |
| end           | Y         |

We pivot these two rows into **one row**:

```
start_time | end_time
```

To do that in SQL, we use **conditional aggregation**:

```sql
MAX(CASE WHEN activity_type = 'start' THEN timestamp END)
```

But why MAX?

---

# ✅ Reason 1: Aggregation Requires an Aggregate Function

Because we are grouping:

```sql
GROUP BY machine_id, process_id
```

→ Every SELECT column must be either:

* in `GROUP BY`, or
* an aggregate function (`SUM`, `MAX`, `MIN`, etc.)

The expression:

```sql
CASE WHEN activity_type = 'start' THEN timestamp END
```

is **not an aggregate**, so SQL will reject it unless we wrap it with `MAX`, `MIN`, etc.

---

# ✅ Reason 2: MAX/MIN return the same value when only one row matches

For each group, `activity_type = 'start'` matches **only one row**, so:

```
MAX(timestamp) = timestamp
MIN(timestamp) = timestamp
```

Same for `"end"`.

So MAX doesn't change the value — it just allows SQL to extract it.

---

# ✅ Reason 3: MAX is standard for pivoting

This pattern is widely used to convert rows → columns:

```sql
MAX(CASE WHEN condition THEN value END)
```

Because:

* If the condition matches → returns that value.
* If not → returns null.
* MAX chooses the non-null value.

Example:

```
Rows:
start → 0.712
end   → 1.520

MAX(CASE WHEN start) = 0.712
MAX(CASE WHEN end)   = 1.520
```

---

# ⭐ Summary

We use `MAX()` because:

1. SQL requires an aggregate when grouping.
2. Each group has only one matching timestamp, so MAX just picks that value.
3. It’s the standard method for pivoting rows into columns.

---

If you want, I can rewrite it using `JOIN` instead of `MAX()` to show an alternative approach.

<br>

Yes — **you can absolutely use `MIN()` instead of `MAX()`**, and the result will be **exactly the same** for this problem.

---

# ✅ Why MIN() Works

For each `(machine_id, process_id)` pair, there is:

* **exactly one** `start` row
* **exactly one** `end` row

So inside the grouped rows:

```
start timestamp:   only one value → MIN = MAX = that value
end timestamp:     only one value → MIN = MAX = that value
```

Example (machine 0, process 0):

| activity_type | timestamp |
| ------------- | --------- |
| start         | 0.712     |
| end           | 1.520     |

So:

```
MAX(start) = 0.712
MIN(start) = 0.712
MAX(end)   = 1.520
MIN(end)   = 1.520
```

Both return the same.

---

# ✅ Using MIN() Version (Perfectly Valid)

```sql
SELECT 
    machine_id,
    ROUND(AVG(end_time - start_time), 3) AS processing_time
FROM (
    SELECT 
        machine_id,
        process_id,
        MIN(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
        MIN(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM Activity
    GROUP BY machine_id, process_id
) AS t
GROUP BY machine_id;
```

This works 100%.

---

# ❗ When MIN() ≠ MAX()

Only in scenarios like:

* multiple `start` logs for the same process
* repeated `end` logs
* noisy or corrupted logs

But **LeetCode guarantees exactly one start and one end**, so MIN and MAX behave identically.

---

# ⭐ Conclusion

✔ Yes, you can use `MIN()`
✔ It returns the same results
✔ Both MIN() and MAX() are acceptable for conditional pivoting

If you'd like, I can also show an alternative solution without MIN/MAX using `JOIN`.
