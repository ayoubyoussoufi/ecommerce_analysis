{{ config(materialized='table') }}

WITH date_spine AS (

  SELECT day AS date_day
  FROM UNNEST(GENERATE_DATE_ARRAY(DATE '2016-01-01', DATE '2018-12-31')) AS day

)

SELECT

  date_day,

  -- basic breakdown
  EXTRACT(YEAR FROM date_day) AS year,
  EXTRACT(MONTH FROM date_day) AS month,
  EXTRACT(DAY FROM date_day) AS day,

  EXTRACT(QUARTER FROM date_day) AS quarter,
  EXTRACT(WEEK FROM date_day) AS week_number,
  EXTRACT(DAYOFWEEK FROM date_day) AS day_of_week,  -- BigQuery: 1=Sunday

  -- readable labels
  FORMAT_DATE('%A', date_day) AS weekday_name,
  FORMAT_DATE('%B', date_day) AS month_name,

  -- flags
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (1, 7) THEN TRUE
    ELSE FALSE
  END AS is_weekend,

  CASE 
    WHEN EXTRACT(DAY FROM date_day) = 1 THEN TRUE
    ELSE FALSE
  END AS is_month_start,

  LAST_DAY(date_day) = date_day AS is_month_end

FROM date_spine