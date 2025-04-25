-- Assignment Day 3
-- 1_Update the categoryName From “Beverages” to "Drinks" in the categories table
UPDATE categories set category_name = 'Drinks' WHERE category_name = 'Beverages'

-- 2_Insert into shipper new record (give any values) Delete that new record from shippers table
INSERT INTO shippers (shipper_id, company_name) VALUES (4, 'USPS')
DELETE FROM shippers where shipper_id = 4

-- 3_Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade
 ALTER TABLE products
     DROP CONSTRAINT category_id_fk,
 	ADD CONSTRAINT category_id_fk FOREIGN KEY (category_id)
     REFERENCES categories (category_id) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE categories set category_id = 1001 where category_id = 1;

SELECT * from products where category_id = 1001;
SELECT * from categories where category_id = 1001;

-- 4_Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
ALTER TABLE orders
	DROP CONSTRAINT customer_id_fk,
    ADD CONSTRAINT customer_id_fk FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id) ON UPDATE CASCADE ON DELETE SET NULL;

DELETE FROM customers where customer_id = 'VINET';

SELECT * FROM orders WHERE customer_id IS NULL;


--5_Insert the following data to Products using UPSERT
INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', '1', 13, FALSE, 5),
(101, 'White bread', '5 boxes', 13, FALSE, 5)

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'White bread', '10 boxes', 13, FALSE, 5)
ON CONFLICT(product_id)
DO UPDATE SET
quantity_per_unit = EXCLUDED.quantity_per_unit;

SELECT * FROM products WHERE product_id = 100;


--6_Merge Query
CREATE TEMP TABLE updated_products(
product_id INTEGER,
product_name VARCHAR(100),
quantity_per_unit VARCHAR(100),
unit_price NUMERIC(10,2),
discontinued BOOLEAN,
category_id INTEGER);

INSERT INTO updated_products(product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
	VALUES (100, 'Wheat bread', '10', 20, TRUE, 5),
(101, 'White bread', '5 boxes', 19.99, FALSE, 5),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, FALSE, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, FALSE, 2);

MERGE INTO products USING updated_products ON products.product_id = updated_products.product_id
WHEN MATCHED AND updated_products.discontinued = FALSE THEN
 UPDATE SET unit_price = updated_products.unit_price, discontinued = updated_products.discontinued
WHEN MATCHED AND updated_products.discontinued = TRUE THEN DELETE
WHEN NOT MATCHED AND updated_products.discontinued = FALSE THEN
INSERT (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES(updated_products.product_id, updated_products.product_name, updated_products.quantity_per_unit,
updated_products.unit_price, updated_products.discontinued, updated_products.category_id);

select * from products where product_id IN (101, 102, 103, 100);

-- 7_List all orders with employee full names. (Inner join)
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, o.* from orders o INNER JOIN employees e
ON e.employee_id = o.employee_id;
