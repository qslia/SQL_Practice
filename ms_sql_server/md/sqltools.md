This error is **100% expected with SQL Server Express**, and it tells us **exactly what’s missing** 👍

> **“Port for SQLEXPRESS01 not found in localhost”**

### What it really means

* SQLTools is trying to connect via **TCP/IP**
* Your SQL Server Express instance is **running**
* ❌ **TCP/IP is disabled** (default for Express)
* ❌ No fixed port is configured

`sqlcmd` works because it uses **Shared Memory** locally
SQLTools **cannot** use Shared Memory → it needs **TCP**

---

## ✅ The fix (only 5 minutes, do this once)

You must **enable TCP/IP and set a port**.

---

## Step 1️⃣ Open SQL Server Configuration Manager

Press **Win** and search:

```
SQL Server Configuration Manager
```

(If you don’t see it, tell me — I’ll give you the direct .msc path)

---

## Step 2️⃣ Enable TCP/IP

Go to:

```
SQL Server Network Configuration
  └─ Protocols for SQLEXPRESS01
```

1. Right-click **TCP/IP**
2. Click **Enable**

---

## Step 3️⃣ Set a fixed port (CRITICAL)

1. Double-click **TCP/IP**
2. Go to **IP Addresses** tab
3. Scroll to the bottom → **IPAll**

Set **exactly this**:

| Field             | Value       |
| ----------------- | ----------- |
| TCP Dynamic Ports | **(empty)** |
| TCP Port          | **1433**    |

Click **OK**

---

## Step 4️⃣ Restart SQL Server

Go to:

```
SQL Server Services
```

Right-click:

```
SQL Server (SQLEXPRESS01)
```

→ **Restart**

⚠️ This step is mandatory

---

## Step 5️⃣ Fix your SQLTools connection string

Use **this exact string**:

```text
Server=localhost,1433;Database=master;Trusted_Connection=True;Encrypt=True;TrustServerCertificate=True;
```

⚠️ Notice:

* `,1433` → **comma**, not colon
* ❌ NO `instanceName`
* ❌ NO `SQLEXPRESS01` in server name anymore

---

## ✅ Test it

Click **TEST CONNECTION**

This time it **will connect**.

---

## Why this happens (so you remember)

| Tool             | Connection method   |
| ---------------- | ------------------- |
| `sqlcmd` (local) | Shared Memory ✅     |
| SSMS (local)     | Shared Memory / TCP |
| SQLTools         | **TCP only** ❗      |

SQL Server Express ships with:

* TCP ❌ disabled
* No port ❌
* SQL Browser ❌ often missing

So SQLTools **cannot discover a port** → exactly your error.

---

## Quick sanity check (optional)

After restart, run:

```powershell
netstat -ano | findstr 1433
```

You should see SQL Server listening on 1433.

---

## TL;DR

✔ SQL Server is installed
✔ Service is running
❌ TCP/IP disabled
❌ No port

➡ Enable TCP/IP + set port 1433
➡ Use `localhost,1433`
➡ SQLTools works

---

If you want next:

* 🔹 FastAPI / pyodbc connection string
* 🔹 Docker → SQL Server Express
* 🔹 Secure setup without `TrustServerCertificate`
* 🔹 Developer Edition upgrade

Just tell me.



<br>


### 🟢 Solution 2 — Create a SQL Login (fastest fix for SQLTools)

Since SQLTools **expects SQL auth**, give it one.

#### Step 1 — Create SQL login (using sqlcmd)

```powershell
sqlcmd -S localhost,1433
```

```sql
CREATE LOGIN sqltools WITH PASSWORD = 'StrongP@ssw0rd!';
ALTER SERVER ROLE sysadmin ADD MEMBER sqltools;
GO
```






<br>

## Step 2️⃣ Enable Mixed Authentication Mode (if needed)

### Option A — via SQL Server Management Studio (easiest)

1. Open **SSMS**
2. Connect using **Windows Authentication**
3. Right-click server → **Properties**
4. **Security**
5. Select:

   ```
   SQL Server and Windows Authentication mode
   ```
6. OK
7. **Restart SQL Server service**

---



## Step 4️⃣ Test SQL login again

Now test:

```powershell
sqlcmd -S localhost,1433 -U sqltools -P StrongP@ssw0rd!
```

### ✅ Expected result

```
1>
```

Test identity:

```sql
SELECT SUSER_NAME(), SYSTEM_USER;
GO
```

Expected:

```
sqltools | sqltools
```

---

## Step 5️⃣ Configure SQLTools (this WILL work now)

In SQLTools:

* Connect using: **Server and Port**
* Server: `localhost`
* Port: `1433`
* Username: `sqltools`
* Password: `StrongP@ssw0rd!`
* Encrypt: ✔
* TrustServerCertificate: ✔

❌ No empty user
❌ No Windows auth
❌ No NTLM hacks

---

