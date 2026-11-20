-- Main comparisons

-- Compare ratings by city
SELECT
    city,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(CAST(google_rating AS REAL)), 2) AS average_google_rating
FROM restaurants
GROUP BY city
ORDER BY city;

-- Count francesinhas and calculate average price by city
SELECT
    r.city,
    COUNT(f.francesinha_id) AS francesinha_count,
    ROUND(AVG(CAST(f.price_eur AS REAL)), 2) AS average_price_eur
FROM restaurants AS r
JOIN francesinhas AS f USING (restaurant_id)
GROUP BY r.city
ORDER BY r.city;

-- Five cheapest francesinhas
SELECT
    f.francesinha_category,
    f.restaurant_name,
    r.city,
    f.francesinha_name,
    ROUND(CAST(f.price_eur AS REAL), 2) AS price_eur
FROM francesinhas AS f
JOIN restaurants AS r USING (restaurant_id)
ORDER BY CAST(price_eur AS REAL) ASC
LIMIT 5;

-- Five most expensive francesinhas
SELECT
    f.francesinha_category,
    f.restaurant_name,
    r.city,
    f.francesinha_name,
    ROUND(CAST(f.price_eur AS REAL), 2) AS price_eur
FROM francesinhas AS f
JOIN restaurants AS r USING (restaurant_id)
ORDER BY CAST(price_eur AS REAL) DESC
LIMIT 5;

-- Simple price-quality ranking using Original francesinhas only.
-- The final ranking in Google Sheets also uses the number of reviews.
SELECT
    f.restaurant_name,
    r.city,
    f.francesinha_name,
    ROUND(CAST(f.price_eur AS REAL), 2) AS price_eur,
    ROUND(CAST(r.google_rating AS REAL), 2) AS google_rating,
    r.google_review_count,
    ROUND(CAST(r.google_rating AS REAL) / CAST(f.price_eur AS REAL), 2) AS rating_per_euro
FROM francesinhas AS f
JOIN restaurants AS r USING (restaurant_id)
WHERE f.francesinha_category = 'Original'
  AND CAST(f.price_eur AS REAL) > 0
ORDER BY rating_per_euro DESC, r.google_review_count DESC
LIMIT 10;

-- Count the main categories by city
SELECT
    r.city,
    SUM(CASE WHEN f.francesinha_category = 'Original' THEN 1 ELSE 0 END) AS original_count,
    SUM(CASE WHEN f.francesinha_category = 'Vegetarian' THEN 1 ELSE 0 END) AS vegetarian_count,
    SUM(CASE WHEN f.francesinha_category = 'Vegan' THEN 1 ELSE 0 END) AS vegan_count
FROM restaurants AS r
JOIN francesinhas AS f USING (restaurant_id)
GROUP BY r.city
ORDER BY r.city;

-- Compare fresh and frozen fries
SELECT
    fries_type,
    COUNT(*) AS francesinha_count,
    ROUND(AVG(r.google_rating), 2) AS average_google_rating,
    ROUND(AVG(f.price_eur), 2) AS average_price_eur
FROM francesinhas AS f
JOIN restaurants AS r USING (restaurant_id)
GROUP BY fries_type
ORDER BY fries_type;

