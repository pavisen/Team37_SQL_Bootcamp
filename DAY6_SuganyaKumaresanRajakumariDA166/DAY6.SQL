SELECT * FROM products

SELECT product_id,product_name,
CASE
WHEN units_in_stock=0 THEN 'Out Of Stock'
WHEN units_in_stock<20 THEN 'Low Stock'
ELSE
'High Stock'
END AS stock_status
FROM products

SELECT * FROM categories

SELECT product_name,unit_price FROM products
WHERE category_id =(
SELECT category_id
FROM categories
WHERE category_name = 'Drinks')

SELECT * FROM EMPLOYEES
SELECT * FROM ORDERS

SELECT order_id,order_date,freight,employee_id
FROM orders
WHERE
employee_id=(
SELECT employee_id FROM orders
GROUP BY employee_id
ORDER BY COUNT(*) DESC 
LIMIT 1
)

SELECT order_id,freight,ship_country
FROM orders
WHERE 
ship_country != 'USA'
AND freight > ANY (
SELECT freight
FROM orders
WHERE ship_country = 'USA')


