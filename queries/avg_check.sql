SELECT ROUND(AVG(order_sum),2) AS avg_order_value
FROM (
  SELECT o.order_id, SUM(oi.qty * oi.unit_price * (1 - oi.discount)) AS order_sum
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped','delivered')
  GROUP BY o.order_id
);
