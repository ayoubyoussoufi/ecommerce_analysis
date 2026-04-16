# FCT_ORDER_ITEMS_ENRICHED

## Overview

This model represents an enriched fact table at the **order item grain**.  
It combines order item transactions with customer and product context, and adds derived business metrics for analytics, logistics evaluation, and profitability approximation.

It is built on top of the **core layer models**:
- `order_items`
- `customers`
- `products`

---

## Grain

**One row = one order item**

Each record represents a single product purchased within an order.
