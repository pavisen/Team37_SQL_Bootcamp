--1. Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query: UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

SELECT * FROM products WHERE units_in_stock<10
CREATE VIEW vw_updatable_products AS
SELECT 
product_id,
product_name,
unit_price,
units_in_stock,
discontinued
FROM products
WHERE discontinued=0
WITH CHECK OPTION;

UPDATE vw_updatable_products
SET unit_price = unit_price *1.1
WHERE units_in_stock<10


--2. Transaction:Update the product price for products by 10% in category id=1

BEGIN;
UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id =1;


DO $$
BEGIN
IF EXISTS(
SELECT 1
FROM products
WHERE category_id = 1 AND unit_price>50
) THEN 
RAISE EXCEPTION 'some prices exceed $50';
ELSE
RAISE NOTICE 'price update successful';
END IF;
END $$;

COMMIT;
ROLLBACK;

SELECT * FROM products WHERE category_id =1 AND unit_price>50




--4.     Create a recursive CTE based on Employee Hierarchy

SELECT * FROM employees

WITH RECURSIVE cte_employeehierarchy AS (
SELECT
	employee_id,
	first_name,
	last_name,
	reports_to,
	0 AS LEVEL
FROM
	employees e
WHERE
	reports_to IS NULL

UNION ALL
SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	e.reports_to,
	eh.level+1
FROM
	employees e
JOIN 	
	cte_employeehierarchy eh
ON 
	eh.employee_id = e.reports_to
)
SELECT level,employee_id,first_name||' '||last_name AS full_name
FROM
cte_employeehierarchy
ORDER BY level,employee_id;





--3.     Create a regular view which will have below details (Need to do joins):
--Employee_id,Employee_full_name,Title,Territory_id,territory_description,region_description


SELECT * FROM employees
SELECT * FROM employee_territories
SELECT * FROM territories

CREATE VIEW vw_employee_details AS
SELECT
	e.employee_id,e.first_name||' '||e.last_name AS full_name,e.title,
	t.territory_id, t.territory_description,r.region_description
	FROM employees e
	JOIN employee_territories et
	ON e.employee_id = et.employee_id
	JOIN territories t
	ON et.territory_id = t.territory_id
	JOIN region r
	ON t.region_id = r.region_id
	GROUP BY e.employee_id,t.territory_id, t.territory_description,r.region_description

SELECT * FROM vw_employee_details

