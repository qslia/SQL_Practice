Excellent question 👍

In **MySQL**, the function

```sql
SUBSTRING_INDEX(str, delimiter, count)
```

extracts a substring from `str` **based on a delimiter** — but the behavior depends on the value of **`count`** (the third argument).

---

### 🧩 Syntax:

```sql
SUBSTRING_INDEX(string, delimiter, count)
```

* **`string`** → the text you want to extract from (e.g. `'abc@xyz.com'`)
* **`delimiter`** → the character used to split (e.g. `'@'`)
* **`count`** → controls **how many parts** and **which side** you get

---

### 📘 How `count` works:

| count value          | what it does                                              | example (`'abc@xyz.com'`)                 | result      |
| -------------------- | --------------------------------------------------------- | ----------------------------------------- | ----------- |
| positive (e.g. `1`)  | returns everything **to the left** of the first delimiter | `SUBSTRING_INDEX('abc@xyz.com', '@', 1)`  | `'abc'`     |
| negative (e.g. `-1`) | returns everything **to the right** of the last delimiter | `SUBSTRING_INDEX('abc@xyz.com', '@', -1)` | `'xyz.com'` |

---

### 💡 In your query:

```sql
SUBSTRING_INDEX(email, '@', -1)
```

→ means:
“**Get the part of the email after the last ‘@’ symbol**,”
which gives you the **email domain** — for example:

| email              | result        |
| ------------------ | ------------- |
| `user@gmail.com`   | `gmail.com`   |
| `mark@outlook.com` | `outlook.com` |

---

So the `-1` tells MySQL:

> "Take the substring **after the last occurrence** of the delimiter."

<br>


Good follow-up. Think of SQL as having a **logical execution sequence** (not the order you write it).

For your query, the sequence is:

---

## Logical execution order of SQL

1️⃣ **FROM**

```sql
FROM Emails
```

→ SQL loads rows from the `Emails` table.

---

2️⃣ **WHERE**

```sql
WHERE email LIKE '%.com'
```

→ Filters rows **before grouping**
Only `.com` emails remain.

---

3️⃣ **GROUP BY**

```sql
GROUP BY email_domain
```

→ Rows are **grouped by domain**
All rows with the same `split_part(email, '@', 2)` are put into one group.

Example groups:

```
gmail.com  → [a@gmail.com, b@gmail.com]
yahoo.com  → [c@yahoo.com]
```

---

4️⃣ **Aggregate functions**

```sql
COUNT(*)
```

→ Runs **once per group**
Counts how many rows are in each domain group.

---

5️⃣ **SELECT**

```sql
SELECT
    split_part(email, '@', 2) AS email_domain,
    COUNT(*) AS count
```

→ Produces **one output row per group**

---

6️⃣ **ORDER BY**

```sql
ORDER BY email_domain
```

→ Sorts the final result set.

---

## Why `GROUP BY email` breaks it

If you group by `email`, step 3 becomes:

```
a@gmail.com → [a@gmail.com]
b@gmail.com → [b@gmail.com]
```

So:

* Each group has **1 row**
* `COUNT(*)` is always `1`
* Domains never get merged

---

## Logical vs written order (important)

### Written order

```sql
SELECT
FROM
WHERE
GROUP BY
ORDER BY
```

### Actual execution order

```
FROM
→ WHERE
→ GROUP BY
→ AGGREGATES
→ SELECT
→ ORDER BY
```

This is why:

* `WHERE` can’t use aggregate functions
* `SELECT` aliases **can** be used in `ORDER BY`
* `GROUP BY` defines what “one row” means

---

## One-line takeaway

> **GROUP BY decides what “one row” represents; SELECT just formats it.**

If you want, next I can explain:

* `HAVING` vs `WHERE`
* why aliases work in `ORDER BY` but not `WHERE`
* how SQL optimizers change the physical execution

Just say 👍

