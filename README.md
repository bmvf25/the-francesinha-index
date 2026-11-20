# The Francesinha Index

This is a small data analysis project about francesinha restaurants in Porto and Gaia.

I collected information about 31 restaurants and 54 francesinhas. The data includes Google ratings, review counts, prices, categories, fries, opening hours and services such as takeaway, delivery and reservations.

## Folder structure

- `data/` contains the exported CSV files and the final spreadsheet.
- `sql/` contains the SQL queries used in the project.
- `tableau/` will contain the Tableau workbook and related files.
- `images/` will contain screenshots and exported charts.

## Some results

- The average Google rating was 4.5.
- The average price was €13.21.
- Gaia had an average rating of 4.51.
- Porto had an average rating of 4.41.
- Restaurante O Forno had the best Original rating-to-price result.
- Sunday was the day with the most closed restaurants.
- Restaurants with fresh fries had a 0.14-point higher average rating in this sample.

## How I did the analysis

I used Google Maps for ratings and review counts. Prices and product information came from the source links saved in the spreadsheet.

For the main price-quality ranking, I only used Original francesinhas. I also created an adjusted rating because a rating based on 50 reviews should not have exactly the same weight as a rating based on thousands of reviews.

The final adjusted-rating calculation is explained in the Google Sheets file. The SQL folder contains simpler queries because this was also a project to practise basic SQL.

Unknown service information was left as unknown instead of being treated as false.

## Next steps

- Finish the Tableau dashboard.
- Add screenshots and examples of the SQL results.
- Publish the project story on my personal website.

