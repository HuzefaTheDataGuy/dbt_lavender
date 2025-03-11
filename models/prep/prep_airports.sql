WITH airports_reorder AS (
    SELECT faa,
           name,
           country,
           region,
           city,
           lat,
           alt,
           tz,
           dst
    FROM {{ref('staging_airports')}}
)
SELECT * FROM airports_reorder