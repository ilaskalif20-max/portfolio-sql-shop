WITH item_totals AS (
  SELECT
    oi.product_id,
    SUM(oi.qty * oi.unit_price * (1 - oi.discount)) AS revenue
  FROM order_items oi
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.status IN ('paid','shipped','delivered')
  GROUP BY oi.product_id
)
SELECT p.name, ROUND(it.revenue,2) AS revenue
FROM item_totals it
JOIN products p ON p.product_id = it.product_id
ORDER BY it.revenue DESC
LIMIT 3;
