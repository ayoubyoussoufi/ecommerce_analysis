{{ config(materialized='table') }}

SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    o.customer_id,
    DATE(o.order_purchase_timestamp) AS order_purchase_date,
    oi.price,
    oi.freight_value
FROM {{ ref('stg_order_items') }} oi
LEFT JOIN {{ ref('stg_orders') }} o
    ON oi.order_id = o.order_id
where order_status NOT IN ('canceled','unavailable')