-- Basic checks for the exported CSV files

-- Count restaurants
SELECT COUNT(*) AS restaurant_count
FROM restaurants;

-- Count francesinhas
SELECT COUNT(*) AS francesinha_count
FROM francesinhas;

-- Look for duplicate restaurant IDs
SELECT restaurant_id, COUNT(*) AS rows_per_id
FROM restaurants
GROUP BY restaurant_id
HAVING COUNT(*) > 1;

-- Look for missing or invalid ratings
SELECT restaurant_id, restaurant_name, google_rating
FROM restaurants
WHERE google_rating IS NULL
   OR google_rating = ''
   OR CAST(google_rating AS REAL) < 0
   OR CAST(google_rating AS REAL) > 5;

-- Look for missing or invalid prices
SELECT francesinha_id, restaurant_name, francesinha_name, price_eur
FROM francesinhas
WHERE price_eur IS NULL
   OR price_eur = ''
   OR CAST(price_eur AS REAL) <= 0;

-- Count each category
SELECT francesinha_category, COUNT(*) AS francesinha_count
FROM francesinhas
GROUP BY francesinha_category
ORDER BY francesinha_count DESC;

-- Count confirmed and unknown services
SELECT
    SUM(CASE WHEN takeaway_available = 'TRUE' THEN 1 ELSE 0 END) AS takeaway_true,
    SUM(CASE WHEN takeaway_available = 'UNKNOWN' THEN 1 ELSE 0 END) AS takeaway_unknown,
    SUM(CASE WHEN delivery_available = 'TRUE' THEN 1 ELSE 0 END) AS delivery_true,
    SUM(CASE WHEN delivery_available = 'UNKNOWN' THEN 1 ELSE 0 END) AS delivery_unknown,
    SUM(CASE WHEN reservation_available = 'TRUE' THEN 1 ELSE 0 END) AS reservations_true,
    SUM(CASE WHEN reservation_available = 'UNKNOWN' THEN 1 ELSE 0 END) AS reservations_unknown
FROM restaurants;

