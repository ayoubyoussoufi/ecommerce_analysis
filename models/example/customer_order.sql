SELECT *
FROM {{ ref('orders') }} 
WHERE order_status = 'delivered'