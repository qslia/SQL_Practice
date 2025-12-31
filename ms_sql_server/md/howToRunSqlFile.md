To run a `.sql` file in terminal, you have several options depending on the database system:

## **For SQL Server (Windows/Linux/macOS)**

### **1. Using sqlcmd (Command Line Tool)**
```bash
# Connect and run file
sqlcmd -S server_name -U username -P password -d database_name -i file.sql

# Example with Windows Authentication
sqlcmd -S localhost -E -d TestData -i C:\path\to\file.sql

# Include output in terminal
sqlcmd -S localhost -E -d TestData -i file.sql -o output.txt
```

### **2. Using Invoke-Sqlcmd (PowerShell)**
```powershell
# Run SQL file
Invoke-Sqlcmd -ServerInstance "localhost" -Database "TestData" -InputFile "C:\path\to\file.sql"

# With authentication
Invoke-Sqlcmd -ServerInstance "localhost" -Username "sa" -Password "password" -InputFile "file.sql"
```

## **For MySQL/MariaDB**

```bash
# Basic syntax
mysql -u username -p database_name < file.sql

# Example
mysql -u root -p TestData < schema.sql
# or
mysql -u root -p TestData -e "source schema.sql"
```

## **For PostgreSQL**

```bash
# Using psql
psql -U username -d database_name -f file.sql

# Example
psql -U postgres -d TestData -f schema.sql
```

## **For SQLite**

```bash
sqlite3 database.db < file.sql
# or
sqlite3 database.db ".read file.sql"
```

## **Common Flags/Options:**
- `-S` or `--server`: Server name/instance (SQL Server)
- `-U` or `--user`: Username
- `-P` or `--password`: Password
- `-d` or `--database`: Database name
- `-i` or `--input-file`: Input SQL file
- `-o` or `--output-file`: Output results to file
- `-E` or `--trusted-connection`: Use Windows Authentication
- `-h` or `--host`: Host/server address
- `-f` or `--file`: File to execute

## **Example Workflow:**
```bash
# 1. Navigate to directory containing your SQL file
cd C:\Projects\SQLScripts

# 2. Run the SQL file against your database
sqlcmd -S localhost\SQLEXPRESS -E -d TestData -i CreateTables.sql

# 3. Check for errors (will display in terminal)
```

## **Tips:**
1. **Check if tools are installed:**
   ```bash
   sqlcmd -?       # Check SQL Server tools
   mysql --version # Check MySQL
   psql --version  # Check PostgreSQL
   ```

2. **Run without entering password interactively:**
   ```bash
   # Set password as environment variable
   export PGPASSWORD="password"  # PostgreSQL
   # or use configuration files
   ```

3. **Execute multiple files:**
   ```bash
   # Create a batch file or use command chaining
   sqlcmd -S localhost -E -d TestData -i file1.sql
   sqlcmd -S localhost -E -d TestData -i file2.sql
   ```

4. **For SQL Server on Linux/macOS:**
   ```bash
   # Use mssql-tools package
   /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'password' -i file.sql
   ```

Choose the command based on your database system and adjust the connection parameters as needed for your environment.