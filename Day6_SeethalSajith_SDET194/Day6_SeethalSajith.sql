select * from products;
SELECT 
    product_name,
    units_in_stock,
    CASE
        WHEN units_in_stock = 0 THEN 'Out of Stock'
        WHEN units_in_stock < 20 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products;

SELECT 
    product_name,
    unit_price
FROM products
WHERE category_id = (
    SELECT category_id
    FROM categories
    WHERE category_name = 'Beverages'
);

select * from orders;
SELECT 
    order_id,
    order_date,
    freight,
    employee_id
FROM orders
WHERE employee_id = (

    SELECT employee_id
    FROM orders
    GROUP BY employee_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

SELECT order_id, order_date, freight, ship_country
FROM orders
WHERE ship_country != 'USA'
  AND freight > ANY (
      SELECT freight
      FROM orders
      WHERE ship_country = 'USA'
  );

  SELECT order_id, order_date, freight, ship_country
FROM orders
WHERE ship_country != 'USA'
  AND freight > ALL (
      SELECT freight
      FROM orders
      WHERE ship_country = 'USA'
  );

