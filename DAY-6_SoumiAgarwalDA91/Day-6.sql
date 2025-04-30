 /*1.     Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock') */
	   
	SELECT product_name,units_in_stock,
		CASE WHEN units_in_stock=0 THEN 'OUT OF STOCK'
			WHEN units_in_stock<20 THEN 'LOW STOCK'
			ELSE 'GOOD STOCK'
			END AS STOCK_STATUS
	FROM public.products  
	
--2.      Find All Products in Beverages Category
--(Subquery, Display product_name,unitprice)

SELECT DISTINCT product_name, unit_price FROM public.products
	WHERE category_id=
		(SELECT DISTINCT category_id FROM public.categories WHERE  
			category_name='Beverages')
			ORDER BY unit_price

/*3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
*/

SELECT order_id,order_date,freight,employee_id FROM public.orders 
WHERE employee_id=
	(SELECT employee_id FROM  public.orders 
	GROUP BY employee_id 
	ORDER BY COUNT(order_id) DESC 
	LIMIT 1)
ORDER BY order_date DESC

/*4.      Find orders  where for country!= ‘USA’ 
with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators) */

SELECT * FROM public.orders WHERE 
ship_country !='USA' AND freight> ANY
	(
		SELECT DISTINCT freight FROM public.orders WHERE ship_country='USA' ORDER BY freight
	)
SELECT * FROM public.orders WHERE 
ship_country !='USA' AND freight> ALL
	(
		SELECT DISTINCT freight FROM public.orders WHERE ship_country='USA' ORDER BY freight
	)








































