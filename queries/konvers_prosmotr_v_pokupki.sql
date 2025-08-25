WITH views AS (
  SELECT product_id, COUNT(*) AS v
  FROM product_views
  GROUP BY product_id
), buyers AS (
  SELECT oi.product_id, COUNT(DISTINCT o.customer_id) AS b
  FROM order_items oi
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.status IN ('paid','shipped','delivered')
  GROUP BY oi.product_id
)
SELECT p.name,
       COALESCE(v.v,0) AS views,
       COALESCE(b.b,0) AS unique_buyers,
       ROUND(CASE WHEN v.v > 0 THEN (1.0*b.b)/v.v ELSE 0 END, 3) AS conv_ratio
FROM products p
LEFT JOIN views v ON v.product_id = p.product_id
LEFT JOIN buyers b ON b.product_id = p.product_id
ORDER BY conv_ratio DESC;
