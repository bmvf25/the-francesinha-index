# The Francesinha Index

Data analysis project comparing francesinha restaurants in Porto and Gaia, Portugal.

## Project scope

The dataset contains 31 restaurants and 54 francesinha records. It covers Google ratings and review counts, prices, categories, fries, opening hours, takeaway, delivery, and reservations.

## Repository structure

- `data/` — CSV exports and the final Google Sheets workbook
- `sql/` — data-quality checks and analysis queries written for SQLite
- `tableau/` — Tableau workbook and dashboard assets
- `images/` — chart exports and project previews

## Main findings

- Average Google rating: 4.5
- Average francesinha price: €13.21
- Gaia average rating: 4.51
- Porto average rating: 4.41
- Best Original price-quality result: Restaurante O Forno
- Sunday is the most common closing day
- Fresh-fries restaurants have a 0.14-point higher average Google rating than frozen-fries restaurants in this sample

## Methodology

The price-quality ranking uses only `Original` francesinhas. It combines the Google rating with the number of reviews through an adjusted-rating formula, then divides the adjusted rating by the francesinha price.

Ratings and review counts come from Google Maps. Prices and product characteristics come from the source URLs recorded in the dataset. Unknown service values remain unknown instead of being treated as false.

## Next steps

- Build the Tableau Public dashboard
- Add SQL result examples to the project documentation
- Publish the final project narrative on the personal website

