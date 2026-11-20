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

SELECT
    r.restaurant_name,
    ROUND(SUM(
        CASE
            WHEN oh.closed = 'TRUE' OR oh.opens_at = '' OR oh.closes_at = '' THEN 0.0
            WHEN oh.closes_at <= oh.opens_at THEN
                (julianday('2000-01-02 ' || oh.closes_at)
                 - julianday('2000-01-01 ' || oh.opens_at)) * 24.0
            ELSE
                (julianday('2000-01-01 ' || oh.closes_at)
                 - julianday('2000-01-01 ' || oh.opens_at)) * 24.0
        END
    ), 1) AS hours_per_week
FROM opening_hours AS oh
JOIN restaurants AS r USING (restaurant_id)
GROUP BY r.restaurant_name
ORDER BY hours_per_week DESC;

