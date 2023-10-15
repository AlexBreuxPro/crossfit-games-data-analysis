import pandas as pd
import duckdb
import os

# Read the CSV into a DataFrame, using the environment variable
df = pd.read_csv(os.environ['DUCKDB_DATA_PATH'])

# Connect to DuckDB using the environment variable
con = duckdb.connect(os.environ['DUCKDB_DATABASE_PATH'])

# Load the data from the DataFrame into DuckDB
con.register('dataset_temp', df)

# If the dataset table already exists, drop it
con.execute("DROP TABLE IF EXISTS dataset")

# Create a persistent table from the temporary view
con.execute("CREATE TABLE df_games_and_open_with_2023 AS SELECT * FROM dataset_temp")

# Close the connection
con.close()