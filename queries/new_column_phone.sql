alter table customers add column phone text;
UPDATE customers SET phone = '+7 (999) 123-45-67' WHERE customer_id = 1;
UPDATE customers SET phone = '8 911 234-56-78'     WHERE customer_id = 2;
UPDATE customers SET phone = '+358 44 123 4567'    WHERE customer_id = 3; -- не-RU