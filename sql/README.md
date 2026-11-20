# SQL analysis

These are the SQL queries I used for the project. They are written for SQLite and use basic commands.

- `01_quality_checks.sql` checks if the data has the expected number of rows and if important values are missing.
- `02_core_analysis.sql` compares Porto and Gaia, prices, categories and fries.
- `03_opening_hours.sql` looks at closed days, common times and weekly opening hours.

The queries use the CSV files in the `data` folder.

The final Google Sheets ranking uses the adjusted rating. In SQL I kept the price-quality example simpler and used rating divided by price, because the main purpose of this folder is to show basic SQL.

