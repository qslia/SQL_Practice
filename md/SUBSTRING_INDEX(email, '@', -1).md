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
