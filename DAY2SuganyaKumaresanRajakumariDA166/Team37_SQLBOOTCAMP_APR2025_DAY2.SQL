SELECT * FROM employees

ALTER TABLE employees
ADD linkedin_profile varchar;	

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE text;	

ALTER TABLE employees
ADD UNIQUE (linkedin_profile);

UPDATE employees
SET linkedin_profile = 'linkedin.com/'||employee_name
WHERE linkedin_profile IS NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL	

SELECT employee_name,title FROM employees

SELECT DISTINCT unit_price FROM products

SELECT customer_id,company_name FROM customers
	GROUP BY customer_id,company_name
	ORDER BY company_name ASC

SELECT product_name,unit_price AS price_in_usd
	FROM products

SELECT customer_id,country FROM customers
	WHERE country ='Germany'

SELECT customer_id,country FROM customers
	WHERE country ='France' OR country ='Spain'

SELECT Product_id,product_name,unit_price FROM products
	WHERE unit_price>15

SELECT employee_id,employee_name,title,country FROM employees
	WHERE title ='Sales Representative' AND country = 'USA'


SELECT product_id,product_name,unit_price,discontinued 		
FROM products
	WHERE unit_price>30 AND discontinued=0

SELECT order_id,customer_id,order_date FROM orders
	GROUP BY order_id
	ORDER BY order_date ASC LIMIT 10

SELECT order_id,customer_id,order_date FROM orders
	GROUP BY order_id
	ORDER BY order_date ASC LIMIT 10

SELECT * FROM orders
	ORDER BY order_id ASC
	LIMIT 10
	OFFSET 10;

SELECT * FROM customers
	WHERE contact_title = 'Sales Representative' OR 	contact_title 	='Owner';	

SELECT * FROM orders
	WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31';

SELECT * FROM products
	WHERE category_id NOT IN (1,2,3);

SELECT * FROM customers
	WHERE company_name LIKE'A%'
	
UPDATE products
SET unit_price = unit_price*1.10
WHERE category_id = 2;

SELECT * FROM products
WHERE category_id = 2;

INSERT INTO orders 	(order_id,customer_id,employee_id,order_date,required_date,shipped_date,shipper_id,freight)
VALUES(‘11078','ALFKI','5','2025-04-23','2025-04-30','2025-04-25','2','45.50')






