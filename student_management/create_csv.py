import pandas as pd

# Create the data
data = {
    "id": [1, 2, 3],
    "name": ["John Doe", "Jane Smith", "Bob Johnson"],
    "age": [25, 30, 22],
    "email": ["john@email.com", "jane@email.com", "bob@email.com"],
}

# Create DataFrame
df = pd.DataFrame(data)

# Display the DataFrame
print("DataFrame created:")
print(df)
print("\nDataFrame info:")
print(df.info())

# Save to CSV file
csv_filename = "students.csv"
df.to_csv(csv_filename, index=False)

print(f"\nCSV file '{csv_filename}' created successfully!")
print(f"File saved in: {csv_filename}")

# Verify the CSV file was created correctly
print("\nReading the CSV file back to verify:")
df_read = pd.read_csv(csv_filename)
print(df_read)
