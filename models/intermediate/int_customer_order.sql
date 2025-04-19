-- Business logic transformations
SELECT
    c.customer_id,
    c.customer_unique_id,
    INITCAP(c.customer_city) AS customer_city,
    UPPER(c.customer_state) AS customer_state,
    COUNT(o.order_id) AS order_count,
    MIN(o.order_purchase_timestamp) AS first_order_date,
    MAX(o.order_purchase_timestamp) AS most_recent_order_date,
    SUM(
        CASE 
            WHEN o.order_status = 'delivered' THEN 1 
            ELSE 0 
        END
    ) AS delivered_order_count,
    AVG(
        EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))
    ) AS avg_delivery_days
FROM {{ ref('stg_customers') }} c
LEFT JOIN {{ ref('stg_customer_orders') }} o ON c.customer_id = o.customer_id
GROUP BY 1, 2, 3, 4
