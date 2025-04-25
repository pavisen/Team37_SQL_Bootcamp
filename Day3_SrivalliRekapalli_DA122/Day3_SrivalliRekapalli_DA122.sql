                               Day 3


--1)Update the categoryName From “Beverages” to "Drinks" in the categories
UPDATE categories
SET category_name = 'Drinks'
WHERE category_name = 'Beverages';

select * from categories;
 
--2)Insert into shipper new record (give any values) Delete that new record from shippers table.
SELECT * FROM shippers;	
-- Insert a new shipper
INSERT INTO shippers (Shipper_id, company_name, phone)
VALUES (999, 'Test Shipper Co.', '123-456-7890');

-- Delete the new shipper
DELETE FROM shippers
WHERE shipper_id = 999;
 
/*3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too.
  Display the both category and products table to show the cascade.
  Delete the categoryID= “3”  from categories.
 Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID)
 to add ON UPDATE CASCADE, ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) ) */

-- Drop the old foreign key
ALTER TABLE products
DROP CONSTRAINT fk_products_categories;

-- Add a new foreign key with cascade rules
ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id) REFERENCES categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- Update CategoryID from 1 to 1001
UPDATE categories
SET category_id = 1001
WHERE category_id = 1;

-- Display updated categories and products tables
SELECT * FROM categories;
SELECT * FROM products
WHERE category_id = 1001;

--Delete CategoryID = 3 and Show Cascade Effect
--First, make sure order_details has ON DELETE CASCADE on ProductID:

-- Drop the old foreign key in order_details (if exists)
ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

-- Add new FK with ON DELETE CASCADE
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id) REFERENCES products(product_id)
ON DELETE CASCADE;

--Delete CategoryID 3 and verify cascading deletes

DELETE FROM categories
WHERE category_id = 3;

-- Check if related products are deleted
SELECT * FROM products
WHERE category_id = 3;

-- Check if order_details are also removed for deleted products
SELECT * FROM order_details
WHERE product_id NOT IN (SELECT product_id FROM products);
 
--4)Delete the customer = “VINET”  from customers.
/*Corresponding customers in orders table should be set to null
(HINT: Alter the foreign key on orders(customerID)
to use ON DELETE SET NULL)*/

--Drop and recreate the foreign key with ON DELETE SET NULL:
SELECT conname
FROM pg_constraint
WHERE conrelid = 'orders'::regclass
  AND contype = 'f';

-- Drop the old foreign key
ALTER TABLE orders
DROP CONSTRAINT fk_orders_customers;

-- Add new foreign key with ON DELETE SET NULL
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON DELETE SET NULL;

-- Delete the customer VINET:
DELETE FROM customers
WHERE customer_id = 'VINET';

-- Verify the orders table:

SELECT * FROM orders
WHERE customer_id IS NULL;

/*5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)*/

select * from products; 
 
INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES 
    (100, 'Wheat bread', '1', 13, 0, 5)
ON CONFLICT (product_id)
DO UPDATE SET 
    quantity_per_unit = EXCLUDED.quantity_per_unit;

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES 
    (101, 'White bread', '5 boxes', 13, 0, 5)
ON CONFLICT (product_id)
DO UPDATE SET 
    quantity_per_unit = EXCLUDED.quantity_per_unit;

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES 
     (100, 'Wheat bread', '10 boxes', 13, 0, 5)  -- This will trigger an update
ON CONFLICT (product_id)
DO UPDATE SET 
    quantity_per_unit = EXCLUDED.quantity_per_unit;

select * from products where product_id = 100;

/*6) Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
 
productID
productName
quantityPerUnit
unitPrice
discontinued
categoryID
                     	100
Wheat bread
10
20
1
5
101
White bread
5 boxes
19.99
0
5
102
Midnight Mango Fizz
24 - 12 oz bottles
19
0
1
103
Savory Fire Sauce
12 - 550 ml bottles
10
0
2
 
Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 

If there are matching products and updated_products .discontinued =1 then delete 
 
Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.*/

--Create the temp table updated_products and insert values
CREATE TEMP TABLE updated_products (
    productid INT PRIMARY KEY,
    productname TEXT,
    quantityperunit TEXT,
    unitprice NUMERIC(10,2),
    discontinued INT,
    categoryid INT
);

INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES 
    (100, 'Wheat bread', '10', 20, 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);


-- UPDATE existing products if discontinued = 0
UPDATE products p
SET 
    unit_price = up.unitprice,
    discontinued = up.discontinued
FROM updated_products up
WHERE p.product_id = up.productid
  AND up.discontinued = 0;

select * from products

Step 3: DELETE matching products if discontinued = 1
sql
Copy
Edit
DELETE FROM products p
USING updated_products up
WHERE p.productid = up.productid
  AND up.discontinued = 1;
Step 4: INSERT new products if they don’t exist and discontinued = 0
sql
Copy
Edit
INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
SELECT up.productid, up.productname, up.quantityperunit, up.unitprice, up.discontinued, up.categoryid
FROM updated_products up
LEFT JOIN products p ON up.productid = p.productid
WHERE p.productid IS NULL
  AND up.discontinued = 0;


--USE NEW Northwind DB:
 
--7) List all orders with employee full names. (Inner join)

SELECT 
    o.order_id,
    o.order_date,
    o.customer_id,
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employeefullname
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;
