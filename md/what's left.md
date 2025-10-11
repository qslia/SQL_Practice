Good question 👍

In **MySQL**, the **`LEFT()`** function is used to extract a specific number of characters from the **left side** (beginning) of a string.

### 🧩 Syntax:

```sql
LEFT(string, number_of_characters)
```

### 📘 Example:

```sql
SELECT LEFT('Engineer', 1);
```

**Result:**

```
E
```

So in your query:

```sql
LEFT(profession, 1)
```

it means:
➡️ Take **only the first letter** from the `profession` column (for example, `'Engineer'` → `'E'`, `'Doctor'` → `'D'`).

That’s how we get results like **Tyson(E)** or **Messi(D)**.
