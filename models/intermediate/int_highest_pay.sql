with high_pay_per_type as (
select o.customer_id, 
DATE(o.order_delivered_carrier_date) as date_delivery,
payment_type,
payment_value,
dense_rank() over(partition by payment_type order by payment_value desc) as rank_orders
from {{ref('payments')}}  p
JOIN  {{ref('orders')}}  o ON p.order_id = o.order_id 
where payment_value is not null and order_delivered_carrier_date is not null
)

select customer_id, date_delivery, payment_type, payment_value 
from high_pay_per_type where rank_orders = 1