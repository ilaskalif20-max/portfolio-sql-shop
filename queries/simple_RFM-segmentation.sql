WITH totals AS (
  SELECT
    o.customer_id,
    MAX(date(o.order_date)) AS last_order,
    COUNT(DISTINCT o.order_id) AS freq,
    SUM(oi.qty * oi.unit_price * (1 - oi.discount)) AS monetary
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped','delivered')
  GROUP BY o.customer_id
)
SELECT cu.full_name,
       last_order,
       freq,
       ROUND(monetary,2) AS monetary,
       CASE
         WHEN date('2025-08-25') <= date(last_order, '+14 day') THEN 'Recent'
         WHEN date('2025-08-25') <= date(last_order, '+45 day') THEN 'Warm'
         ELSE 'Churn risk'
       END AS recency_band
FROM totals t
JOIN customers cu ON cu.customer_id = t.customer_id
ORDER BY monetary DESC;
