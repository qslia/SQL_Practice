`SUBSTRING_INDEX(email, '@', -1)` is a **MySQL string function** used to extract part of a string **relative to a delimiter**.

---

## Syntax

```sql
SUBSTRING_INDEX(str, delim, count)
```

* **str**: the string to process
* **delim**: the delimiter
* **count**:

  * **positive** → return everything **to the left**
  * **negative** → return everything **to the right**

---

## What your expression does

```sql
SUBSTRING_INDEX(email, '@', -1)
```

➡️ **Returns everything after the `@` symbol**
➡️ Effectively extracts the **email domain**

---

## Examples

| email                | Result          |
| -------------------- | --------------- |
| `alice@gmail.com`    | `gmail.com`     |
| `bob@yahoo.com`      | `yahoo.com`     |
| `john@outlook.co.uk` | `outlook.co.uk` |

---

## Why `-1`?

* `-1` means:
  **split by `@`, take the last part**
* Since emails contain only one `@`, this safely returns the domain

Equivalent logic:

```text
email = local_part + '@' + domain
```

---

## Comparison with `+1`

```sql
SUBSTRING_INDEX(email, '@', 1)
```

| email             | Result  |
| ----------------- | ------- |
| `alice@gmail.com` | `alice` |

So:

* `1` → username
* `-1` → domain

---

## Your query in plain English

```sql
SELECT 
    SUBSTRING_INDEX(email, '@', -1) AS email_domain,
    COUNT(*) AS count
FROM Emails
WHERE email LIKE '%.com'
GROUP BY email_domain
ORDER BY email_domain;
```

👉 *“Group `.com` emails by their domain and count how many each domain has.”*

---

If you want, I can also show:

* how to do this **without `SUBSTRING_INDEX`**
* edge cases (`multiple @`, uppercase `.COM`)
* performance considerations

Just tell me 👍
