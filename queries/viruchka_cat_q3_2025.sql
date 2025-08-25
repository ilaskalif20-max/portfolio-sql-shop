WITH item_totals AS (
  SELECT
    o.order_date,
    p.category_id,
    (oi.qty * oi.unit_price * (1 - oi.discount)) AS revenue
  FROM order_items oi
  JOIN orders o ON o.order_id = oi.order_id
  JOIN products p ON p.product_id = oi.product_id
  WHERE o.status IN ('paid','shipped','delivered')
    AND date(o.order_date) BETWEEN '2025-07-01' AND '2025-09-30'
)
SELECT c.name AS category, round(SUM(revenue),2) AS revenue
FROM item_totals it
JOIN categories c ON c.category_id = it.category_id
GROUP BY c.name
ORDER BY revenue DESC;
