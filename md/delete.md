What if there is many duplicated rows
---
Great question! If there are many duplicated rows (more than 2 duplicates), the same `DELETE` statement still works correctly. Let me explain why:

## How it handles multiple duplicates

When you have multiple rows with the same email, the self-join creates pairs where `p1.id > p2.id`. The DELETE statement will remove ALL rows that have at least one smaller id with the same email.

**Example with 4 duplicates:**
```
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 3  | john@example.com |
| 5  | john@example.com |
| 7  | john@example.com |
+----+------------------+
```

The join finds:
- (3,1) → delete id=3
- (5,1) → delete id=5  
- (5,3) → delete id=5
- (7,1) → delete id=7
- (7,3) → delete id=7
- (7,5) → delete id=7

After the DELETE, only id=1 remains because:
- id=3 has a smaller id (1) → deleted
- id=5 has smaller ids (1,3) → deleted
- id=7 has smaller ids (1,3,5) → deleted
- id=1 has no smaller id with same email → kept

## Alternative approach using subquery

If you prefer a more explicit approach, you can also use:

```sql
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);
```

But the self-join method is generally more efficient and works the same way regardless of how many duplicates exist. Only the row with the minimum id for each email survives.

## Important note
MySQL has a limitation where you can't directly reference the table you're deleting from in a subquery. If using the subquery approach in MySQL, you'd need a workaround like:

```sql
DELETE FROM Person
WHERE id NOT IN (
    SELECT * FROM (
        SELECT MIN(id)
        FROM Person
        GROUP BY email
    ) AS temp
);
```

But the self-join approach (`DELETE p1 FROM Person p1 INNER JOIN Person p2...`) works perfectly in all SQL dialects and handles any number of duplicates correctly.