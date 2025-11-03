Excellent question — this is one of the **most important SQL concepts** to understand about joins.
Let’s break it down carefully 👇

---

## 🧩 1. What a `LEFT JOIN` really does

A `LEFT JOIN` means:

> “Give me **all rows from the left table**, and if there are matches in the right table, include them; if not, fill them with `NULL`.”

Example:

**Prices (left table):**

| product_id | price |
| ---------- | ----- |
| 1          | 5     |
| 2          | 10    |
| 3          | 7     |

**UnitsSold (right table):**

| product_id | units |
| ---------- | ----- |
| 1          | 100   |

---

If you do:

```sql
SELECT *
FROM Prices p
LEFT JOIN UnitsSold u
  ON p.product_id = u.product_id;
```

✅ Result:

| p.product_id | p.price | u.product_id | u.units |
| ------------ | ------- | ------------ | ------- |
| 1            | 5       | 1            | 100     |
| 2            | 10      | NULL         | NULL    |
| 3            | 7       | NULL         | NULL    |

Products 2 and 3 stay, even though they had **no matches** — that’s what `LEFT JOIN` guarantees.

---

## 🚫 2. What happens when you add a `WHERE` filter on the right table

If you now write:

```sql
SELECT *
FROM Prices p
LEFT JOIN UnitsSold u
  ON p.product_id = u.product_id
WHERE u.units > 0;
```

Here’s what happens:

* For rows where there **was no match**, `u.units` is `NULL`.
* The `WHERE` condition `u.units > 0` is **false** for `NULL` values.
* Therefore, those rows get **filtered out** after the join.

❌ Result:

| p.product_id | p.price | u.product_id | u.units |
| ------------ | ------- | ------------ | ------- |
| 1            | 5       | 1            | 100     |

Products 2 and 3 are gone.
Your `LEFT JOIN` effectively **became an INNER JOIN** because of the filter.

---

## ✅ 3. The fix — move the condition into the `ON` clause

Instead of filtering *after* the join, apply it *as part of the join condition*:

```sql
SELECT *
FROM Prices p
LEFT JOIN UnitsSold u
  ON p.product_id = u.product_id
 AND u.purchase_date BETWEEN p.start_date AND p.end_date;
```

Now the condition affects **matching**, not **filtering**.
Rows that don’t meet the date condition or have no matches remain — with `NULL` values for `u.*`.

✅ This preserves the **LEFT JOIN** behavior.

---

### 🧠 TL;DR Summary

| Location of condition | Effect                                                                                                       |
| --------------------- | ------------------------------------------------------------------------------------------------------------ |
| `ON` clause           | Affects **which rows match**, but keeps all from the left table                                              |
| `WHERE` clause        | Affects **which rows are kept** after joining — can remove unmatched rows, turning LEFT JOIN into INNER JOIN |

---

Would you like me to show a simple side-by-side demo with sample data that visually proves the difference?
