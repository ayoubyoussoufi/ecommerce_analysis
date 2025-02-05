select c.customer_id, sum(oi.freight_value) as freight_per_customer
from {{ref('orders')}} o
JOIN {{ref('order_items')}}  oi ON o.order_id = oi.order_id 
JOIN  {{ref('customers')}} c ON c.customer_id = o.customer_id
GROUP BY c.customer_id
