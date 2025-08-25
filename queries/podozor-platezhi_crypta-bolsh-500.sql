SELECT p.payment_id, p.order_id, p.amount, p.method, p.status, p.paid_at
FROM payments p
WHERE p.method='crypto' AND p.amount > 500;