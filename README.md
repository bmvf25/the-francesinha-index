# The Francesinha Index

**Live project page:** [finambre.github.io/the-francesinha-index](https://finambre.github.io/the-francesinha-index/)

## About the project

This project started with a simple question: **where can I find a good francesinha in Porto or Gaia without looking only at the restaurant's Google rating?**

The francesinha is a typical dish from the Porto metropolitan area, but restaurants can be very different in price, opening hours, menu options and services. I wanted to collect this information in one place and use it to make a fairer comparison.

The final dataset contains:

- 31 restaurants;
- 54 francesinha records;
- restaurants from Porto and Gaia;
- Google ratings and review counts;
- prices and francesinha categories;
- fresh or frozen fries;
- opening hours;
- takeaway, delivery and reservation information.

This is a learning project. The goal was not to decide which restaurant is objectively the best, but to practise the full process of a small data project: collecting data, organising it, checking it, analysing it and presenting the results.

## Questions I wanted to answer

The main questions were:

1. Is there a difference between Porto and Gaia?
2. Which francesinhas are the cheapest and most expensive?
3. Which francesinhas offer the best rating for the price?
4. Are restaurants with fresh fries rated differently from restaurants with frozen fries?
5. Which restaurants offer vegetarian or vegan francesinhas?
6. Which restaurants have takeaway, delivery or reservations?
7. On which days are restaurants most often closed?
8. Which restaurants are open for the most hours each week?

## How the data was collected

I used Google Maps for the restaurant rating and the number of reviews. This was a deliberate choice so that all restaurants used the same rating source.

Prices, menu details, fries, bread, egg and other product information were collected from the source links saved in the spreadsheet. Opening hours and services were recorded with their own source links and collection dates whenever possible.

I tried not to guess missing information. When I could not confirm a service, such as delivery or reservations, I kept the value as `UNKNOWN` instead of assuming that the service did not exist.

## Spreadsheet structure

The original data was organised in Google Sheets before being exported to this repository.

### Restaurants

Contains one row per restaurant. It includes the restaurant name, city, address, coordinates, Google rating, number of reviews and available services.

### Opening Hours

Contains the opening intervals for each restaurant. A restaurant can have more than one row on the same day, for example one interval for lunch and another for dinner.

### Francesinhas

Contains one row per francesinha. It includes the price, category, bread type, sauce, fries, egg and the source of the information.

The main categories are:

- `Original`;
- `Vegetarian`;
- `Vegan`.

### Extras

Contains optional items such as extra fries, egg, meat, sauce and other additions. Extras were kept separate from the price of the francesinha and were not used in the final price comparison.

### Data Dictionary

Explains the meaning and format of the columns used in the project.

## Data checks

Before doing the analysis, I checked whether:

- there were 31 restaurants and 54 francesinhas;
- restaurant IDs were unique;
- prices were present and positive;
- Google ratings were between 0 and 5;
- the category values were consistent;
- `TRUE`, `FALSE` and `UNKNOWN` were being used correctly.

The checks did not find duplicate restaurant IDs or invalid ratings and prices in the exported data.

## Adjusted Google rating

A simple Google rating can be misleading when restaurants have very different numbers of reviews. For example, a rating of 4.8 based on 50 reviews is less stable than a rating of 4.6 based on several thousand reviews.

To take this into account, I used this adjusted-rating formula in Google Sheets:

```text
Adjusted rating =
(reviews / (reviews + 500)) × rating
+ (500 / (reviews + 500)) × overall average
```

The number 500 is a stabilising value chosen for this project. With very few reviews, the adjusted rating moves closer to the overall average. As the number of reviews increases, the restaurant's own rating becomes more important.

This calculation is only used to create a more cautious ranking. It does not replace the original Google rating and does not prove that one restaurant is objectively better than another.

## Price-quality ranking

The main price-quality ranking only includes `Original` francesinhas.

Vegetarian and vegan francesinhas were left out of this ranking because they may have different ingredients, prices and preparation methods. Including them in the same ranking could make the comparison less fair.

The basic calculation is:

```text
Adjusted rating ÷ francesinha price
```

The best Original result in the dataset was **Restaurante O Forno**, in Gaia.

The SQL folder contains a simpler version of this calculation using:

```text
Google rating ÷ price
```

The adjusted version is kept in Google Sheets because this project is also meant to show beginner-level SQL.

## Main results

### General results

- Average Google rating: **4.5**;
- average francesinha price: **€13.21**;
- 31 restaurants;
- 54 francesinha records.

### Porto and Gaia

| City | Restaurants | Francesinhas | Average rating | Average price |
|---|---:|---:|---:|---:|
| Porto | 16 | 27 | 4.41 | €13.41 |
| Gaia | 15 | 27 | 4.51 | €13.01 |

In this sample, Gaia had a slightly higher average rating and a slightly lower average price than Porto.

### Cheapest and most expensive

The cheapest francesinha was the vegetarian option at Requinte Francesinhas, at €7.50.

The most expensive francesinha was the Original option at Café Restaurante O Afonso, at €17.00.

### Categories

The three analytical category counts are:

- 34 Original francesinhas;
- 15 Vegetarian francesinhas;
- 4 Vegan francesinhas.

One additional record uses a size label rather than one of these analytical categories, so these three counts add up to 53 while the full dataset contains 54 records.

### Fresh and frozen fries

| Fries | Francesinhas | Average rating | Average price |
|---|---:|---:|---:|
| Fresh | 39 | 4.48 | €13.35 |
| Frozen | 15 | 4.34 | €12.85 |

Restaurants associated with fresh fries had a 0.14-point higher average Google rating in this sample.

This is only an observed association. It does not prove that frozen fries cause lower ratings, because the rating can also depend on the sauce, meat, bread, service, atmosphere and many other factors.

### Services

The dataset contains:

- 28 restaurants with confirmed takeaway;
- 22 restaurants with confirmed delivery;
- 26 restaurants with confirmed reservations.

### Opening days and hours

Sunday was the day with the most closed restaurants: 17 out of 31. Monday was second, with 11 closed restaurants.

The most common opening time was 12:00, and the most common interval closing time was 15:00. The 15:00 value often represents the end of lunch service, not necessarily the complete closing of the restaurant.

The restaurants with the most recorded opening hours per week were Requinte Francesinhas, Bugatti Caffe and Café Trevo.

## SQL

The SQL files are intentionally simple and use commands such as:

- `SELECT`;
- `WHERE`;
- `JOIN`;
- `GROUP BY`;
- `ORDER BY`;
- `COUNT`;
- `AVG`;
- `SUM`;
- `LIMIT`.

The queries are written for SQLite and use the CSV files in the `data` folder.

## Tableau and website

The Tableau Public dashboard is published with the main comparisons and filters for city, price and Google rating. The map uses restaurant coordinates, keeps restaurant names in the detail, sizes marks by Google rating and uses price as the colour scale.

The final website page will combine:

- the story of the project;
- the methodology;
- the main findings;
- screenshots and charts;
- the interactive Tableau dashboard;
- the limitations of the analysis.

## Limitations

This project has some limitations:

- Google ratings belong to restaurants, not directly to individual francesinhas;
- prices, ratings and opening hours can change;
- the dataset only contains 31 restaurants;
- the fries comparison is observational;
- Original, Vegetarian and Vegan francesinhas are not exactly the same type of product;
- an unknown service does not necessarily mean that the service is unavailable.

## Conclusion

This project started as a simple list of francesinha restaurants and became a small end-to-end data project.

The final result includes a cleaned dataset, basic SQL queries, Google Sheets analysis and a published interactive Tableau dashboard.

The main conclusion is not that one restaurant is the universal winner. Instead, the project makes it easier to compare restaurants according to different needs: price, rating, location, category, opening hours and available services.

