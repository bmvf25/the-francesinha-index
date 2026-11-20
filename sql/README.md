# SQL analysis

These queries are written for SQLite.

- `01_quality_checks.sql` checks row counts, duplicates, missing values, categories, and unknown service values.
- `02_core_analysis.sql` contains the main comparisons, including Porto versus Gaia and the Original-only price-quality ranking.
- `03_opening_hours.sql` analyses closed days, common opening and closing times, and weekly opening hours.

The SQL uses the CSV exports stored in `data/`.

