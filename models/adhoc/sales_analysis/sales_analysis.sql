{{ config(
    materialized='table'
) }}

WITH dim_products AS (

  SELECT
    p.product_id,
    p.category_raw,
    p.category_en,

    p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,

    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    (p.product_length_cm * p.product_height_cm * p.product_width_cm) AS product_volume_cm3,
    (p.product_weight_g / 1000.0) AS product_weight_kg

  FROM {{ ref('products') }} p
)

SELECT

  -- =====================
  -- ORDER ITEM FACT
  -- =====================
  i.order_id,
  i.order_item_id,
  i.product_id,

  i.price,
  i.freight_value,
  (i.price + i.freight_value) AS item_total_value,

  -- =====================
  -- ORDER CONTEXT
  -- =====================
  i.customer_id,
  i.order_purchase_date,

  c.customer_city,
  c.customer_state,

  -- =====================
  -- PRODUCT CONTEXT
  -- =====================
  p.category_en AS product_category,
  p.product_weight_kg,
  p.product_volume_cm3,

  -- =====================
  -- LOGISTICS METRICS
  -- =====================
  SAFE_DIVIDE(i.freight_value, i.price) AS freight_to_price_ratio,
  SAFE_DIVIDE(i.freight_value, p.product_weight_kg) AS freight_per_kg,

  -- =====================
  -- PROFITABILITY PROXY
  -- =====================
  (i.price - i.freight_value) AS profit_proxy_simple

FROM {{ ref('order_items') }} i

LEFT JOIN {{ ref('customers') }} c
  ON i.customer_id = c.customer_id

LEFT JOIN dim_products p
  ON i.product_id = p.product_id