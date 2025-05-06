--1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.

UPDATE categories
SET category_name = REPLACE(category_name,’Beverages','Drinks)



--2)      Insert into shipper new record (give any values) Delete that new record from shippers table.

INSERT INTO shippers(shipper_id,company_name,phone)
VALUES('7','Full Express','840-951-0002')
DELETE FROM shippers
WHERE shipper_id = 7;



-- 3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
--  Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.

ALTER TABLE products
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id) ON UPDATE CASCADE;
ALTER TABLE products
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE;
 UPDATE categories
SET category_id = 1001 WHERE category_id=1;



--4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null

ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;
DELETE FROM customers 
WHERE customer_id='VINET'



-- 5)      Insert the following data to Products using UPSERT:
-- product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
-- product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
-- product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5

INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES(100,'Wheat bread','1',13,0,5),
(101,'White bread','5 boxes',13,0,5)

INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES(100,'Wheat Bread','10 boxes',13,0,5)
ON CONFLICT(product_id)
DO UPDATE SET
quantity_per_unit = EXCLUDED.quantity_per_unit




--6)      Write a MERGE query:
-- Create temp table with name:  ‘updated_products’ and insert values 
-- Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
-- If there are matching products and updated_products .discontinued =1 then delete 
 -- Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

CREATE TEMP TABLE updated_products
 (productid integer,
   productname character varying(50) ,
    quantityperunit character varying(100) ,
    unitprice numeric(10,2),
    discontinued integer,
    categoryid integer);

INSERT INTO updated_products(productid,productname,quantityperunit,unitprice,discontinued,categoryid) VALUES 
(100,'Wheat bread','10',20,1,3),
(101,'White bread','5 boxes',19.99,0,3),
(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2)

SELECT * FROM products

MERGE INTO products p 
USING updated_products u ON p.product_id = u.productid
WHEN MATCHED AND u.discontinued = 1 THEN DELETE
WHEN MATCHED AND u.discontinued = 0 THEN 
UPDATE 
SET unit_price = u.unitprice,
discontinued = u.discontinued
WHEN NOT MATCHED AND u.discontinued = 0 THEN
INSERT(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES(u.productid,u.productname,u.quantityperunit,u.unitprice,u.discontinued,u.categoryid)



-- 7)      List all orders with employee full names. (Inner join)

SELECT * FROM orders
SELECT * FROM employees

SELECT e.first_name,e.last_name,o.order_id
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
ORDER BY order_id
