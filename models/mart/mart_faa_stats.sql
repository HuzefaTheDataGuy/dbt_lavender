-- HINT: use group by 

SELECT * FROM prep_flights
SELECT * FROM prep_airports

WITH flight_route_stats AS (
    SELECT origin,
           dest,
           count(flight_number),
           count(DISTINCT tail_number) AS nunique_tail,
           count(DISTINCT airline) AS nunique_airline,
           AVG(actual_elapsed_time_interval) AS avg_actual_elapsed_time,
           AVG(arr_delay_interval) AS avg_arr_interval,
           AVG(dep_delay_interval) AS avg_dep_interval,
           MAX(arr_delay_interval) AS max_arr_interval,
           MIN(arr_delay_interval) AS min_arr_interval,
           sum(cancelled) AS total_canceled,
           sum(diverted) AS total_diverted
    FROM {{ref('prep_flights')}}
    GROUP BY (origin, dest)
)
SELECT o.city AS origin_city,
       d.city AS dest_ctiy,
       o.name AS origin_name,
       d.name AS dest_name,
       o.country AS origin_country,
       d.country AS dest_country,
       *
from flight_route_stats f
LEFT JOIN {{ref('prep_airports')}} o
    ON f.origin = o.faa
LEFT JOIN {{ref('prep_airports')}} d
    ON f.dest = d.faa
