INSERT INTO categories(category_id, name, parent_id) VALUES
(1,'Электроника',NULL),
(2,'Смартфоны',1),
(3,'Ноутбуки',1),
(4,'Аксессуары',1);

INSERT INTO products(product_id, category_id, name, price, is_active, created_at) VALUES
(101,2,'SmartPhone X',699.00,1,'2025-06-01'),
(102,2,'SmartPhone Lite',399.00,1,'2025-06-15'),
(103,3,'Ultrabook 14"',1199.00,1,'2025-05-20'),
(104,4,'Наушники Pro',129.00,1,'2025-07-01'),
(105,4,'Зарядка 30W',29.00,1,'2025-07-10');

INSERT INTO customers(customer_id, full_name, email, created_at) VALUES
(1,'Иван Петров','ivan@example.com','2025-07-01'),
(2,'Анна Смирнова','anna@example.com','2025-07-05'),
(3,'Сергей Ким','sergey@example.com','2025-07-20');

INSERT INTO addresses(address_id, customer_id, line1, city, country, is_default) VALUES
(1,1,'Ленина 10-5','Москва','RU',1),
(2,2,'Невский 3-12','Санкт-Петербург','RU',1),
(3,3,'Эспланаади 1','Хельсинки','FI',1);

INSERT INTO warehouses(warehouse_id, name, city) VALUES
(1,'Главный склад','Москва'),
(2,'Северный склад','СПб');

INSERT INTO inventory(product_id, warehouse_id, qty_on_hand) VALUES
(101,1,50), (101,2,30),
(102,1,80), (102,2,40),
(103,1,20), (103,2,10),
(104,1,100), (104,2,60),
(105,1,200), (105,2,120);

INSERT INTO orders(order_id, customer_id, order_date, status, shipping_address_id) VALUES
(1001,1,'2025-07-21 10:00','paid',1),
(1002,2,'2025-07-22 12:00','delivered',2),
(1003,1,'2025-07-25 09:30','cancelled',1),
(1004,3,'2025-08-01 14:00','shipped',3),
(1005,2,'2025-08-15 16:00','paid',2);

INSERT INTO order_items(order_id, product_id, qty, unit_price, discount) VALUES
(1001,101,1,699.00,0.05),
(1001,105,2,29.00,0),
(1002,103,1,1199.00,0.10),
(1002,104,1,129.00,0),
(1003,102,1,399.00,0),
(1004,102,1,399.00,0.05),
(1004,104,2,129.00,0.10),
(1005,101,1,699.00,0),
(1005,104,1,129.00,0);

INSERT INTO payments(payment_id, order_id, amount, method, status, paid_at) VALUES
(1,1001, (699.00*(1-0.05)) + (2*29.00), 'card','captured','2025-07-21 10:05'),
(2,1002, (1199.00*(1-0.10)) + 129.00, 'bank','captured','2025-07-22 12:10'),
(3,1003, 0, 'card','failed',NULL),
(4,1004, (399.00*(1-0.05)) + (2*129.00*(1-0.10)), 'card','authorized','2025-08-01 14:05'),
(5,1005, 699.00 + 129.00, 'crypto','captured','2025-08-15 16:05');

INSERT INTO product_views(view_id, customer_id, product_id, viewed_at) VALUES
(1,1,101,'2025-07-20 09:00'),
(2,1,105,'2025-07-20 09:05'),
(3,2,103,'2025-07-21 11:00'),
(4,2,104,'2025-07-21 11:05'),
(5,3,102,'2025-07-31 18:00'),
(6,3,104,'2025-07-31 18:05'),
(7,2,101,'2025-08-15 15:00');

INSERT INTO reviews(review_id, customer_id, product_id, rating, comment, created_at) VALUES
(1,2,103,5,'Отличный ультрабук','2025-07-25'),
(2,1,101,4,'Хороший телефон, но дороговат','2025-07-23'),
(3,3,104,3,'Звук норм, заряд держит средне','2025-08-02');

INSERT INTO shipments(shipment_id, order_id, carrier, tracking_no, shipped_at, delivered_at) VALUES
(1,1002,'DHL','TRK1002','2025-07-22 15:00','2025-07-24 13:00'),
(2,1004,'DPD','TRK1004','2025-08-02 10:00',NULL);