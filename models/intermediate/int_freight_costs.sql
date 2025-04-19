select c.customer_id, sum(oi.freight_value) as freight_per_customer
from {{ref('stg_orders')}} o
JOIN {{ref('stg_order_items')}}  oi ON o.order_id = oi.order_id 
JOIN  {{ref('stg_customers')}} c ON c.customer_id = o.customer_id
GROUP BY c.customer_id
