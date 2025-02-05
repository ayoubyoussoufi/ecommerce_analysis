{{ config(materialized='view') }}  

SELECT *
FROM {{ ref('customers') }}
where customer_id is NULL   
