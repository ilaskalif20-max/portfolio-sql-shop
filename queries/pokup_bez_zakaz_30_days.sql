SELECT cu.customer_id, cu.full_name, substr(cu.email,1,1)||'***'||(substr(cu.email,instr(cu.email,'@'))) as email
FROM customers cu
LEFT JOIN (
  SELECT customer_id, MAX(date(order_date)) AS last_dt
  FROM orders
  WHERE status IN ('paid','shipped','delivered')
  GROUP BY customer_id
) lo ON lo.customer_id = cu.customer_id
WHERE lo.last_dt IS NULL OR lo.last_dt < date('2025-08-25','-30 day')
ORDER BY lo.last_dt;
