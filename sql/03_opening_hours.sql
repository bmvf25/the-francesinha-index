-- The Francesinha Index
-- Opening-hours analysis

-- Restaurants closed by day
SELECT
    day_of_week,
    COUNT(DISTINCT restaurant_id) AS restaurants_closed
FROM opening_hours
WHERE closed = 'TRUE'
GROUP BY day_of_week
ORDER BY restaurants_closed DESC;

-- Most common opening times
SELECT opens_at, COUNT(*) AS interval_count
FROM opening_hours
WHERE closed = 'FALSE'
  AND opens_at <> ''
GROUP BY opens_at
ORDER BY interval_count DESC, opens_at;

-- Most common closing times
SELECT closes_at, COUNT(*) AS interval_count
FROM opening_hours
WHERE closed = 'FALSE'
  AND closes_at <> ''
GROUP BY closes_at
ORDER BY interval_count DESC, closes_at;

-- Weekly opening hours by restaurant.
-- If a closing time is earlier than or equal to the opening time,
-- the interval is treated as continuing past midnight.
WITH intervals AS (
    SELECT
        restaurant_id,
        CASE
            WHEN closed = 'TRUE' OR opens_at = '' OR closes_at = '' THEN 0.0
            WHEN closes_at <= opens_at THEN
                (julianday('2000-01-02 ' || closes_at)
                 - julianday('2000-01-01 ' || opens_at)) * 24.0
            ELSE
                (julianday('2000-01-01 ' || closes_at)
                 - julianday('2000-01-01 ' || opens_at)) * 24.0
        END AS hours_open
    FROM opening_hours
), totals AS (
    SELECT restaurant_id, ROUND(SUM(hours_open), 1) AS hours_per_week
    FROM intervals
    GROUP BY restaurant_id
)
SELECT
    r.restaurant_name,
    t.hours_per_week
FROM totals AS t
JOIN restaurants AS r USING (restaurant_id)
ORDER BY t.hours_per_week DESC;

