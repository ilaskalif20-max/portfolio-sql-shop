SELECT o.order_id,
       s.carrier,
       s.shipped_at,
       s.delivered_at,
       CASE
         WHEN s.shipped_at IS NOT NULL AND s.delivered_at IS NOT NULL
         THEN ROUND((julianday(s.delivered_at) - julianday(s.shipped_at))*24,1)
         ELSE NULL
       END AS hours_in_transit
FROM shipments s
JOIN orders o ON o.order_id = s.order_id
ORDER BY hours_in_transit DESC;