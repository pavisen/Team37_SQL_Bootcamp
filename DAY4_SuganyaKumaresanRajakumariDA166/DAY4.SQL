--1.     List all customers and the products they ordered with the order date. (Inner join)

SELECT * FROM customers
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM order_details

SELECT c.company_name AS customer,o.order_id,p.product_name,od.quantity,o.order_date FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id



--2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)

SELECT * FROM shippers
SELECT * FROM employees

SELECT o.order_id,c.customer_id,e.employee_id,s.shipper_id,p.product_id,p.product_name FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id



--3.     Show all order details and products (include all products even if they were never ordered). (Right Join)

SELECT o.order_id,p.product_id,p.product_name,o.quantity
FROM order_details o
RIGHT JOIN products p ON o.product_id = p.product_id
ORDER BY product_id



--4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)

SELECT * FROM categories	
SELECT c.category_id,c.category_name,p.product_id,p.product_name 
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id


--5. 	Show all possible product and category combinations (Cross join).

SELECT p.product_id,p.product_name,c.category_id,c.category_name
FROM products p
CROSS JOIN categories c


-- 6. 	Show all employees and their manager(Self join(left join))

SELECT * FROM employees
SELECT e.employee_id,
e.first_name||' '||e.last_name AS employee_name,
m.first_name||' '||m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.reports_to = m.employee_id
ORDER BY e.employee_id



-- 7. 	List all customers who have not selected a shipping method.

SELECT * FROM customers
SELECT * FROM orders

SELECT c.customer_id,c.company_name,o.ship_via
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL
