## UNION vs UNION ALL

Both `UNION` and `UNION ALL` are used to combine results from multiple SELECT statements, but they have a key difference:

### UNION
- **Removes duplicate rows** from the combined result set
- Performs a DISTINCT operation on the final result
- **Slower** because it needs to check for duplicates
- Use when you want unique records only

### UNION ALL
- **Keeps all rows**, including duplicates
- Does not remove duplicates
- **Faster** because it doesn't check for duplicates
- Use when you want all records or know there are no duplicates

## Examples:

### Example 1: With Duplicates
```sql
-- Table A: [1, 2, 3]
-- Table B: [2, 3, 4]

SELECT id FROM TableA
UNION
SELECT id FROM TableB;
-- Result: [1, 2, 3, 4] (removes duplicates 2, 3)

SELECT id FROM TableA
UNION ALL
SELECT id FROM TableB;
-- Result: [1, 2, 3, 2, 3, 4] (keeps all)
```

### Example 2: For the missing information problem

**Using UNION (removes duplicates):**
```sql
-- If somehow an employee_id appears in both queries
-- (shouldn't happen in this problem, but just for example)
SELECT employee_id FROM Employees WHERE name IS NULL
UNION
SELECT employee_id FROM Salaries WHERE salary IS NULL
-- Returns unique employee_ids only
```

**Using UNION ALL (keeps all):**
```sql
SELECT employee_id FROM Employees WHERE name IS NULL
UNION ALL
SELECT employee_id FROM Salaries WHERE salary IS NULL
-- Returns all rows, even if same employee_id appears twice
```

## For Our Problem:

Since we're finding:
1. Employees in Employees table but not in Salaries
2. Employees in Salaries table but not in Employees

An employee cannot be in both categories simultaneously, so there will be no duplicates. However, **it's still safer to use `UNION`** to ensure unique results.

### Most Efficient Solution for Our Problem:
```sql
-- Since we know there won't be duplicates between the two sets,
-- we can use UNION (for safety) or UNION ALL (for speed)
SELECT employee_id
FROM Employees
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries)

UNION ALL  -- Using UNION ALL since we know no duplicates

SELECT employee_id
FROM Salaries
WHERE employee_id NOT IN (SELECT employee_id FROM Employees)

ORDER BY employee_id;
```

## Performance Comparison:
- **UNION ALL** is always faster than **UNION**
- Only use **UNION** when you actually need to remove duplicates
- If you're certain there are no duplicates, use **UNION ALL** for better performance

## Visual Representation:
```
Table A: [1, 2, 3]
Table B: [3, 4, 5]

A UNION B:     [1, 2, 3, 4, 5]     ← No duplicates
A UNION ALL B: [1, 2, 3, 3, 4, 5]  ← Keeps duplicate 3
```

For the employee missing information problem, both `UNION` and `UNION ALL` will give the same result since there are no duplicates between the two sets.