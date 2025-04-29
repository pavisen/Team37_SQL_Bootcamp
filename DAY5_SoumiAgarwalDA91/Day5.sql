--1.      GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

SELECT EXTRACT(YEAR FROM order_date) order_year,EXTRACT(QUARTER FROM order_date) order_QUARTER,COUNT(order_id) ORDER_COUNT,
ROUND(AVG(freight)::NUMERIC,2) AVG_FREIGHT
FROM public.orders
WHERE freight>100
GROUP BY EXTRACT(YEAR FROM order_date),EXTRACT(QUARTER FROM order_date)
ORDER BY EXTRACT(YEAR FROM order_date) ,EXTRACT(QUARTER FROM order_date) 

--2.      GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost
-- Filter regions where no of orders >= 5

SELECT ship_region,COUNT(order_id) no_of_orders, MAX(freight),MIN(freight)
FROM public.orders
WHERE ship_region IS NOT NULL
GROUP BY ship_region
HAVING COUNT(order_id)>=5
ORDER BY COUNT(order_id) DESC

--Get all title designations across employees and customers 
	SELECT DISTINCT contact_title FROM public.customers
	UNION
	SELECT DISTINCT title FROM public.employees
--UNION ALL
SELECT DISTINCT contact_title FROM public.customers
	UNION ALL
	SELECT DISTINCT title FROM public.employees

--4.      Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)

SELECT DISTINCT category_id FROM public.products WHERE discontinued=1

INTERSECT

SELECT DISTINCT category_id FROM public.products WHERE units_in_stock>0

--5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT order_id FROM public.order_details
EXCEPT 
SELECT DISTINCT order_id FROM public.order_details WHERE discount>0








































