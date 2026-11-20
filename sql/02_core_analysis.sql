-- The Francesinha Index
-- Core comparisons and price-quality analysis

-- Porto versus Gaia
WITH restaurant_averages AS (
    SELECT
        city,
        COUNT(*) AS restaurant_count,
        ROUND(AVG(CAST(google_rating AS REAL)), 2) AS average_google_rating
    FROM restaurants
    GROUP BY city
), francesinha_averages AS (
    SELECT
        r.city,
        COUNT(f.francesinha_id) AS francesinha_count,
        ROUND(AVG(CAST(f.price_eur AS REAL)), 2) AS average_price_eur
    FROM restaurants AS r
    JOIN francesinhas AS f USING (restaurant_id)
    GROUP BY r.city
)
SELECT
    ra.city,
    ra.restaurant_count,
    fa.francesinha_count,
    ra.average_google_rating,
    fa.average_price_eur
FROM restaurant_averages AS ra
JOIN francesinha_averages AS fa USING (city)
ORDER BY ra.city;

-- Cheapest francesinhas
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

-- Most expensive francesinhas
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

-- Best price-quality: Original francesinhas only
-- The adjusted rating reduces the influence of very small review counts.
WITH scored AS (
    SELECT
        f.francesinha_id,
        f.restaurant_name,
        r.city,
        f.francesinha_name,
        f.price_eur,
        r.google_rating,
        r.google_review_count,
        AVG(r.google_rating) OVER () AS overall_average_rating
    FROM francesinhas AS f
    JOIN restaurants AS r USING (restaurant_id)
    WHERE f.francesinha_category = 'Original'
), adjusted AS (
    SELECT
        *,
        (google_review_count * 1.0 / (google_review_count + 500)) * google_rating
        + (500.0 / (google_review_count + 500)) * overall_average_rating
        AS adjusted_rating
    FROM scored
)
SELECT
    restaurant_name,
    city,
    francesinha_name,
    ROUND(price_eur, 2) AS price_eur,
    ROUND(google_rating, 2) AS google_rating,
    google_review_count,
    ROUND(adjusted_rating, 2) AS adjusted_rating,
    ROUND(adjusted_rating / price_eur, 2) AS adjusted_rating_per_euro
FROM adjusted
WHERE price_eur > 0
ORDER BY adjusted_rating_per_euro DESC, google_review_count DESC
LIMIT 10;

-- Category supply by city, excluding XXL from the three main categories
SELECT
    r.city,
    SUM(CASE WHEN f.francesinha_category = 'Original' THEN 1 ELSE 0 END) AS original_count,
    SUM(CASE WHEN f.francesinha_category = 'Vegetarian' THEN 1 ELSE 0 END) AS vegetarian_count,
    SUM(CASE WHEN f.francesinha_category = 'Vegan' THEN 1 ELSE 0 END) AS vegan_count
FROM restaurants AS r
JOIN francesinhas AS f USING (restaurant_id)
GROUP BY r.city
ORDER BY r.city;

-- Fresh versus frozen fries
SELECT
    fries_type,
    COUNT(*) AS francesinha_count,
    ROUND(AVG(r.google_rating), 2) AS average_google_rating,
    ROUND(AVG(f.price_eur), 2) AS average_price_eur
FROM francesinhas AS f
JOIN restaurants AS r USING (restaurant_id)
GROUP BY fries_type
ORDER BY fries_type;

