You’re already very close 👍 — you’re using **SQL Server Management Studio (SSMS)**. Here are **all the common ways to see tables**.

---

## 1️⃣ From the Object Explorer (what you’re already looking at)

![Image](https://www.ssmsboost.com/content/images/feature/ssms-add-in-locate-object.png)

![Image](https://www.gethynellis.com/wp-content/uploads/2024/06/2_CreateTableinSSMS.png)

![Image](https://dataedo.com/asset/img/kb/db-tools/ssms/ssms_select_all_tables.png)

1. In **Object Explorer** (left panel):

   ```
   Databases
     └─ StudentManagementDB
         └─ Tables
   ```
2. Expand **Tables**
3. You’ll see tables like:

   * `dbo.Courses`
   * `dbo.Students`
   * `dbo.Enrollments`
   * etc.

👉 **That list *is* your tables**.

---

## 2️⃣ View table data (actual rows)

To **see what’s inside a table**:

### Method A: Right-click

1. Right-click a table (e.g. `dbo.Students`)
2. Click:

   * **Select Top 1000 Rows**

This opens a query window with data.

---

### Method B: Write SQL

```sql
SELECT * FROM dbo.Students;
```

Run it (▶ or **F5**) to see all rows.

---

## 3️⃣ See table structure (columns, types)

To see **columns and data types**:

### Option A: Designer

1. Right-click table → **Design**
2. You’ll see:

   * Column names
   * Data types
   * Primary keys
   * Nullability

### Option B: SQL

```sql
EXEC sp_help 'dbo.Students';
```

or

```sql
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Students';
```

---

## 4️⃣ See relationships (ER diagram)

You already have this option 👇

1. Right-click **StudentManagementDB**
2. Click **Database Diagrams**
3. Open or create a diagram

This shows:

* Foreign keys
* Relationships between tables

---

## 5️⃣ If you **don’t see tables**

Try this:

* Right-click **Tables** → **Refresh**
* Make sure you expanded the **correct database**
* Ensure you’re not inside **System Tables** only

---

### Quick summary

| Task           | How                                |
| -------------- | ---------------------------------- |
| See table list | Object Explorer → Tables           |
| View data      | Right-click → Select Top 1000 Rows |
| See columns    | Design / `INFORMATION_SCHEMA`      |
| See relations  | Database Diagrams                  |

If you want, tell me:

* **Which table you want to inspect**, or
* **What you want to do next** (query, joins, constraints, insert data)

I’ll guide you step by step 🚀
