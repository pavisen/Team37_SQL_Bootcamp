UPDATE categories
SET category_name = REPLACE(category_name,’Beverages','Drinks)


INSERT INTO shippers(shipper_id,company_name,phone)
VALUES('7','Full Express','840-951-0002')
DELETE FROM shippers
WHERE shipper_id = 7;


ALTER TABLE products
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id) ON UPDATE CASCADE;
ALTER TABLE products
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE;
 UPDATE categories
SET category_id = 1001 WHERE category_id=1;



ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;
DELETE FROM customers 
WHERE customer_id='VINET'



INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES(100,'Wheat bread','1',13,0,5),
(101,'White bread','5 boxes',13,0,5)

INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES(100,'Wheat Bread','10 boxes',13,0,5)
ON CONFLICT(product_id)
DO UPDATE SET
quantity_per_unit = EXCLUDED.quantity_per_unit



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

SELECT * FROM orders
SELECT * FROM employees

SELECT e.first_name,e.last_name,o.order_id
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
ORDER BY order_id
