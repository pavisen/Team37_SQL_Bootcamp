/*1.Create view vw_updatable_products*/


CREATE view vw_updatable_products as
select
product_id,
product_name,
unit_price,
units_in_stock,
discontinued
from products
where discontinued = 0

--update--
UPDATE vw_updatable_products 
SET unit_price = unit_price * 1.1 
WHERE units_in_stock < 10;

--verify--

SELECT * from  vw_updatable_products
WHERE units_in_stock < 10;


/*2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/
 

begin;
--update product price--

update products
set unit_price = unit_price * 1.1
where category_id = 1

select product_id,unit_price from products where category_id = 1

commit;

rollback;



/*3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description */

CREATE VIEW vw_employee_territories as
select
e.Employee_id,
(e.first_name||e.last_name) as Employee_full_name,
e.Title,
t.Territory_id,
t.territory_description,
r.region_description
from employees e
JOIN employee_territories et
ON e.employee_id = et.employee_id
JOIN territories t
ON et.territory_id = t.territory_id
JOIN region r
ON t.region_id = r.region_id


/*4.     Create a recursive CTE based on Employee Hierarchy*/

WITH RECURSIVE
	EMPLOYEE_HIERARCHY AS (
		-- Anchor:Top-level employee(s) with no manager--
		SELECT
			EMPLOYEE_ID,
			FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
			TITLE,
			REPORTS_TO,
			1 AS LEVEL
		FROM
			EMPLOYEES
		WHERE
			REPORTS_TO IS NULL
		UNION ALL
		-- Recursive: employees who report to others--
		SELECT
			E.EMPLOYEE_ID,
			E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME,
			E.TITLE,
			E.REPORTS_TO,
			EH.LEVEL + 1 AS LEVEL
		FROM
			EMPLOYEES E
			INNER JOIN EMPLOYEE_HIERARCHY EH ON E.REPORTS_TO = EH.EMPLOYEE_ID
	)
SELECT
	*
FROM
	EMPLOYEE_HIERARCHY
ORDER BY
	LEVEL,
	REPORTS_TO,
	EMPLOYEE_ID;