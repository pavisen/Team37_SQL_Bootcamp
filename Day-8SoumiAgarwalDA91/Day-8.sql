--4.     Create a recursive CTE based on Employee Hierarchy
WITH RECURSIVE EMP_HIER AS
(
	SELECT employee_id,first_name,last_name,title,reports_to,0 AS LEVEL
	FROM public.employees
    WHERE reports_to IS NULL
	
	UNION ALL
	
	SELECT E.employee_id,E.first_name,E.last_name,E.title,E.reports_to,EH.LEVEL+1 AS LEVEL
	FROM 
	public.employees E 
	JOIN 
	EMP_HIER EH
	ON EH.employee_id=E.reports_to
)

SELECT LEVEL,employee_id,first_name,last_name,title,reports_to FROM EMP_HIER

--------------------------
/* 1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
*/

CREATE VIEW vw_updatable_products AS
	SELECT
		product_id,
		product_name,
		unit_price,
		units_in_stock,
		discontinued
	FROM public.products
	WHERE discontinued=0
	WITH CHECK OPTION

UPDATE vw_updatable_products SET unit_price = unit_price * 1.10 WHERE units_in_stock < 10

--Update the product price for products by 10% in category id=1
--Try COMMIT and ROLLBACK and observe what happens.

DO $$
BEGIN
	UPDATE  public.products SET unit_price=unit_price * 1.10
	WHERE category_id=1;
END $$;
ROLLBACK;
-- 	SELECT * FROM public.products 
-- 		WHERE category_id=1

/*3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
*/

CREATE OR REPLACE VIEW employee_territories_desc AS
	SELECT emp.employee_id,
	(emp.first_name||' '||emp.last_name ) Employee_full_name,
	emp.title,
	terr.territory_id,
	terr.territory_description,
	reg.region_description
	FROM public.employees emp 
		inner join public.employee_territories eterr
		on emp.employee_id=eterr.employee_id
		left join public.territories terr 
		on eterr.territory_id=terr.territory_id
		left join public.region reg 
		on terr.region_id=reg.region_id
	
	






























