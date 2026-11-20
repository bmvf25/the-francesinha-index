# SQL analysis

These queries are written for SQLite using beginner-friendly SQL.

- `01_quality_checks.sql` checks row counts, duplicates, missing values, categories, and unknown service values.
- `02_core_analysis.sql` contains the main comparisons, including Porto versus Gaia and a simple Original-only rating-per-euro ranking.
- `03_opening_hours.sql` analyses closed days, common opening and closing times, and weekly opening hours.

The SQL uses the CSV exports stored in `data/`.

The adjusted-rating formula is kept in Google Sheets because the project is intentionally using basic SQL. The SQL ranking demonstrates the simpler `rating / price` calculation, while the final ranking in the spreadsheet also accounts for the number of Google reviews.

