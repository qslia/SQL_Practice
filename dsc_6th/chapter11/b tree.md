what is binary search tree and balanced binary search tree
---
## Binary Search Tree (BST)

A **Binary Search Tree** is a binary tree data structure where each node has at most two children, and it satisfies the **BST property**:

- For any node, all nodes in its **left subtree** have values **less than** the node's value
- All nodes in its **right subtree** have values **greater than** the node's value

### Key Operations & Time Complexities (average case):
| Operation | Time |
|-----------|------|
| Search    | O(log n) |
| Insert    | O(log n) |
| Delete    | O(log n) |

### Example of a BST:
```
        8
       / \
      3   10
     / \    \
    1   6    14
       / \   /
      4   7 13
```

### The Problem with BSTs
In the **worst case**, a BST can become **skewed** (like a linked list), causing operations to degrade to **O(n)**:

```
1
 \
  2
   \
    3
     \
      4
       \
        5
```

---

## Balanced Binary Search Tree

A **Balanced Binary Search Tree** is a BST that automatically keeps its height **O(log n)** by maintaining roughly equal left and right subtree sizes for every node.

### Key Property:
For every node, the **height difference** between left and right subtrees is bounded (typically ≤ 1 or a small constant).

### Self-Balancing BST Variants:

| Type | Balance Condition |
|------|-------------------|
| **AVL Tree** | Height difference ≤ 1 for every node |
| **Red-Black Tree** | Color constraints ensuring longest path ≤ 2× shortest path |
| **Splay Tree** | Recently accessed nodes move to root |
| **B-Tree** | Used in databases/file systems (multiple keys per node) |

### Time Complexities (guaranteed):
| Operation | Time |
|-----------|------|
| Search    | **O(log n)** |
| Insert    | **O(log n)** |
| Delete    | **O(log n)** |

### Example (AVL Tree with balance factors):
```
        8 (0)
       / \
     (1)3  10(0)
       / \    \
     (0)1 6(0) 14(0)
```

---

## Comparison Summary

| Feature | BST | Balanced BST |
|---------|-----|---------------|
| **Height** | O(n) worst case | O(log n) guaranteed |
| **Search time** | O(n) worst | O(log n) |
| **Implementation complexity** | Simple | Moderate to complex |
| **When to use** | Static data, random insert order | Dynamic data, guaranteed performance |

### When to use which?
- **BST**: Simple applications, data inserted in random order, no worst-case concerns
- **Balanced BST**: Mission-critical systems, real-time applications, databases, when predictable performance matters
---
what is balanced tree
---
## Balanced Tree

A **balanced tree** is a tree data structure where the heights of any node's left and right subtrees differ by at most a constant factor (typically 1 or a small value). This ensures the tree remains **shallow** and operations like search, insert, and delete take **O(log n)** time in the worst case.

## Core Concept

In an **unbalanced tree**, height can become **O(n)** (like a chain). In a **balanced tree**, height is kept to **O(log n)**.

```
Unbalanced (O(n) height):     Balanced (O(log n) height):

    1                               8
     \                             / \
      2                           4   12
       \                         / \  / \
        3                       2  6 10 14
         \                     / \    /
          4                   1   3  9
           \
            5
```

## Balance Conditions (by tree type)

| Tree Type | Balance Condition |
|-----------|-------------------|
| **AVL Tree** | Height difference ≤ 1 for **every** node |
| **Red-Black Tree** | Paths from root to leaves have same number of black nodes; longest path ≤ 2× shortest path |
| **B-Tree** | Every node (except root) has between t-1 and 2t-1 keys |
| **Weight-balanced Tree** | Left and right subtree sizes are proportional |
| **Treap** | Heap property on random priorities ensures balance probabilistically |

## Examples of Balanced Trees

### 1. Perfectly Balanced (ideal, but hard to maintain)
```
        8
       / \
      4   12
     / \  / \
    2  6 10 14
```

### 2. AVL Tree (height diff ≤ 1)
```
        8 (balance factor=1)
       / \
      4   12 (0)
     / \    \
    2  6(0)  14(0)
```

### 3. Red-Black Tree (visual balance)
```
        8(B)
       / \
      4(R) 12(R)
     / \    \
    2(B)6(B) 14(B)
```

## Why Balance Matters

| Metric | Unbalanced Tree | Balanced Tree |
|--------|----------------|---------------|
| **Height** | O(n) | O(log n) |
| **Search time** | O(n) worst case | O(log n) guaranteed |
| **Insert time** | O(n) worst case | O(log n) guaranteed |
| **Delete time** | O(n) worst case | O(log n) guaranteed |

## How Balance is Maintained

Balanced trees use **rotations** or **restructuring** operations after insertions/deletions:

```
Left Rotation (AVL/RB Tree):
    
    y              x
   / \            / \
  x   C   →      A   y
 / \                / \
A   B              B   C

Right Rotation:
    x                y
   / \              / \
  A   y      →     x   C
     / \          / \
    B   C        A   B
```

## Applications

| Use Case | Typical Balanced Tree |
|----------|----------------------|
| Database indexes | B-Tree, B+Tree |
| In-memory sorted maps | Red-Black Tree (Java TreeMap, C++ std::map) |
| High-performance lookups | AVL Tree |
| File systems | B-Tree variants |
| Network routing | Radix Tree, Patricia Trie |

## Summary

> A **balanced tree** is any tree that maintains **O(log n)** height through structural constraints, ensuring efficient operations regardless of insertion/deletion order. Different variants trade off between:
> - Strictness of balance (AVL strictest)
> - Overhead per operation (Red-Black lighter)
> - Cache efficiency (B-Tree best for disk)
> - Implementation simplicity (Treap simplest)
---
Does balanced tree equal to balanced bst
---
## No, they are NOT exactly equal

A **balanced tree** is a broader concept. A **balanced BST** is a specific type of balanced tree.

## The Relationship

```
All Balanced BSTs are Balanced Trees
But NOT all Balanced Trees are BSTs
```

## Key Differences

| Aspect | Balanced Tree | Balanced BST |
|--------|--------------|--------------|
| **Definition** | Any tree with height O(log n) | Balanced tree + BST ordering property |
| **Ordering** | No ordering requirement | Left < Node < Right |
| **Search capability** | Requires additional structure | O(log n) search by value |
| **Examples** | Balanced BST, Balanced n-ary tree, B-Tree | AVL, Red-Black, Splay Tree |

## Visual Examples

### 1. Balanced Tree that is NOT a BST
```
This tree is balanced (heights differ by ≤1), but violates BST property:

        10
       /  \
      15   5     ← 15 > 10 (should be in right), 5 < 10 (should be in left)
     / \  / \
    20 8 2 12   ← Multiple ordering violations

✅ Balanced? Yes (height diff ≤1 at every node)
❌ BST? No (ordering property violated)
```

### 2. Balanced BST
```
This is BOTH a balanced tree AND a BST:

        8
       / \
      3   10
     / \    \
    1   6    14

✅ Balanced? Yes (height diff ≤1)
✅ BST? Yes (left < node < right)
```

### 3. Unbalanced BST (for contrast)
```
This is a BST but NOT balanced:

    1
     \
      2
       \
        3
         \
          4

✅ BST? Yes
❌ Balanced? No (height = O(n))
```

## Other Balanced Trees (non-BST)

| Tree Type | Balanced? | BST? |
|-----------|-----------|------|
| **B-Tree** | ✅ Yes | ❌ No (can have >2 children, but maintains order differently) |
| **Balanced binary tree** (no ordering) | ✅ Yes | ❌ No |
| **Heap** (balanced by structure) | ✅ Yes | ❌ No (different ordering: parent ≥ children) |
| **AVL Tree** | ✅ Yes | ✅ Yes |
| **Red-Black Tree** | ✅ Yes | ✅ Yes |

## Practical Implication

When someone says **"balanced tree"** in conversation:
- **General context**: Any tree with O(log n) height
- **Algorithm/data structures context**: Often implies balanced BST (AVL/RB) by default
- **Database context**: Might mean B-Tree (balanced but not BST)

## Summary

> **Balanced BST** = Balanced Tree + BST ordering property
> 
> Think of it like: **All squares are rectangles, but not all rectangles are squares**
> - Balanced BSTs are a **subset** of balanced trees
> - Balanced trees include many structures without the binary search property
---
what is B+ tree
---
## B+ Tree

A **B+ Tree** is a self-balancing tree data structure that maintains sorted data and allows efficient insertion, deletion, and search operations. It's an extension of the B-Tree with key differences in where data is stored.

## Core Structure

```
                    [50, 100]                    ← Internal nodes (only keys, no data)
                   /    |    \
          [20,35]    [70,85]    [120,150]        ← Internal nodes
          /  |  \     /  |  \     /   |   \
        ... ... ... ... ... ... ...  ...  ...    ← Leaf nodes (keys + data)
         ↓   ↓   ↓   ↓   ↓   ↓   ↓    ↓    ↓
      [Actual data records]                    ← Data stored only here
```

## Key Characteristics

| Feature | Description |
|---------|-------------|
| **Data storage** | Only leaf nodes contain data pointers |
| **Internal nodes** | Store only keys (for routing/searching) |
| **Leaf nodes** | Linked together (forming a linked list) |
| **Height** | Always O(log n) |
| **Fanout** | High (many children per node) |

## B+ Tree vs B-Tree (Critical Differences)

| Aspect | B-Tree | B+ Tree |
|--------|--------|---------|
| **Data location** | Internal + leaf nodes | **Leaf nodes only** |
| **Internal nodes** | Store keys + data | Store **keys only** |
| **Leaf nodes** | May not be linked | **Linked sequentially** |
| **Range queries** | Slower (need backtracking) | **Fast** (follow leaf links) |
| **Space utilization** | Less efficient (data mixed with keys) | More efficient internal nodes |

## Visual Example (order m=3)

```
                    [50]                          ← Internal node (routing only)
                   /    \
              [30]        [70, 90]                ← Internal node (routing only)
             /    \       /   |   \
        [20,25,30] [40,50] [60,70] [80,90] [100]  ← Leaf nodes (keys + data)
           ↓         ↓        ↓        ↓       ↓
        Data     Data     Data     Data    Data
           
           ↕ Linked list connection ↔↔↔↔↔↔↔↔↔↔
```

## Operations

### 1. Search (O(log n))
```
Search for 85:
1. Start at root: 85 > 50 → go right
2. At [70,90]: 85 between 70 and 90 → go middle
3. At leaf node → scan for 85 → found
```

### 2. Insertion
- Find appropriate leaf node
- Insert key in sorted order
- If leaf overflows → split leaf (promote middle key to parent)

### 3. Deletion
- Remove from leaf node
- If leaf underflows → redistribute or merge with sibling
- May cascade up to internal nodes

## Why B+ Trees Are Widely Used

### 1. **Database Indexes** (Most Common Use)
```sql
-- Most database indexes use B+ Tree
CREATE INDEX idx_name ON users(email);
```

### 2. **File Systems**
- NTFS, ReFS, XFS, JFS
- Apple File System (APFS)

### 3. **Advantages**

| Advantage | Why It Matters |
|-----------|----------------|
| **Fast range queries** | Leaf node links enable O(log n + k) traversal |
| **High fanout** | Shorter tree → fewer disk I/O operations |
| **Sequential access** | Linked leaves make full table scans efficient |
| **Stable performance** | Always O(log n), no worst-case degradation |
| **Better cache usage** | Branching factor optimized for disk blocks |

## Performance Characteristics

| Operation | Time Complexity | I/O Operations (typical) |
|-----------|----------------|--------------------------|
| Search (point) | O(log n) | ~3-4 (for large DB) |
| Range query | O(log n + k) | ~3-4 + k/block_size |
| Insert | O(log n) | ~3-4 |
| Delete | O(log n) | ~3-4 |

*(k = number of results)*

## Node Structure Example

### Internal Node (order 4):
```
[10 | 20 | 40]     ← Keys only (3 keys for 4 children)
 |   |   |   |
[ptr][ptr][ptr][ptr] ← Child pointers
```

### Leaf Node (order 4):
```
[10 | 20 | 30 | 40]  ← Keys
[ptr][ptr][ptr][ptr]  ← Data pointers (or actual data)
[next_leaf]           ← Pointer to next leaf (linked list)
```

## Real-World Example

**MySQL InnoDB** default index structure:
```
Root node (in memory)
    ↓ (1 I/O)
Internal node (on disk)
    ↓ (1 I/O)
Internal node (on disk)  
    ↓ (1 I/O)
Leaf node (on disk) → contains actual row data or pointer
    ↓ (optional)
Next leaf node → for range scan
```

## When to Use B+ Trees

| Use Case | Suitability |
|----------|-------------|
| Database indexing | ⭐⭐⭐⭐⭐ (Perfect) |
| Filesystem metadata | ⭐⭐⭐⭐⭐ (Perfect) |
| Range queries | ⭐⭐⭐⭐⭐ (Excellent) |
| In-memory data | ⭐⭐ (Better options: AVL, RB Tree) |
| Point lookups only | ⭐⭐⭐ (Hash table is faster O(1)) |

## Summary

> **B+ Tree** = Self-balancing tree where:
> - **All data** resides in leaves
> - **Leaves are linked** as a sorted list  
> - **Internal nodes** only route searches
> - Optimized for **disk-based storage** with minimal I/O
> - Default index structure in most **relational databases**

The key innovation over B-Tree is separating **routing** (internal nodes) from **data storage** (leaf nodes), enabling efficient both point queries and range scans.
---
A B+-tree is a rooted tree satisfying the following properties
All paths from root to leaf are of the same length
Each node that is not a root or a leaf has between n/2 and n children.
A leaf node has between (n–1)/2 and n–1 values
Special cases: 
If the root is not a leaf, it has at least 2 children.
If the root is a leaf (that is, there are no other nodes in the tree), it can have between 0 and (n–1) values.
explain it
---
## Explanation of B+ Tree Properties

You've listed the **formal definition** of a B+ Tree of **order n**. Let me break down each property with examples.

---

## Property 1: All paths from root to leaf have the same length

**Meaning**: The tree is **perfectly height-balanced**. Every leaf node exists at the same depth.

```
✅ Valid (height = 2 for all leaves):

           [50]
          /    \
      [30]      [70,90]
      /  \      /   |  \
   [10,20] [40] [60] [80] [100,110]
      ↑      ↑    ↑    ↑      ↑
   All leaves at depth 2

❌ Invalid (different leaf depths):

           [50]
          /    \
      [30]      [70]
      /  \        \
   [10] [40]      [80,90]
                    /   \
                  [85]  [95]  ← Leaf at depth 3
```

**Why this matters**: Guarantees O(log n) search time regardless of data distribution.

---

## Property 2: Internal nodes (non-root, non-leaf) have between ⌈n/2⌉ and n children

**Meaning**: Each internal node must be at least half full (except possibly the root).

### Example with n = 4 (order 4):

| Calculation | Result |
|-------------|--------|
| ⌈n/2⌉ = ⌈4/2⌉ | **2** children (minimum) |
| n | **4** children (maximum) |

**Valid internal nodes** (children count: 2, 3, or 4):

```
✅ 2 children (minimum):
      [30,50]
      /     \
   [10,20]  [40,60]

✅ 3 children:
      [30,50,70]
      /    |    \
   [10]  [40]  [80,90]

✅ 4 children (maximum):
      [20,40,60]
      /   |   |   \
    [10] [30] [50] [70,80]
```

**Invalid** (1 child only - not allowed unless root):

```
❌ [20]
    |
   [10,30]  ← Only 1 child (violates minimum 2)
```

---

## Property 3: Leaf nodes have between ⌈(n–1)/2⌉ and (n–1) values

**Meaning**: Leaf nodes store **values** (or data pointers), not children. They also have a minimum fill requirement.

### Example with n = 4:

| Calculation | Result |
|-------------|--------|
| ⌈(n–1)/2⌉ = ⌈3/2⌉ | **2** values (minimum) |
| (n–1) | **3** values (maximum) |

**Valid leaf nodes**:

```
✅ 2 values (minimum):  [10,20]
✅ 3 values (maximum):  [10,20,30]
```


### Comparison table for different n values:

| Order (n) | Min leaf values ⌈(n–1)/2⌉ | Max leaf values (n–1) | Min internal children ⌈n/2⌉ | Max internal children |
|-----------|---------------------------|----------------------|----------------------------|----------------------|
| 3 | ⌈2/2⌉ = **1** | 2 | ⌈3/2⌉ = **2** | 3 |
| 4 | ⌈3/2⌉ = **2** | 3 | ⌈4/2⌉ = **2** | 4 |
| 5 | ⌈4/2⌉ = **2** | 4 | ⌈5/2⌉ = **3** | 5 |
| 6 | ⌈5/2⌉ = **3** | 5 | ⌈6/2⌉ = **3** | 6 |

---

## Special Cases

### Case 1: Root is not a leaf → at least 2 children

```
✅ Valid root with only 2 children (n=4):

           [50]           ← Root (only 2 children, while minimum for other internal nodes is 2 anyway)
          /    \
      [30]      [70,90]
      /  \      /   |  \
    [10] [40] [60] [80] [100]

✅ Valid root with 3 children (n=4):

           [30,60]        ← Root (3 children, perfectly fine)
          /   |   \
       [10] [40] [70,80]
```

### Case 2: Root is a leaf → can have 0 to (n–1) values

**Meaning**: An **empty tree** or a **tiny tree** with only a root node.

```
✅ Empty tree (n=4):
        []     ← Root leaf with 0 values

✅ Tree with 1 value:
        [10]   ← Root leaf with 1 value

✅ Tree with 3 values (maximum for n=4):
        [10,20,30]  ← Root leaf with 3 values

✅ Just before splitting (n=4):
        [10,20,30]  ← Root leaf is full (3 values)
                      Next insert will cause split into internal node
```

---

## Complete Example (Order n=4 B+ Tree)

```
                    Root (internal)
                    [50, 80]
                    /   |   \
                   /    |    \
        Internal  [30]  [60]  [90,100]
                 /  \   / \   /   |   \
              /    \  /   \ /    |    \
    Leaves: [10,20] [40] [55] [70] [85] [95,105]
              ↑      ↑    ↑    ↑    ↑      ↑
            (2v)   (1v) (1v) (1v) (1v)   (2v)
            min=2  min=2 min=2 min=2 min=2 min=2? Wait, this violates!
```

**Correction needed**: In the above, leaves with 1 value violate n=4 (min=2). This tree would be **invalid** for order 4.

### Valid order 4 B+ Tree example:

```
                         [60]                    ← Root (≥2 children)
                        /    \
                    [30]      [80,95]            ← Internal nodes (2-4 children)
                   /   \      /  |   \
                  /     \    /   |    \
    Leaves:  [10,20] [40,50] [70] [85,90] [100,110]
               ↑       ↑      ↑     ↑        ↑
             (2v)    (2v)   (1v)  (2v)     (2v)
```

**Wait**, leaf [70] has only 1 value! Still invalid for n=4 (min=2).

### Truly Valid Order 4 B+ Tree:

```
                         [60]
                        /    \
                    [30]      [80,100]
                   /   \      /   |   \
          [10,20] [40,50] [70,80] [90,95] [105,110]
             ↑       ↑       ↑       ↑        ↑
           (2v)    (2v)    (2v)    (2v)     (2v)
           
All leaves have 2-3 values, all internal nodes have 2-4 children ✓
```

---

## Summary Table

| Node Type | Condition | Formula (order n) | Example (n=4) |
|-----------|-----------|-------------------|---------------|
| **Root (not leaf)** | Min children | 2 (special case) | 2+ children |
| **Internal (non-root)** | Min children | ⌈n/2⌉ | 2 children |
| **Internal (any)** | Max children | n | 4 children |
| **Leaf (non-root)** | Min values | ⌈(n–1)/2⌉ | 2 values |
| **Leaf (any)** | Max values | n–1 | 3 values |
| **Root (leaf)** | Min values | 0 | Can be empty |

**The core idea**: These properties guarantee that the tree remains **at least half full** at all times (except the root), ensuring **O(log n)** height and efficient space utilization.
---
what are k and p
---
In the context of B+ Tree internal node notation, **K** and **P** represent:

## K = Separator Key (or just "Key")

**K** (typically K₁, K₂, ..., Kₙ₋₁) represents the **separator keys** stored in an internal node.

### Purpose:
- Act as **dividers** that split the key range
- Guide search to the correct child subtree
- **Not actual data values** (just routing information)

### Characteristics:
| Property | Description |
|----------|-------------|
| Stored in | Internal nodes only (not in leaves, in classic B+ tree) |
| Count | n-1 keys for n child pointers |
| Source | Typically copied/promoted from leaf nodes during splits |

---

## P = Pointer (Child Pointer)

**P** (typically P₁, P₂, ..., Pₙ) represents **pointers to child nodes**.

### Types of Pointers (depending on node level):

| Pointer Type | Points to |
|--------------|-----------|
| **Internal node pointer** | Another internal node (lower level) |
| **Leaf node pointer** | A leaf node containing actual data |

### Where Pₙ points (nth pointer):
- Points to a **leaf node** (if parent is one level above leaves)
- Points to another **internal node** (if higher up in tree)

---

## Visual Layout of an Internal Node

```
┌─────────────────────────────────────────────────────────────┐
│  Internal Node (n=5, so 5 pointers, 4 separator keys)       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Keys:    K₁     K₂     K₃     K₄                          │
│          │      │      │      │                             │
│          ▼      ▼      ▼      ▼                             │
│  Pointers: P₁    P₂    P₃    P₄    P₅                       │
│                                                             │
│  Actual layout:                                             │
│  ┌────┬────┬────┬────┬────┬────┬────┬────┬────┐            │
│  │ P₁ │ K₁ │ P₂ │ K₂ │ P₃ │ K₃ │ P₄ │ K₄ │ P₅ │            │
│  └────┴────┴────┴────┴────┴────┴────┴────┴────┘            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Note**: The actual physical arrangement often interleaves keys and pointers, as shown above.

---

## Example with Actual Values

```
Internal Node (n=4, so 4 pointers P₁-P₄, 3 keys K₁-K₃):

              [K₁=50, K₂=80, K₃=120]
              /      |       |      \
             /       |       |       \
           P₁       P₂      P₃       P₄
            ↓        ↓       ↓        ↓
      [keys <50] [50-80) [80-120) [≥120]
      
Actual node storage:
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│ P₁  │ 50  │ P₂  │ 80  │ P₃  │ 120 │ P₄  │
└─────┴─────┴─────┴─────┴─────┴─────┴─────┘
```

---

## Relationship Between K and P

| Relationship | Explanation |
|--------------|-------------|
| **Count** | #P = #K + 1 (always) |
| **Positioning** | Keys sit BETWEEN pointers in the ordering |
| **Search rule** | For key X, find smallest i where X < Kᵢ, then follow Pᵢ |

### Search Algorithm Using K and P:

```
function search(internal_node, X):
    for i from 1 to number_of_keys:
        if X < K_i:
            return P_i      // Follow this pointer
        // else continue
    return P_{n}            // X ≥ all keys, follow last pointer
```

---

## Storage Size Calculation

Given:
- **size(P)** = size of a pointer (e.g., 8 bytes)
- **size(K)** = size of a key (e.g., 8 bytes)

Node capacity for order n:
```
Total size = (n × size(P)) + ((n-1) × size(K)) + overhead
```

Example (4KB block, n=255):
```
4096 = (255 × 8) + (254 × 8) + overhead
4096 = 2040 + 2032 + 24
4096 = 4096 ✓
```

---

## Summary Table

| Symbol | Name | What it stores | How many |
|--------|------|----------------|----------|
| **Kᵢ** | Separator key | Value that divides key ranges | n-1 |
| **Pᵢ** | Pointer | Address of child node | n |

**Mnemonic**: 
- **K** = Key (separator/threshold)
- **P** = Pointer (to child)

The formula **Pₙ** vs **Kₙ₋₁** always holds: one more pointer than keys, because n pointers define n-1 boundaries between them.
---
Non leaf nodes form a multi-level sparse index on the leaf nodes.  For a non-leaf node with n pointers:
All the search-keys in the subtree to which P1 points are less than K1 
For 2  i  n – 1, all the search-keys in the subtree to which Pi points have values greater than or equal to Ki–1 and less than Ki 
All the search-keys in the subtree to which Pn points have values greater than or equal to Kn–1
explain it
---
This description is defining the **search key ordering invariant** for internal (non-leaf) nodes in a B+ Tree. This rule is what allows the tree to be searched efficiently.

Let me break this down piece by piece.

## The Structure of an Internal Node

An internal node with **n child pointers** (P₁ through Pₙ) stores **n-1 separator keys** (K₁ through Kₙ₋₁):

```
Internal Node:
┌─────┬─────┬─────┬─────┬─────┐
│ K₁  │ K₂  │ ... │ Kₙ₋₁│     │  ← n-1 separator keys
├─────┼─────┼─────┼─────┼─────┤
│ P₁  │ P₂  │ P₃  │ ... │ Pₙ  │  ← n child pointers
└─────┴─────┴─────┴─────┴─────┘
```

---

## The Three Rules Explained

### Rule 1: Everything under P₁ < K₁

```
        [K₁]
       /    \
     P₁      P₂
    /  \    /  \
  ...  ... ...  ...

All keys in P₁'s subtree: ALL < K₁
```

**Meaning**: The first pointer's entire subtree contains only values **less than** the first separator key.

---

### Rule 2: For 2 ≤ i ≤ n-1: Kᵢ₋₁ ≤ subtree under Pᵢ < Kᵢ

```
        [K₁, K₂, K₃, ..., Kₙ₋₁]
        /    |    |    ...    \
      P₁    P₂   P₃           Pₙ
           
For P₂: K₁ ≤ keys < K₂
For P₃: K₂ ≤ keys < K₃
For P₄: K₃ ≤ keys < K₄
...
For Pₙ₋₁: Kₙ₋₂ ≤ keys < Kₙ₋₁
```

**Note the "≥" on the left and "<" on the right** — this ensures **unique routing**.

---

### Rule 3: Everything under Pₙ ≥ Kₙ₋₁

```
        [K₁, K₂, ..., Kₙ₋₁]
        /              \
      P₁                Pₙ
                       /  \
                     ...  ...

All keys in Pₙ's subtree: ALL ≥ Kₙ₋₁
```

---

## Visual Example (order 4, n=4)

Internal node with n=4 pointers and 3 keys:

```
                    [30, 50, 70]           ← Separator keys
                    /    |    |    \
                   /     |    |     \
                  P₁    P₂   P₃     P₄
                 /      |    |       \
                ↓       ↓    ↓        ↓
         [keys <30] [30-50) [50-70) [≥70]
```

### Concrete values:

```
                    [30, 50, 70]
                    /    |    |    \
                   /     |    |     \
                  ↓      ↓    ↓      ↓
            [10,20]  [35,40] [55,60] [80,90,100]
```

Checking the rules:

| Pointer | Range | Verification |
|---------|-------|--------------|
| P₁ | All < 30 | 10,20 ✓ |
| P₂ | ≥30 and <50 | 35,40 ✓ (30 ≤ 35,40 < 50) |
| P₃ | ≥50 and <70 | 55,60 ✓ (50 ≤ 55,60 < 70) |
| P₄ | ≥70 | 80,90,100 ✓ |

---

## Why "Greater Than or Equal" on the Left?

Notice Rule 2 says **≥ Kᵢ₋₁** not **> Kᵢ₋₁**. This handles **duplicate keys**:

| Operator | Effect |
|----------|--------|
| **≥** on left bound | Duplicates go to the **right** subtree |
| **<** on right bound | Ensures deterministic routing |

If duplicate keys exist (e.g., two records with value 30):

```
        [30]
       /    \
     P₁      P₂
    
P₁: keys < 30    (30 NOT included)
P₂: keys ≥ 30    (30 IS included)

Duplicate 30s all go to P₂
```

---

## How Search Uses This Invariant

Searching for key **X**:

```
function search(node, X):
    if node is leaf:
        scan leaf for X
    else:
        i = 1
        while i ≤ n-1 and X ≥ Kᵢ:
            i++
        // Now X < Kᵢ, so follow Pᵢ
        return search(Pᵢ, X)
```

### Example: Search for 45 in node [30,50,70]

```
Step 1: 45 ≥ 30? Yes → i=2
Step 2: 45 ≥ 50? No → stop
Follow P₂ (the pointer between K₁=30 and K₂=50)

Result: 45 is in range [30,50) ✓
```

---

## Summary Table

| Pointer | Range Condition | Mnemonic |
|---------|-----------------|----------|
| **P₁** | < K₁ | "Less than first key" |
| **Pᵢ** (2 ≤ i ≤ n-1) | Kᵢ₋₁ ≤ keys < Kᵢ | "Between keys" |
| **Pₙ** | ≥ Kₙ₋₁ | "Greater than or equal to last key" |

---

## Key Insight

> This invariant creates a **partitioning** of the key space. The n-1 separator keys divide the entire key range into **n intervals**, each mapped to exactly one child pointer.

This is what makes B+ trees a **multi-level sparse index** — each internal node tells you exactly which child subtree might contain your search key, without needing to examine the actual data.
