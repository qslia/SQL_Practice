records = df.to_dict('records')
explain it with an example
---

## `df.to_dict('records')` 详解

这个方法将Pandas DataFrame转换为**字典列表**，每一行数据变成一个字典，字典的键是列名，值是对应的数据。

---

## 示例演示

### 1. 原始DataFrame

假设你有以下股票数据：

```python
import pandas as pd

# 创建一个示例DataFrame
df = pd.DataFrame({
    'stock_code': ['000001', '000002', '000003'],
    'stock_name': ['平安银行', '万科A', '深科技'],
    'open_price': [12.50, 15.80, 22.30],
    'close_price': [12.80, 16.20, 22.90],
    'volume': [1000000, 2000000, 500000]
})

print(df)
```

输出：
```
  stock_code stock_name  open_price  close_price  volume
0    000001       平安银行        12.5         12.8 1000000
1    000002        万科A        15.8         16.2 2000000
2    000003        深科技        22.3         22.9  500000
```

---

### 2. 使用 `to_dict('records')`

```python
records = df.to_dict('records')
print(records)
```

输出：
```python
[
    {
        'stock_code': '000001',
        'stock_name': '平安银行',
        'open_price': 12.5,
        'close_price': 12.8,
        'volume': 1000000
    },
    {
        'stock_code': '000002',
        'stock_name': '万科A',
        'open_price': 15.8,
        'close_price': 16.2,
        'volume': 2000000
    },
    {
        'stock_code': '000003',
        'stock_name': '深科技',
        'open_price': 22.3,
        'close_price': 22.9,
        'volume': 500000
    }
]
```

---

## 为什么这样使用？

### 在SQLAlchemy中的应用

```python
# 转换后，每个字典可以直接用于创建ORM对象
for record in records:
    # record 是一个字典
    # 可以用 **record 解包作为关键字参数
    stock = StockPrice(**record)
    session.add(stock)
    
# 等同于：
for record in records:
    stock = StockPrice(
        stock_code=record['stock_code'],
        stock_name=record['stock_name'],
        open_price=record['open_price'],
        close_price=record['close_price'],
        volume=record['volume']
    )
    session.add(stock)
```

---

## 其他 to_dict() 格式对比

| 参数 | 输出格式 | 示例 |
|------|---------|------|
| `'dict'` (默认) | 列名→列表 | `{'stock_code': ['000001', '000002'], 'open_price': [12.5, 15.8]}` |
| **`'records'`** | **列表→字典** | **`[{'stock_code': '000001', 'open_price': 12.5}, ...]`** |
| `'list'` | 列名→列表的列表 | `{'stock_code': ['000001', '000002'], 'open_price': [[12.5], [15.8]]}` |
| `'series'` | 列名→Series | `{'stock_code': Series, 'open_price': Series}` |
| `'split'` | 分裂格式 | `{'index': [0,1], 'columns': [...], 'data': [...]}` |

---

## 实战案例：完整导入流程

```python
# 1. 读取CSV
df = pd.read_csv('20260616.csv')

# 假设原始数据是这样的：
#    代码    名称    开盘    收盘
# 0  000001  平安银行  12.50  12.80
# 1  000002  万科A    15.80  16.20

# 2. 重命名列
df = df.rename(columns={
    '代码': 'stock_code',
    '名称': 'stock_name',
    '开盘': 'open_price',
    '收盘': 'close_price'
})

# 3. 添加日期列
df['trade_date'] = '2026-06-16'

# 4. 转换为字典列表
records = df.to_dict('records')
# 结果：
# [
#     {'stock_code': '000001', 'stock_name': '平安银行', 'open_price': 12.50, 'close_price': 12.80, 'trade_date': '2026-06-16'},
#     {'stock_code': '000002', 'stock_name': '万科A', 'open_price': 15.80, 'close_price': 16.20, 'trade_date': '2026-06-16'}
# ]

# 5. 批量插入数据库
session = Session()
for record in records:
    # 方式1：使用**解包
    stock = StockPrice(**record)
    session.add(stock)
    
    # 方式2：手动映射
    # stock = StockPrice(
    #     stock_code=record['stock_code'],
    #     stock_name=record['stock_name'],
    #     open_price=record['open_price'],
    #     close_price=record['close_price'],
    #     trade_date=record['trade_date']
    # )
    # session.add(stock)

session.commit()
```

---

## 高级技巧：批量插入优化

```python
# 使用bulk_insert_mappings更高效（跳过ORM生命周期）
session.bulk_insert_mappings(StockPrice, records)
session.commit()
```

**性能对比**：
- `session.add()` + commit：1000条 ≈ 2秒
- `bulk_insert_mappings()`：1000条 ≈ 0.1秒

---

## 处理缺失值

```python
# 转换前处理NaN
df = df.fillna(0)  # 或 df.dropna()

# 或者转换时处理
records = df.to_dict('records')
for record in records:
    # 清理数据
    record = {k: (v if pd.notna(v) else 0) for k, v in record.items()}
```

---

## 总结

**`df.to_dict('records')`** 的作用：
- 把表格数据（DataFrame）变成**Python原生字典列表**
- 每个字典对应一行数据
- 方便后续用SQLAlchemy、JSON序列化等操作
- 是Pandas与数据库/API交互的**桥梁**

这是数据处理中最常用的转换方式之一！🎯