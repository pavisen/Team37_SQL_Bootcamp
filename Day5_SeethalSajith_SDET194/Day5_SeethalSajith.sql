select * from orders
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(order_id) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM orders
WHERE freight > 100
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY 
    order_year,
    order_quarter;

SELECT 
    ship_region,
    COUNT(order_id) AS number_of_orders,
    MIN(freight) AS min_freight_cost,
    MAX(freight) AS max_freight_cost
FROM orders
GROUP BY ship_region
HAVING COUNT(order_id) >= 5
ORDER BY ship_region;

SELECT title AS designation
FROM employees

UNION

SELECT contact_title AS designation
FROM customers;


SELECT title AS designation
FROM employees

UNION ALL

SELECT contact_title AS designation
FROM customers;


SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT


SELECT category_id
FROM products
WHERE units_in_stock > 0;


SELECT order_id
FROM orders

EXCEPT


SELECT DISTINCT order_id
FROM order_details
WHERE discount > 0;

