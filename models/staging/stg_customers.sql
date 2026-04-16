{{
  config(
    materialized='table'
  )
}}

WITH source AS (
    SELECT * FROM {{ source('e_commerce_1', 'customers') }}
),

renamed AS (
    SELECT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    FROM source
)

SELECT * FROM renamed