Great 👍 Let’s walk through a clear **LAG()** example.

---

### Example Table: Sales

| id | customer | order_date | amount |
| -- | -------- | ---------- | ------ |
| 1  | Alice    | 2023-01-01 | 100    |
| 2  | Alice    | 2023-01-10 | 200    |
| 3  | Alice    | 2023-01-15 | 150    |
| 4  | Bob      | 2023-01-02 | 300    |
| 5  | Bob      | 2023-01-20 | 400    |

---

### Query with `LAG()`

```sql
SELECT 
  customer,
  order_date,
  amount,
  LAG(amount) OVER (PARTITION BY customer ORDER BY order_date) AS prev_amount
FROM Sales;
```

---

### Step by Step

1. **Partition by customer** → separate Alice’s rows and Bob’s rows.
2. **Order by order_date** → sort each customer’s rows by date.
3. **LAG(amount)** → fetch the previous row’s amount within the partition.

---

### Result

| customer | order_date | amount | prev_amount |
| -------- | ---------- | ------ | ----------- |
| Alice    | 2023-01-01 | 100    | NULL        |
| Alice    | 2023-01-10 | 200    | 100         |
| Alice    | 2023-01-15 | 150    | 200         |
| Bob      | 2023-01-02 | 300    | NULL        |
| Bob      | 2023-01-20 | 400    | 300         |

---

### Why useful?

Now you can:

* Compare current vs. previous order (`amount - prev_amount`).
* Calculate gaps between dates (`order_date - LAG(order_date)`).
* Detect changes in behavior over time.

---

✅ So **LAG() = “look one row back, within the ordered window.”**

Would you like me to also show you an example with a **different offset** (e.g., `LAG(amount, 2)`) to look 2 rows back instead of 1?
