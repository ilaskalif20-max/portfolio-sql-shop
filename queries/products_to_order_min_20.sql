SELECT p.name as 'Товары к закупке', w.name AS warehouse, i.qty_on_hand as 'Имеющееся товары на складе'
FROM inventory i
JOIN products p ON p.product_id = i.product_id
JOIN warehouses w ON w.warehouse_id = i.warehouse_id
WHERE i.qty_on_hand < 20
ORDER BY i.qty_on_hand ASC;